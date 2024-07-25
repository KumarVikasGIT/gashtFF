/*

import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gasht/ui/messages/firebase/chat_screen.dart';
import 'package:get/get.dart';

import '../../main.dart';
import '../../util/dialogs.dart';
import '../../util/my_date_util.dart';
import '../prefManager.dart';
import 'firebase/chatUserDataModel.dart';
import 'firebase/firebase.dart';
import 'firebase/newMessage.dart';
import 'firebase/usercard.dart';


class Messages extends StatefulWidget{
  const Messages({super.key});

  @override
  State<Messages> createState() => _Messages ();

}

class _Messages extends State<Messages>  with WidgetsBindingObserver {



 // List<ChatUser> _list = [];

  RxList<ChatUser> _list = <ChatUser>[].obs;

  // for storing searched items
  final List<ChatUser> _searchList = [];


  // for storing search status
  final bool _isSearching = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

  }
  @override
  void setState(fn1) {

    super.setState(fn1);
  }
  @override
  void deactivate() {

    super.deactivate();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:

        break;
      case AppLifecycleState.resumed:
        print("=====>>>>>>>####### messages refreshed ");

        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content:const Text(
                'message updated').tr(),
              backgroundColor: Colors.green,));


        setState(() {
         print("=====>>>>>>>####### messages refreshed setState");
       });
        break;
      case AppLifecycleState.paused:

        break;
      case AppLifecycleState.detached:

        break;
      case AppLifecycleState.hidden:
      // TODO: Handle this case.
    }
  }


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    APIs.getSelfInfo();


    //for updating user active status according to lifecycle events
    //resume -- active or online
    //pause  -- inactive or offline
    SystemChannels.lifecycle.setMessageHandler((message) async {
      log('Message: $message');
      String? token = await PrefManager.getString("token");

      if (token != null) {
        if (message.toString().contains('resume')) {




          //token1 = token;



          APIs.updateActiveStatus(true);
        }
        if (message.toString().contains('pause')) {
          APIs.updateActiveStatus(false);
        }
      }

      return Future.value(message);
    });
  }








  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title:  Text(tr("messages")),automaticallyImplyLeading: false,),

      body:
      StreamBuilder(

        stream: APIs.getMyUsersId(uid),

        //get id of only known users
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
          //if data is loading
            case ConnectionState.waiting:
            case ConnectionState.none:
              return const Center(child: CircularProgressIndicator());

          //if some or all data is loaded then show it
            case ConnectionState.active:
            case ConnectionState.done:
              return StreamBuilder(
                stream: APIs.getAllUsers(
                    snapshot.data?.docs.map((e) => e.id).toList() ?? []),

                //get only those user, who's ids are provided
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                  //if data is loading
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                    // return const Center(
                    //     child: CircularProgressIndicator());

                    //if some or all data is loaded then show it
                    case ConnectionState.active:
                    case ConnectionState.done:
                      final data = snapshot.data?.docs;
                    var  list = data
                          ?.map((e) => ChatUser.fromJson(e.data()))
                          .toList() ??
                          [];



                    print("message data 1");

                      if (list.isNotEmpty) {


                     //   getSortedList(list);




                    return  StreamBuilder<List<ChatUser>>(


                        stream: APIs.sortUsersByLastMessageTime(list) ,

                        builder: (context,snapshot) {
                          if (snapshot.hasData) {

                          */
/* setState(() {
                             _list = snapshot.data!;

                           }) ;*//*



                           // _list = snapshot.data!;

                            _list = snapshot.data!.obs;

                            print("message data 2");


                            return ListView.builder(
                                itemCount: _list.length,
                                padding: const EdgeInsets.only(top: 1),
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  Message? _message;
                                  return Card(
                                      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                                      // color: Colors.blue.shade100,
                                      elevation: 0.5,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                      child: InkWell(
                                          onTap: () {
                                            //for navigating to chat screen
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) => ChatScreen(user: _list[index])));
                                          },
                                          child: StreamBuilder(
                                            stream: APIs.getLastMessage(_list[index]),
                                            builder: (context, snapshot) {
                                              final data = snapshot.data?.docs;
                                              final list =
                                                  data?.map((e) => Message.fromJson(e.data())).toList() ?? [];

                                              Future<String?> token = getToken();

                                              if (list.isNotEmpty) _message = list[0];



                                              print("last messgage list message screen ====$list");

                                              return ListTile(
                                                //user profile picture
                                                leading: InkWell(
                                                  onTap: () {
                                                    */
/*     showDialog(
                        context: context,
                        builder: (_) => ProfileDialog(user: widget.user));*//*

                                                  },
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(3),
                                                    child: CachedNetworkImage(
                                                      width: mq.height * .055,
                                                      height: mq.height * .055,
                                                      imageUrl: _list[index].image,
                                                      errorWidget: (context, url, error) => const CircleAvatar(
                                                          child: Icon(CupertinoIcons.person)),
                                                    ),
                                                  ),
                                                ),

                                                //user name
                                                title: Text(_list[index].name),

                                                //last message
                                                subtitle: Text(
                                                    _message != null
                                                        ? _message!.type == Type.image
                                                        ? 'image'
                                                        : _message!.msg
                                                        : _list[index].about,
                                                    maxLines: 1),

                                                //last message time
                                                trailing: _message == null
                                                    ? null //show nothing when no message is sent
                                                    : _message!.read.isEmpty &&
                                                    _message!.fromId != token.toString()
                                                    ?
                                                //show for unread message
                                                Container(
                                                  width: 15,
                                                  height: 15,
                                                  decoration: BoxDecoration(
                                                      color: Colors.greenAccent.shade400,
                                                      borderRadius: BorderRadius.circular(10)),
                                                )
                                                    :
                                                //message sent time
                                                Text(
                                                  MyDateUtil.getLastMessageTime(
                                                      context: context, time: _message!.sent),
                                                  style: const TextStyle(color: Colors.black54),
                                                ),
                                              );
                                            },
                                          )),
                                    );


                                   */
