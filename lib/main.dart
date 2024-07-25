import 'dart:async';
import 'dart:developer';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:gasht/ui/controllers/langaugeCotroller.dart';
import 'package:gasht/ui/dashboard/bottomDashboard.dart';
import 'package:gasht/ui/landlord/bottomLandlord.dart';
import 'package:gasht/ui/messages/firebase/firebase.dart';
import 'package:gasht/ui/notification.dart';
import 'package:gasht/ui/prefManager.dart';
import 'package:gasht/util/colors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:gasht/multiLang/dependency_inj.dart' as dep;
import 'package:restart_app/restart_app.dart';

import 'dummy.dart';
import 'multiLang/app_constants.dart';
import 'multiLang/language_controller.dart';
import 'multiLang/messages.dart';

import 'package:flutter_notification_channel/flutter_notification_channel.dart';
import 'package:flutter_notification_channel/notification_importance.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'tranlations/codegen_loader.g.dart';
import 'package:url_strategy/url_strategy.dart';


late Size mq;
late String uid;
late String uName;
String ? lang;




Future<void> main() async {
 // WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

 // setPathUrlStrategy();

  NotificationHandler().initialize();
 // await Firebase.initializeApp();


  //final TranslationController _translationController = Get.find<TranslationController>();



    //FirebaseMessaging.instance.requestPermission();

  final TranslationController _translationController = Get.put(TranslationController());


  _translationController.onInit();
  await _initializeFirebase();
  //  Map<String, Map<String, String>> languages = await dep.init();

//  runApp(MyApp(languages: _languages));
  runApp(
    EasyLocalization(
    supportedLocales: const [Locale('en'), Locale('ar'),Locale('fa')],
    path: 'assets/l10n', // Path to your translations
    fallbackLocale: const Locale('en'),
    assetLoader: const CodegenLoader(),


    child:  MyApp(),
  ),);
}
_initializeFirebase() async {



  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  var result = await FlutterNotificationChannel.registerNotificationChannel(
      description: 'For Showing Message Notification',
      id: 'chats',
      importance: NotificationImportance.IMPORTANCE_HIGH,
      name: 'Chats');


  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  firebaseMessaging.requestPermission(
    sound: true,
    badge: true,
    alert: true,
    provisional: false,
  );
  log('\nNotification Channel Result: $result');



}
class MyApp extends StatelessWidget {
//  final Map<String, Map<String, String>> languages;

   MyApp({super.key });


  String apiKey = "AIzaSyBsfiEq7rCvgeVL0vQxP4Dy63E8GocViXg";

  @override
  Widget build(BuildContext context) {

      return GetMaterialApp(
        title: "Safrati",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          //     iconTheme: const IconThemeData(color: Colors.black), // Set back button color to black
            primarySwatch: const MaterialColor(0xFF5A409B, <int, Color>{
              50: Color(0xFF5A409B),
              100: Color(0xFF5A409B),
              200: Color(0xFF5A409B),
              300: Color(0xFF5A409B),
              400: Color(0xFF5A409B),
              500: Color(0xFF5A409B),
              600: Color(0xFF5A409B),
              700: Color(0xFF5A409B),
              800: Color(0xFF5A409B),
              900: Color(0xFF5A409B),
            })
        ),
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,

        // translations: Messages(languages:languages ),

        home: const MyHomePage(),



      );


  }
}



class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});


  @override
  _MyHomePageState createState() => _MyHomePageState();

/* @override
  _MyHomePageState createState() => _MyHomePageState();*/
}
class _MyHomePageState extends State<MyHomePage> {
  final logger = Logger();
  late bool logged;




  @override
  void initState() {
    super.initState();


    _initializeScreen();

  }

