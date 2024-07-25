import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gasht/main.dart';
import 'package:http/http.dart';

import '../../prefManager.dart';
import '../firebase/chatUserDataModel.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'newMessage.dart';


class APIs {
  // for authentication
  //static FirebaseAuth auth = FirebaseAuth.instance;

  // for accessing cloud firestore database
  static FirebaseFirestore firestore = FirebaseFirestore.instance;



  // for accessing firebase storage
  static FirebaseStorage storage = FirebaseStorage.instance;

  // for storing self information
  static ChatUser me = ChatUser(
      id: uid,
      name: "user.displayName.toString()",
      email: uid,
      about: "Hey, I'm using We Chat!",
      image: "user.photoURL.toString()",
      createdAt: '',
      isOnline: false,
      lastActive: '',
      pushToken: '');

  // to return current user
  // static User get user => auth.currentUser!;

  // for accessing firebase messaging (Push Notification)
  static FirebaseMessaging fMessaging = FirebaseMessaging.instance;


  // for getting firebase messaging token
  static Future<void> getFirebaseMessagingToken() async {

    await fMessaging.requestPermission();

    await fMessaging.getToken().then((t) {
      if (t != null) {
        me.pushToken = t;
        log('Push Token: $t');
      }
    });

    // for handling foreground messages
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   log('Got a message whilst in the foreground!');
    //   log('Message data: ${message.data}');

    //   if (message.notification != null) {
    //     log('Message also contained a notification: ${message.notification}');
    //   }
    // });
  }

  // for sending push notification
  static Future<void> sendPushNotification(
      ChatUser chatUser, String msg) async {
    try {
      final body = {
        "to": chatUser.pushToken,
        "notification": {
          "title": me.name, //our name should be send
          "body": msg,
          "android_channel_id": "chats"
        },
        // "data": {
        //   "some_data": "User ID: ${me.id}",
        // },
      };

      var res = await post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader:
            'Bearer AAAAiX4SWrY:APA91bE0ZU7RwIkzLM9xN4HaQNvhQN5cppympyTRXV6m-KpBQMSsQ-_y0x3sRWsIhb9TZRRZM_vZGEcfn2fvU90i1Hzdvx1WPFjMRsFkdi-aWkICWCnFLoqQkj_aSxq8mmwhMwsqLW1j '   },
          body: jsonEncode(body));
      log('Response status  notification : ${res.statusCode}');
      log('Response body:notification ${res.body}');
    } catch (e) {
      log('\nsendPushNotificationE: $e');
    }
  }

  // for checking if user exists or not?
  static Future<bool> userExists() async {

    // String? token = await PrefManager.getString("token");


    return (await firestore.collection('users').doc(uid).get()).exists;
  }

  // for adding an chat user for our conversation
  static Future<bool> addChatUser(String email) async {
    //  String? token = await PrefManager.getString("token");

    final data = await firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    log('user added: ${data.docs}');

    if (data.docs.isNotEmpty && data.docs.first.id != uid) {
      //user exists

      log('user exists: ${data.docs.first.data()}');

      firestore
          .collection('users')
          .doc(uid)
          .collection('my_users')
          .doc(data.docs.first.id)
          .set({});

      return true;
    } else {
      //user doesn't exists

      return false;
    }
  }

  // for getting current user info
  static Future<void> getSelfInfo() async {
    //  String? token = await PrefManager.getString("token");

    firestore.enableNetwork();

    log("====>>>> ${firestore.enableNetwork()}");

    final doc =   await FirebaseFirestore.instance.collection('users').doc(uid).get().then((user) async {

      if (user.exists) {
        me = ChatUser.fromJson(user.data()!);
        await getFirebaseMessagingToken();

        //for setting user status to activ    e
        APIs.updateActiveStatus(true);
        // log('My Data: ${user.data()}');
      } else {
        await createUser().then((value) => getSelfInfo());
      }
    });
  }

  // for creating a new user
  static Future<void> createUser() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    // String? token = await PrefManager.getString("token");

    final chatUser = ChatUser(
        id: uid,
        name: uName,
        email: uid,
        about: "Hey, $uid",
        image: "user.photoURL.toString()",
        createdAt: time,
        isOnline: false,
        lastActive: time,
        pushToken: '');

    return await firestore
        .collection('users')
        .doc(uid)
        .set(chatUser.toJson());
  }

  // for getting id's of known users from firestore database
  static Stream<QuerySnapshot<Map<String, dynamic>>> getMyUsersId(String useruid) {


    return firestore
        .collection('users')
        .doc(useruid)
        .collection('my_users')
        .snapshots();
  }

  // for getting all users from firestore database
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers(
      List<String> userIds) {
    log('\nUserIds: $userIds');

    return firestore
        .collection('users')
        .where('id', whereIn: userIds.isEmpty ? [''] : userIds)   //because empty list throws an error
    // .where('id', isNotEqualTo: token!)
        .snapshots();
  }

  // for adding an user to my user when first message is send
  static Future<void> sendFirstMessage(
      ChatUser chatUser, String msg, Type type) async {
    await firestore
        .collection('users')
        .doc(chatUser.id)
        .collection('my_users')
        .doc(uid)
        .set({}).then((value) => sendMessage(chatUser, msg, type));
  }

  // for updating user information
  static Future<void> updateUserInfo() async {
    // String? token = await PrefManager.getString("token");

    await firestore.collection('users').doc(uid).update({
      'name': me.name,
      'about': me.about,

    });
  }

  // update profile picture of user