/* ChatUserCard(
                                      user: _isSearching
                                          ? _searchList[index]
                                          : _list[index]);*//*

                                });
                          }

                          else {
                            return const Center(
                              child: Text('No Chats Found',
                                  style: TextStyle(fontSize: 20)),
                            );
                          }
                        }

                      );



                      }

                      else {
                           return const Center(
                          child: Text('No Connections Found!',
                              style: TextStyle(fontSize: 20)),
                        );
                      }
                  }
                },
              );
          }
        },
      )

    );
  }
  Future<String?>  getToken() async {

    return await PrefManager.getString("userId");

  }

  void getState() {
    setState(() {

      print("stateset");
    });

  }

}


*/


import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../main.dart';
import '../../util/my_date_util.dart';
import '../prefManager.dart';
import 'firebase/firebase.dart';
import 'firebase/chatUserDataModel.dart';
import 'firebase/chat_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'firebase/newMessage.dart';

class Messages extends StatefulWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  State<Messages> createState() => _Messages();
}

class _Messages extends State<Messages> with WidgetsBindingObserver {
  RxList<ChatUser> _list = <ChatUser>[].obs;
  final List<ChatUser> _searchList = [];

  late StreamSubscription<List<ChatUser>> _messageSubscription;

  bool first = false;



  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    APIs.getSelfInfo();

    fetchChatList();

    //first = true;


    // Rest of your initState() code
  }

  @override
  void dispose() {
    _messageSubscription.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tr("messages")), automaticallyImplyLeading: false),
      body:
      StreamBuilder(
        stream: APIs.getMyUsersId(uid),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.none:
              return const Center(child: CircularProgressIndicator());
            case ConnectionState.active:
            case ConnectionState.done:
              return StreamBuilder(
                stream: APIs.getAllUsers(snapshot.data?.docs.map((e) => e.id).toList() ?? []),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return const Center(child: CircularProgressIndicator());
                    case ConnectionState.active:
                    case ConnectionState.done:
                      final data = snapshot.data?.docs;
                       _list.value = data?.map((e) => ChatUser.fromJson(e.data())).toList() ?? [];

                      if (_list.isNotEmpty) {
                        return Obx(() =>
                            ListView.builder(
                              itemCount: _list.length,
                              padding: const EdgeInsets.only(top: 1),
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                Message? message;
                                return Card(
                                  margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                                  elevation: 0.5,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                  child: InkWell(
                                    onTap: () {


                                      Navigator.push(context, MaterialPageRoute(builder: (_) =>
                                          ChatScreen(user: _list[index]))).then((value) {

                                        Future.delayed(const Duration(milliseconds: 3000))
                                            .then((value) {
                                          fetchChatList();
                                        }
                                        );
                                      }
                                      );
                                    },
                                    child: StreamBuilder(
                                      stream: APIs.getLastMessage(_list[index]),
                                      builder: (context, snapshot) {
                                        final data = snapshot.data?.docs;
                                        final list = data?.map((e) => Message.fromJson(e.data())).toList() ?? [];

                                        Future<String?> token = getToken();

                                        if (list.isNotEmpty) message = list[0];


                                        if(first)
                                        {

                                          // getListUpdate();


                                          getState();


                                        }
                                        else
                                        {
                                          if(_list.length-1 == index)
                                          {

                                            first= true;
                                            print(" first time ==$first");

                                          }
                                          else
                                          {
                                            print("index == $index, list length == ${_list.length}");  }
                                        }



                                        print("getLastMessage messgae => ${message?.msg}}");


                                        return ListTile(
                                          leading: InkWell(
                                            onTap: () {},
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(3),
                                              child: CachedNetworkImage(
                                                width: mq.height * .055,
                                                height: mq.height * .055,
                                                imageUrl: _list[index].image,
                                                errorWidget: (context, url, error) => const CircleAvatar(child: Icon(CupertinoIcons.person)),
                                              ),
                                            ),
                                          ),
                                          title: Text(_list[index].name),
                                          subtitle: Text(message != null ? (message!.type == Type.image ? 'image' : message!.msg) : _list[index].about, maxLines: 1),
                                          trailing: message == null
                                              ? null
                                              : message!.read.isEmpty && message!.fromId != token.toString()
                                              ? Container(
                                            width: 15,
                                            height: 15,
                                            decoration: BoxDecoration(color: Colors.purple.shade400, borderRadius: BorderRadius.circular(10)),
                                          )
                                              : Text(MyDateUtil.getLastMessageTime(context: context, time: message!.sent), style: const TextStyle(color: Colors.black54)),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),

                        );
                      } else {
                        return const Center(child: Text('No Chat Found!', style: TextStyle(fontSize: 20)));
                      }
                  }
                },
              );
          }
        },
      ),

      floatingActionButton: FloatingActionButton(onPressed: (){
       getState();

      },
        child: const Icon(Icons.refresh),
      ),

    );
  }

  Future<String?> getToken() async {
    return await PrefManager.getString("userId");
  }

  Future<void> getState() async {

    var model = await APIs.newsortUsersByLastMessageTime(_list);

    _list.value = model.obs;
    print("first ===>>$first");





  }
  fetchChatList() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          print("mounted ===>>$mounted");

          //_isFetching = true;
        });
      }
      else
        {
          setState(() {
            print("mounted  ===>>else case $mounted");

          });
        }

    });
  }


}