  Future<void> _initializeScreen() async {

    if(await getToken())
    {

      if(await userTypeOwner())
        {
          logger.d("owner======>>>>>>> yes");

          Timer(const Duration(seconds: 4), () =>
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) =>
              const BottomLandlord()
              )
              )
          );
        }
      else {
        //logged = true;
        logger.d("owner======>>>>>>> noooooooo");

        Timer(const Duration(seconds: 4), () =>
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) =>
            const DashboardBottom()
            )
            )
        );
      }
    }
    else
    {
      logger.d("firsttime if 1 no else yes");
      if(await firstTime())
        {
          logger.d("firsttime if 1 no else yes");

          Timer(const Duration(seconds: 4), ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
          const DashboardBottom()
          )
          )
          );
        }

     else  if(await langChanges())
        {
          Timer(const Duration(seconds: 1), () =>
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) =>
                  const ThirdScreen())));
        }

      else {
        logger.d("firstTime if 0 ");

        // logged = false;
        Timer(const Duration(seconds: 1), () =>
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) =>
             SecondScreen())));

      }
    }




  }




  @override
  Widget build(BuildContext context) {

    mq = MediaQuery.of(context).size;


    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(

            image: AssetImage("assets/images/gradient_bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child:Center(child:  Image.asset("assets/images/app_text_1.png",),
            )

      /* Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/app_logo.png",height: 250,),
            Container(
              margin: const EdgeInsets.only(left: 10,right: 10,bottom: 25),
              child: Image.asset("assets/images/app_text.png"),
            )


          ],
        ),
      */
      ),
    );
  }


  Future<bool> langChanges()
  async {

    String? chang = await PrefManager.getString("changeLang");

    if(chang ==null)
      {
        return false;
      }
    else
      {
        return true;
      }



  }


// Assuming PrefManager.getString("token") returns a Future<String?>
  Future<bool> getToken() async {
    String? token = await PrefManager.getString("token");
    String? userId = await PrefManager.getString("userId");
    String? name  = await PrefManager.getString("name");

     lang  = await PrefManager.getString("lang");

    print("device locaocle  ==== >>>${context.deviceLocale.toString()}");
    print("device lang  ==== >>>${lang}");


    if (token != null && userId !=null) {

      uid= userId;
      uName = name!;
      APIs.getSelfInfo();
      logger.d("main dashboard  $token  ++ uid $uid");
      return true;
    } else {
      logger.d("main dashboard  null");
      return false;
    }
  }
  Future<bool> userTypeOwner() async {
    String? owner = await PrefManager.getString("owner");

    if (owner == "Owner") {
      logger.d("owner dashboard  $owner");
      return true;
    } else {
      logger.d("owner dashboard  null");
      return false;
    }
  }
  Future<bool> firstTime() async {
   // String? token = await PrefManager.getString("token");
    String? firstTime = await PrefManager.getString("firstTime");
    logger.d("firstTime token ===$firstTime");

    if (firstTime != null) {
      logger.d("firstTime dashboard  $firstTime");
      return true;
    } else {
      logger.d("firstTime dashboard  null");
      return false;
    }
  }


}
class SecondScreen extends StatelessWidget {
   SecondScreen({super.key});

  //final TranslationController _translationController = Get.put(TranslationController());
  // final TopChefsController controllerTopChefs = Get.put(TopChefsController());

   final TranslationController _translationController = Get.put(TranslationController());

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,

          image: AssetImage("assets/images/gradient_bg.png"),
    ),
    ),
        child: Column(
          children: [
            // const   SizedBox(height: 60,),
            // Center(
            //   child: Image.asset("assets/images/splash2.png",height: 550,width: double.infinity,),
            //
            // ),
            const   SizedBox(height: 80,),
            Image.asset("assets/images/splash_new.png",height: 340,width: double.infinity,),
            const   SizedBox(height: 30,),
            Image.asset("assets/images/app_text_1.png",height: 125,width: 250,),
            const Spacer(),




//white language container
            Container(
              height: 150,
            //  color: Colors.white,
              decoration: const ShapeDecoration(
                color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                  )
              ),



              child: Column(
                children: [

              /*   const SizedBox(height: 5,),
                  FutureBuilder<String>(
                    future:
                    //_translationController.
                    getTransaltion("Select Language"),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // If the Future is still running, show a loading indicator
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        // If there is an error, display an error message
                        return Text('Error: ${snapshot.error}');
                      } else {
                        // If the Future is complete, display the data
                        return Text(
                          snapshot.data ?? '"Select Language', // Use ?? to provide a default value if data is null
                          style: TextStyle(fontSize: 18),
                        );
                      }
                    },
                  ),

                  const Divider(
                    thickness: 2,

                  ),*/


                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      SizedBox(
                        width: 135,
                        height: 40,
                        child:    ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.appColor,
                            elevation: 2.5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {

                          context.setLocale(const Locale('fa'));
                          _translationController.changeTargetLanguage("ku");

                          setLanguage();

                         /* Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
                          const ThirdScreen()
                          ));*/

                        }, child: Text("كوردى",style: TextStyle(color:Colors.white ,fontSize: 20,fontWeight: FontWeight.bold,fontFamily: GoogleFonts.harmattan().fontFamily)),
                        ) ,
                      ),



                      SizedBox(
                        width: 135,
                        height: 40,
                        child:    ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.appColor,
                            elevation: 2.5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ), onPressed: () {

                          context.setLocale(const Locale('ar'));

                          _translationController.changeTargetLanguage("ar");
                          setLanguage();

                        }, child: Text("کود",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold,fontFamily: GoogleFonts.harmattan().fontFamily)),
                        ) ,
                      ),


                    ],


                  ),



              Container(
                width: 135,
                height: 40,
                margin: const EdgeInsets.only(top: 15),

                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.appColor,
                    elevation: 2.5,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ), onPressed: () {

                  _translationController.changeTargetLanguage("en");


                  context.setLocale(const Locale('en'));

                  setLanguage();


                  /* Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
                  const ThirdScreen()

                  ));*/


                }, child: Text("English",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold,fontFamily: GoogleFonts.harmattan().fontFamily)),
                ),
              ),








                ],


              ),


            ),


          ],


        ),
      ),

    );
  }

 Future<String> getTransaltion(String s) async {

    return await "Select Language";
  }

  void setLanguage() {

     PrefManager.saveString("changeLang","yes");
     Restart.restartApp();

  }

  /*Future<String> getString(String s) async {
    return await _translationController.getTransaltion("Select English");
  }*/
}
class ThirdScreen extends StatefulWidget {
   const ThirdScreen({super.key});