/*
  static Future<void> updateProfilePicture(File file) async {
    //getting image file extension
    final ext = file.path.split('.').last;
    log('Extension: $ext');

    //storage file ref with path
    final ref = storage.ref().child('profile_pictures/${token!}.$ext');

    //uploading image
    await ref
        .putFile(file, SettableMetadata(contentType: 'image/$ext'))
        .then((p0) {
      log('Data Transferred: ${p0.bytesTransferred / 1000} kb');
    });

    //updating image in firestore database
    me.image = await ref.getDownloadURL();
    await firestore
        .collection('users')
        .doc(token!)
        .update({'image': me.image});
  }
*/

  // for getting specific user info
  static Stream<QuerySnapshot<Map<String, dynamic>>> getUserInfo(
      ChatUser chatUser) {
    return firestore
        .collection('users')
        .where('id', isEqualTo: chatUser.id)
        .snapshots();
  }

  // update online or last active status of user
  static Future<void> updateActiveStatus(bool isOnline) async {
    // String? token = await PrefManager.getString("token");

    firestore.collection('users').doc(uid).update({
      'is_online': isOnline,
      'last_active': DateTime.now().millisecondsSinceEpoch.toString(),
      'push_token': me.pushToken,
    });

    log("==>>>> pushtoken updated ==>>${me.pushToken}");

  }

  ///************** Chat Screen Related APIs **************

  // chats (collection) --> conversation_id (doc) --> messages (collection) --> message (doc)

  // useful for getting conversation id
  static String getConversationID(String id) => uid.hashCode <= id.hashCode
      ? '${uid}_$id'
      : '${id}_$uid';

  // for getting all messages of a specific conversation from firestore database
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(
      ChatUser user) {
    return firestore
        .collection('chats/${getConversationID(user.id)}/messages/')
        .orderBy('sent', descending: true)
        .snapshots();

  }

  // for sending message
  static Future<void> sendMessage(
      ChatUser chatUser, String msg, Type type) async {
    //message sending time (also used as id)
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    //  String? token = await PrefManager.getString("token");

    //message to send
    final Message message = Message(

        toId: chatUser.id,
        msg: msg,
        read: '',
        type: type,
        fromId: uid,
        sent: time

    );

    final ref = firestore
        .collection('chats/${getConversationID(chatUser.id)}/messages/');
    await ref.doc(time).set(message.toJson()).then((value) =>
        sendPushNotification(chatUser, type == Type.text ? msg : 'image'));
  }

  //update read status of message
  static Future<void> updateMessageReadStatus(Message message) async {
    firestore
        .collection('chats/${getConversationID(message.fromId)}/messages/')
        .doc(message.sent)
        .update({'read': DateTime.now().millisecondsSinceEpoch.toString()});
  }

  //get only last message of a specific chat
  static Stream<QuerySnapshot<Map<String, dynamic>>> getLastMessage(
      ChatUser user) {

    print("getLastMessage ${user.name}");

    return firestore
        .collection('chats/${getConversationID(user.id)}/messages/')
        .orderBy('sent', descending: true)
        .limit(1)
        .snapshots();
  }
