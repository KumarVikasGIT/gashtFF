import 'package:flutter/material.dart';
import 'package:gasht/ui/authentication/login.dart';
import 'package:gasht/ui/bookings/bookings.dart';
import 'package:gasht/ui/moreOptions/changeLanguage.dart';
import 'package:gasht/ui/moreOptions/faq.dart';
import 'package:gasht/ui/moreOptions/helpCenter.dart';
import 'package:gasht/ui/moreOptions/notification.dart';
import 'package:gasht/ui/moreOptions/termsofuse.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logger/logger.dart';

import '../../api/retrofit_interface.dart';
import '../../data_models/model_login.dart';
import '../../loadingScreen.dart';
import '../../main.dart';
import '../../util/colors.dart';
import '../controllers/langaugeCotroller.dart';
import '../moreOptions/profile.dart';
import '../prefManager.dart';
import 'bottomDashboard.dart';
import 'package:dio/dio.dart';
import '../../api/retrofit_interface.dart';

class More extends StatefulWidget {
  const More({super.key});

  @override
  State<More> createState() => _More();
}

class _More extends State<More> {
  bool logged = false;

  final FocusNode _focusNodePassword = FocusNode();
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  bool _obscurePassword = true;
  bool isChecked = false;
  late String message;
  final TranslationController _translationController = Get.put(TranslationController());




  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _initializeScreen();
  }

  Future<void> _initializeScreen() async {
    String? token = await PrefManager.getString("token");

    setState(() {
      if (token != null) {
        logged = true;
      } else {
        logged = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 55,
            ),

            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(left: 10),
              child:

              FutureBuilder(
                  future: _translationController.getTransaltion( "settings"),
                  builder: (context,snapshot){
                    if(snapshot.hasData)
                    {
                      return       Text(
                        snapshot.data!,
                        textAlign: TextAlign.center,

                        style: TextStyle(
                          color: const Color(0xFF121212),
                          fontSize: 18,
                          fontFamily: GoogleFonts.harmattan().fontFamily,
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    }
                    else
                    {
                      return
                        Text(
                          'Settings',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: const Color(0xFF121212),
                            fontSize: 18,
                            fontFamily: GoogleFonts.harmattan().fontFamily,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ;
                    }
                  }),


            ),

            const Divider(
              thickness: 2,
            ),

            const SizedBox(
              height: 10,
            ),

          /*  Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                Text(
                  'Reservation',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF555555),
                    fontSize: 15,
                    fontFamily: GoogleFonts.harmattan().fontFamily,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.75,
                  ),
                ),
                const Spacer(),
                Text(
                  '0',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: GoogleFonts.harmattan().fontFamily,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.75,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),

            const SizedBox(
              height: 20,
            ),


            const Divider(
              thickness: 2,
            ),*/

            const SizedBox(
              height: 20,
            ),

            //profile
            InkWell(
              onTap: () {
                if (logged) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Profile(
                          "Customer"), //const PlayList( tag: 'Playlists',title:'Podcast'),
                    ),
                  );
                } else {

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Login(
                          "Customer"), //const PlayList( tag: 'Playlists',title:'Podcast'),
                    ),
                  );

                  // showLogginScreen(context);
                }
              },
              child: Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  const Icon(
                    Icons.account_circle_outlined,
                    color: Color(0xFF555555),
                  ),
                  const SizedBox(
                    width: 20,
                  ),

                  FutureBuilder(future: _translationController.getTransaltion( "profile"),
                      builder: (context,snapshot){
                        if(snapshot.hasData)
                        {
                          return       Text(
                            snapshot.data!,
                            textAlign: TextAlign.center,

                            style: TextStyle(
                              color: const Color(0xFF323232),
                              fontSize: 16,
                              fontFamily: GoogleFonts.harmattan().fontFamily,
                              fontWeight: FontWeight.w400,
                            ),
                          );
                        }
                        else
                        {
                          return
                            Text(
                              'Profile',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color(0xFF323232),
                                fontSize: 16,
                                fontFamily: GoogleFonts.harmattan().fontFamily,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ;
                        }
                      }),



                ],
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            //bookings
            InkWell(
              onTap: () {
                if (logged) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                           Bookings("Customer"), //const PlayList( tag: 'Playlists',title:'Podcast'),
                    ),
                  );
                } else {

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Login(
                          "Customer"), //const PlayList( tag: 'Playlists',title:'Podcast'),
                    ),
                  );
                  //showLogginScreen(context);
                }
              },
              child: Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  const Icon(
                    Icons.calendar_month_outlined,
                    color: Color(0xFF555555),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  FutureBuilder(future: _translationController.getTransaltion( "booking"),
                      builder: (context,snapshot){
                        if(snapshot.hasData)
                        {
                          return       Text(
                            snapshot.data!,
                            textAlign: TextAlign.center,

                            style: TextStyle(
                              color: const Color(0xFF323232),
                              fontSize: 16,
                              fontFamily: GoogleFonts.harmattan().fontFamily,
                              fontWeight: FontWeight.w400,
                            ),
                          );
                        }
                        else
                        {
                          return
                            Text(
                              'Booking',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color(0xFF323232),
                                fontSize: 16,
                                fontFamily: GoogleFonts.harmattan().fontFamily,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ;
                        }
                      }),

                ],
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            //payment
           /* Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                const Icon(
                  Icons.payment,
                  color: Color(0xFF555555),
                ),
                const SizedBox(
                  width: 20,
                ),
                FutureBuilder(future: _translationController.getTransaltion( "Payment"),
                    builder: (context,snapshot){
                      if(snapshot.hasData)
                      {
                        return       Text(
                          snapshot.data!,
                          textAlign: TextAlign.center,

                          style: TextStyle(
                            color: const Color(0xFF323232),
                            fontSize: 14,
                            fontFamily: GoogleFonts.harmattan().fontFamily,
                            fontWeight: FontWeight.w400,
                          ),
                        );
                      }
                      else
                      {
                        return
                          Text(
                            'Payment',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFF323232),
                              fontSize: 14,
                              fontFamily: GoogleFonts.harmattan().fontFamily,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ;
                      }
                    }),

              ],
            ),

            const SizedBox(
              height: 20,
            ),*/

            //Notification

            InkWell(
              onTap: () {

               if(logged) {
                 Navigator.push(
                   context,
                   MaterialPageRoute(
                     builder: (context) =>
                         Notifications(
                             "Customer"), //const PlayList( tag: 'Playlists',title:'Podcast'),
                   ),
                 );
               }
               else
                 {
                   Navigator.push(
                     context,
                     MaterialPageRoute(
                       builder: (context) => const Login(
                           "Customer"), //const PlayList( tag: 'Playlists',title:'Podcast'),
                     ),
                   );

                 }
              },
              child: Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  const Icon(
                    Icons.notifications_none_outlined,
                    color: Color(0xFF555555),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  FutureBuilder(future: _translationController.getTransaltion( "notifications"),
                      builder: (context,snapshot){
                        if(snapshot.hasData)
                        {
                          return       Text(
                            snapshot.data!,
                            textAlign: TextAlign.center,

                            style: TextStyle(
                              color: const Color(0xFF323232),
                              fontSize: 16,
                              fontFamily: GoogleFonts.harmattan().fontFamily,
                              fontWeight: FontWeight.w400,
                            ),
                          );
                        }
                        else
                        {
                          return
                            Text(
                              'Notification',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color(0xFF323232),
                                fontSize: 16,
                                fontFamily: GoogleFonts.harmattan().fontFamily,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ;
                        }
                      }),

                ],
              ),
            ),

            const SizedBox(
              height: 20,
            ),

//chnage langauge
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const ChangeLanguage(), //const PlayList( tag: 'Playlists',title:'Podcast'),
                  ),
                );
              },
              child: Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  const Icon(
                    Icons.language,
                    color: Color(0xFF555555),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  FutureBuilder(future: _translationController.getTransaltion( "change_language"),
                      builder: (context,snapshot){
                        if(snapshot.hasData)
                        {
                          return       Text(
                            snapshot.data!,
                            textAlign: TextAlign.center,

                            style: TextStyle(
                              color: const Color(0xFF323232),
                              fontSize: 16,
                              fontFamily: GoogleFonts.harmattan().fontFamily,
                              fontWeight: FontWeight.w400,
                            ),
                          );
                        }
                        else
                        {
                          return
                            Text(
                              'Change Language',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color(0xFF323232),
                                fontSize: 16,
                                fontFamily: GoogleFonts.harmattan().fontFamily,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ;
                        }
                      }),
                ],
              ),
            ),
            //Change Language

            const SizedBox(
              height: 20,
            ),

            //faq

            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const FAQ(), //const PlayList( tag: 'Playlists',title:'Podcast'),
                  ),
                );
              },
              child: Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  const Icon(
                    Icons.question_answer_outlined,
                    color: Color(0xFF555555),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  FutureBuilder(future: _translationController.getTransaltion( "fAQ"),
                      builder: (context,snapshot){
                        if(snapshot.hasData)
                        {
                          return       Text(
                            snapshot.data!,
                            textAlign: TextAlign.center,

                            style: TextStyle(
                              color: const Color(0xFF323232),
                              fontSize: 16,
                              fontFamily: GoogleFonts.harmattan().fontFamily,
                              fontWeight: FontWeight.w400,
                            ),
                          );
                        }
                        else
                        {
                          return
                            Text(
                              'FAQ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color(0xFF323232),
                                fontSize: 16,
                                fontFamily: GoogleFonts.harmattan().fontFamily,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ;
                        }
                      }),

                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            //terms

            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TermsAndPolicy(
                        stringValue:
                            "terms_of_use"), //const PlayList( tag: 'Playlists',title:'Podcast'),
                  ),
                );
              },
              child: Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  const Icon(
                    Icons.lock_person_outlined,
                    color: Color(0xFF555555),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  FutureBuilder(future: _translationController.getTransaltion( "terms_of_use"),
                      builder: (context,snapshot){
                        if(snapshot.hasData)
                        {
                          return       Text(
                            snapshot.data!,
                            textAlign: TextAlign.center,

                            style: TextStyle(
                              color: const Color(0xFF323232),
                              fontSize: 16,
                              fontFamily: GoogleFonts.harmattan().fontFamily,
                              fontWeight: FontWeight.w400,
                            ),
                          );
                        }
                        else
                        {
                          return
                            Text(
                              'Terms of use',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color(0xFF323232),
                                fontSize: 16,
                                fontFamily: GoogleFonts.harmattan().fontFamily,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ;
                        }
                      }),

                ],
              ),
            ),

            const SizedBox(
              height: 20,
            ),

