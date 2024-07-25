import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gasht/ui/dashboard/wishList.dart';
import 'package:gasht/util/colors.dart';

import '../messages/messages.dart';
import 'landDashboard.dart';
import 'landlordMore.dart';
import 'myProperties.dart';


class BottomLandlord extends StatefulWidget{
  const BottomLandlord({super.key});


  @override
  State<BottomLandlord> createState() => _Dashboard ();

}

class _Dashboard extends State<BottomLandlord> {

  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }









  @override
  Widget build(BuildContext context) {
    const    List<Widget> widgetOptions = <Widget>[

      LandDashboard(),
      MyProperties(),

      Messages(),
      LandloardMore(),

    ];




    return Scaffold(

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
    );

  }









}