/*
 static   Future<List<ChatUser>> _sortUsersByLastMessageTime(List<ChatUser> users) async {
   // var firestore = FirebaseFirestore.instance;

    // A map to hold the latest message timestamp for each user
    Map<ChatUser, DateTime> userLastMessageTime = {};

    for (var user in users) {
     // var conversationID = getConversationID(user.id);
      // Assuming getConversationID returns a single ID for simplicity
      var snapshot = await firestore
          .collection('chats/${getConversationID(user.id)}/messages/')
          .orderBy('sent', descending: true)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        var lastMessage = snapshot.docs.first;
        var sentTimeValue = lastMessage.data()['sent'];
        DateTime sentTime;

        // Check the type of sentTimeValue and convert accordingly
        if (sentTimeValue is Timestamp) {
          sentTime = sentTimeValue.toDate();
        } else if (sentTimeValue is String) {
          sentTime = DateTime.fromMillisecondsSinceEpoch(int.parse(sentTimeValue));
        } else if (sentTimeValue is int) { // Directly handling int type
          sentTime = DateTime.fromMillisecondsSinceEpoch(sentTimeValue);
        } else {
          // Handle unexpected type appropriately, perhaps log an error or use a default date
          continue; // Skipping this user or using a default date might be necessary
        }

        userLastMessageTime[user] = sentTime;
      }
    }

    // Convert the map to a list of entries and sort by the DateTime value
    var sortedUsers = userLastMessageTime.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value)); // Sort in descending order

    // Extract and return the sorted list of users
  //  return Stream.fromFuture(sortedUsers.map((entry) => entry.key).toList());






    return sortedUsers.map((entry) => entry.key).toList();









  }


  static Stream<List<ChatUser>> sortUsersByLastMessageTime(List<ChatUser> users) {


    return Stream.fromFuture(_sortUsersByLastMessageTime(users));


  }*/

 static Stream<List<ChatUser>> sortUsersByLastMessageTime(List<ChatUser> users) {
    // Wrap the entire sorting logic inside a Future
    futureSortedUsers() async {
      Map<ChatUser, DateTime> userLastMessageTime = {};

      for (var user in users) {
        var snapshot = await firestore
            .collection('chats/${getConversationID(user.id)}/messages/')
            .orderBy('sent', descending: true)
            .limit(1)
            .get();

        if (snapshot.docs.isNotEmpty) {
          var lastMessage = snapshot.docs.first;
          var sentTimeValue = lastMessage.data()['sent'];
          DateTime sentTime;

          if (sentTimeValue is Timestamp) {
            sentTime = sentTimeValue.toDate();
          } else if (sentTimeValue is String) {
            sentTime = DateTime.fromMillisecondsSinceEpoch(int.parse(sentTimeValue));
          } else if (sentTimeValue is int) {
            sentTime = DateTime.fromMillisecondsSinceEpoch(sentTimeValue);
          } else {
            continue; // Skip this user or use a default date
          }

          userLastMessageTime[user] = sentTime;
        }
      }

      var sortedUsers = userLastMessageTime.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));

      return sortedUsers.map((entry) => entry.key).toList();
    }

    // Return a stream that emits the result of the future
    return Stream.fromFuture(futureSortedUsers());
  }


  static Future<List<ChatUser>> newsortUsersByLastMessageTime(List<ChatUser> users) async {
    // Directly include the sorting logic without wrapping in a separate function
    Map<ChatUser, DateTime> userLastMessageTime = {};

    for (var user in users) {
      var snapshot = await firestore
          .collection('chats/${getConversationID(user.id)}/messages/')
          .orderBy('sent', descending: true)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        var lastMessage = snapshot.docs.first;
        var sentTimeValue = lastMessage.data()['sent'];
        DateTime sentTime;

        if (sentTimeValue is Timestamp) {
          sentTime = sentTimeValue.toDate();
        } else if (sentTimeValue is String) {
          sentTime = DateTime.fromMillisecondsSinceEpoch(int.parse(sentTimeValue));
        } else if (sentTimeValue is int) {
          sentTime = DateTime.fromMillisecondsSinceEpoch(sentTimeValue);
        } else {
          continue; // Skip this user or use a default date
        }

        userLastMessageTime[user] = sentTime;
      }
    }

    var sortedUsers = userLastMessageTime.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return sortedUsers.map((entry) => entry.key).toList();
  }


  static final _messagesStreamController = StreamController<List<ChatUser>>.broadcast();

  static Stream<List<ChatUser>> get messagesStream => _messagesStreamController.stream;









  //update message
  static Future<void> updateMessage(Message message, String updatedMsg) async {
    await firestore
        .collection('chats/${getConversationID(message.toId)}/messages/')
        .doc(message.sent)
        .update({'msg': updatedMsg});
  }

  static Stream<ChatUser> getChatUserAndNavigate(String userUid,String ownerId) {
    return firestore
        .collection('users')
        .doc(userUid)
        .collection('my_users')
        .snapshots()
        .asyncMap((QuerySnapshot<Map<String, dynamic>> myUsersSnapshot) async {

      final myUsersDocs = myUsersSnapshot.docs;
      final myUsersIds = myUsersDocs.map((e) => e.id).toList();





      final firstUserId = myUsersIds.first;


      log("===>> user lists  ==== ${myUsersIds.toString()},,,, user $userUid");


      final chatUserSnapshot = await firestore
          .collection('users')
          .doc(ownerId)
          .get();

      final chatUserData = chatUserSnapshot.data();
      return ChatUser.fromJson(chatUserData!);
    });
  }



}