//privacy
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TermsAndPolicy(
                        stringValue:
                            "privacy_policy"), //const PlayList( tag: 'Playlists',title:'Podcast'),
                  ),
                );
              },
              child: Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  const Icon(
                    Icons.privacy_tip_outlined,
                    color: Color(0xFF555555),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  FutureBuilder(future: _translationController.getTransaltion("privacy_policy"),
                      builder: (context,snapshot){
                        if(snapshot.hasData)
                        {
                          return       Text(
                            snapshot.data!,
                            textAlign: TextAlign.center,

                            style: TextStyle(
                              color: const Color(0xFF323232),
                              fontSize: 16,
                              fontFamily: GoogleFonts.harmattan().fontFamily,
                              fontWeight: FontWeight.w400,
                            ),
                          );
                        }
                        else
                        {
                          return
                            Text(
                              'Privacy Policy',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color(0xFF323232),
                                fontSize: 16,
                                fontFamily: GoogleFonts.harmattan().fontFamily,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ;
                        }
                      }),
                ],
              ),
            ),

            const SizedBox(
              height: 20,
            ),

//contact us
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const HelpCenter(), //const PlayList( tag: 'Playlists',title:'Podcast'),
                  ),
                );
              },
              child: Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  const Icon(
                    Icons.contact_phone_outlined,
                    color: Color(0xFF555555),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  FutureBuilder(future: _translationController.getTransaltion( "contact_us"),
                      builder: (context,snapshot){
                        if(snapshot.hasData)
                        {
                          return       Text(
                            snapshot.data!,
                            textAlign: TextAlign.center,

                            style: TextStyle(
                              color: const Color(0xFF323232),
                              fontSize: 16,
                              fontFamily: GoogleFonts.harmattan().fontFamily,
                              fontWeight: FontWeight.w400,
                            ),
                          );
                        }
                        else
                        {
                          return
                            Text(
                              'Contact Us',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color(0xFF323232),
                                fontSize: 16,
                                fontFamily: GoogleFonts.harmattan().fontFamily,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ;
                        }
                      }),
                ],
              ),
            ),
            // contact us

            const SizedBox(
              height: 20,
            ),

            //logout
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                const Icon(
                  Icons.logout,
                  color: Color(0xFF555555),
                ),
                const SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: () {
                    PrefManager.clearPref();
                    PrefManager.clearPref();
                    PrefManager.clearPref();
                    PrefManager.clearPref();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return const DashboardBottom();
                    }));
                  },
                  child:
                  FutureBuilder(future: _translationController.getTransaltion( "logout"),
                      builder: (context,snapshot){
                        if(snapshot.hasData)
                        {
                          return       Text(
                            snapshot.data!,
                            textAlign: TextAlign.center,

                            style: TextStyle(
                              color: const Color(0xFF323232),
                              fontSize: 16,
                              fontFamily: GoogleFonts.harmattan().fontFamily,
                              fontWeight: FontWeight.w400,
                            ),
                          );
                        }
                        else
                        {
                          return
                            Text(
                              'Logout',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color(0xFF323232),
                                fontSize: 16,
                                fontFamily: GoogleFonts.harmattan().fontFamily,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ;
                        }
                      }),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showLogginScreen(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return const Login("Customer") /*Container(
              padding: const EdgeInsets.only(left: 5, right: 5),
              height: 750,
              //  color: Colors.white,
              decoration: const ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  )),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),

                    Center(
                      child: Text(
                        "Login for access".tr,
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontSize: 18),
                      ),
                    ),

                    const Divider(
                      thickness: 2,
                      color: AppColors.appColor,
                    ),

                    const SizedBox(height: 20),
                    //for email field

                    TextFormField(
                        controller: controllerEmail,
                        keyboardType: TextInputType.emailAddress,
                        onFieldSubmitted: (value) {},
                        decoration: InputDecoration(
                          labelText: "Email",
                          prefixIcon: const Icon(Icons.mail_outline),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onEditingComplete: () =>
                            _focusNodePassword.requestFocus(),
                        validator: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value)) {
                            return 'Enter a valid email!';
                          }
                          return null;
                        }),

                    const SizedBox(height: 30),
                    // for password field
                    TextFormField(
                      controller: controllerPassword,
                      focusNode: _focusNodePassword,
                      obscureText: _obscurePassword,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        labelText: "Password",
                        prefixIcon: const Icon(Icons.lock_person_rounded),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                            icon: _obscurePassword
                                ? const Icon(Icons.visibility_outlined)
                                : const Icon(Icons.visibility_off_outlined)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter a valid password!';
                        }
                        return null;
                      },
                    ),

                    //terms and conditions check box
                    const SizedBox(
                      height: 40,
                    ),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: HexColor("#07B464"),
                        elevation: 2.5,
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () {
                        loginValidator();
                      },
                      child: Text("Log In",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: GoogleFonts.athiti().fontFamily)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ))*/;
        });
  }