  @override
  State<ThirdScreen> createState() => _ThirdScreen();

}


class _ThirdScreen extends State<ThirdScreen>
{
  String  imageurl="assets/images/swipe1.png";
  int currentIndexPage=0;
  String text = "discover_book_and_experience_daily_stays_effortlessly";

  final logger = Logger();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (details) {},
      /*  onHorizontalDragUpdate: (details) {
        if (details.delta.direction > 0) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => FourthScreen(key: key,)));
        }
      },*/
      child:Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/gradient_bg.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
         //   mainAxisAlignment: MainAxisAlignment.,
          //  crossAxisAlignment: ,
            children: [

              const Spacer(),

              Container(
                //height: 350,
                margin:  const EdgeInsets.fromLTRB(20,0,20,40),
                child:  Image.asset(imageurl),

              ),

             const SizedBox(height: 10,),

              Container(
                  margin:  const EdgeInsets.fromLTRB(20,0,20,20),

                  child: Text(text,style:  TextStyle(color: Colors.white,fontSize: 18, fontFamily: GoogleFonts.harmattan().fontFamily),).tr()),



              Container(
                margin:  const EdgeInsets.fromLTRB(0,10,20,0),
                child: DotsIndicator(
                  dotsCount: 3,
                  position: currentIndexPage,
                  decorator: const DotsDecorator(
                    color: Colors.white,
                    sizes: [
                      Size.square(10.0),
                      Size.square(15.0),
                      Size.square(20.0),
                    ],
                    activeSizes: [
                      Size.square(25.0),
                      Size.square(25.0),
                      Size.square(35.0),
                    ],
                  ),
                ),
              ),

              Container( //apply margin and padding using Container Widget.
                margin:  const EdgeInsets.fromLTRB(0,10,0,30),
                child:


                Container(
                  margin: const EdgeInsets.only(top: 15,left: 20,right: 20),
                  width: double.infinity,
                  height: 40,
                  child:    ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:Colors.white,
                      elevation: 2.5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ), onPressed: () {


                      setState(() {
                        currentIndexPage++;
                        logger.d("current index page == $currentIndexPage");

                        if(currentIndexPage==1)
                          {
                            imageurl="assets/images/swipe2.png";
                            text = "travel_made_simple_moments_made_special_find_unique_stays_with_us";
                          }
                        if(currentIndexPage==2)
                          {
                            imageurl="assets/images/swipe3.png";
                            text = "make_your_trip_unforgettable_Smooth_stays_and_great_memories!";
                          }
                        if(currentIndexPage==3)
                          {


                            PrefManager.saveString("firstTime", "1");
                            PrefManager.removeString("changeLang");





                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const DashboardBottom()));


                          }



                      });



                  }, child: Text("next",style: TextStyle(fontSize: 20,fontFamily: GoogleFonts.harmattan().fontFamily,
                      color: AppColors.appColor)).tr(),
                  ) ,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

