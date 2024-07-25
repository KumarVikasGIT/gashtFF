import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gasht/ui/authentication/login.dart';
import 'package:gasht/ui/dashboard/wishList.dart';
import 'package:gasht/util/colors.dart';
import 'package:google_fonts/google_fonts.dart';

import '../messages/messages.dart';
import '../prefManager.dart';
import 'homePage.dart';
import 'moreOptions.dart';

class DashboardBottom extends StatefulWidget{
  const DashboardBottom({super.key});


  @override
  State<DashboardBottom> createState() => _Dashboard ();

}

class _Dashboard extends State<DashboardBottom> with WidgetsBindingObserver{

  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  bool logged = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);

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
  void dispose() {
    // Dispose the controllers

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:

        break;
      case AppLifecycleState.resumed:
        _initializeScreen();
        print("bottomDashboard");

       // fetchProfileData();
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
  void didChangeDependencies() {
    super.didChangeDependencies();

  }
  @override
  void setState(fn) {

    super.setState(fn);
  }
  @override
  void deactivate() {

    super.deactivate();
  }


  @override
  Widget build(BuildContext context) {
        List<Widget> widgetOptions = <Widget>[

      const HomePage(),
      const WishList(),
          logged ? const Messages(): const Login("Customer"),
          const More(),

    ];

    return Theme(
      data: ThemeData(
        fontFamily: GoogleFonts.harmattan().fontFamily,
      ),
      child: Scaffold(


        body:Center(child:  widgetOptions.elementAt(_selectedIndex),),


        bottomNavigationBar:  BottomNavigationBar(
            items:   <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  activeIcon: Icon(Icons.home,color: AppColors.appColor),

                  icon: Icon(Icons.home,color: Colors.grey,),
                  label: ('home'.tr()),
                  backgroundColor: Colors.white
              ),
              BottomNavigationBarItem(
                  activeIcon: Icon(Icons.favorite,color: AppColors.appColor),

                  icon: Icon(Icons.favorite_border_outlined,color: Colors.grey,),
                  label: ('wishlist'.tr()),
                  backgroundColor: Colors.white
              ),


              BottomNavigationBarItem(
                activeIcon: Icon(Icons.message_rounded,color: AppColors.appColor),
                icon: Icon(Icons.message_rounded,color: Colors.grey,),
                label: ('messages'.tr()),
                backgroundColor: Colors.white,
              ),

              BottomNavigationBarItem(
                activeIcon: Icon(Icons.calendar_view_month_sharp,color: AppColors.appColor),
                icon: Icon(Icons.calendar_view_month_sharp,color: Colors.grey,),
                label: ('more'.tr()),
                backgroundColor: Colors.white,
              ),

            ],
            type: BottomNavigationBarType.shifting,
            currentIndex: _selectedIndex,
            selectedItemColor: AppColors.appColor,
            iconSize: 20,
            onTap: _onItemTapped,
            elevation: 5
        ),
      ),
    );

  }









}