/*
  Future<void> loginValidator() async {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    // static Pattern pattern ="^[a-zA-Z0-9.a-zA-Z0-9.!#%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

    RegExp regExp = RegExp(pattern.toString());
    if (controllerEmail.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Email is required'), backgroundColor: Colors.red));
    } else if (!regExp.hasMatch(controllerEmail.text.trim())) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Valid email is required'),
          backgroundColor: Colors.red));
    } else if (controllerPassword.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Password is required'),
        backgroundColor: Colors.red,
      ));
    }

    */

/*else
      {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
          return const LandDashboard();
        }));

      };;*/
  /*


    else {
      buildLoading(context);

      RetrofitInterface apiInterface = RetrofitInterface(Dio());

      loginUser(apiInterface, controllerEmail.text, controllerPassword.text)
          .then((success) {
        if (success) {
          Navigator.of(context).pop();
          Navigator.of(context).pop();

          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Login Successful'),
            backgroundColor: Colors.green,
          ));
        } else {
          Navigator.of(context).pop();

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(message),
            backgroundColor: Colors.red,
          ));
        }
      });
    }
  }
*/

  /*Future<bool> loginUser(
      RetrofitInterface apiService, String email, String password) async {
    //final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      Model_Login user = await apiService.getLogin(email, password, "Customer");
      if (user.status == "true") {
        uid = user.user_id.toString();
        uName  = user.name.toString();
        PrefManager.saveString("token", user.token.toString());
        PrefManager.saveString("owner", "Customer");
        PrefManager.saveString("userId", user.user_id.toString());
        PrefManager.saveString("name", user.name.toString());

        setState(() {
          logged = true;
          PrefManager.saveString("token", user.token.toString());
          PrefManager.saveString("owner", "Customer");
        });

        final logger = Logger();

        return true;
      } else {
        message = user.message!;
        debugPrint("error message in login == $message");

        return false;
      }
    } catch (e) {
      debugPrint(e.toString());
      message = e.toString();

      return false; // Return false indicating login failure
    }
  }*/
}
