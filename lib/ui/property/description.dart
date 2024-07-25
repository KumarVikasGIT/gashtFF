import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:gasht/data_models/model_propertyList.dart';
import 'package:gasht/ui/moreOptions/dunn.dart';
import 'package:gasht/ui/property/precheckout.dart';
import 'package:gasht/util/colors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logger/logger.dart';

import '../../api/retrofit_interface.dart';
import '../../data_models/model_login.dart';
import '../../loadingScreen.dart';
import '../../main.dart';
import '../../util/dialogs.dart';
import '../../util/exapndedPanel.dart';
import '../authentication/signup.dart';
import '../controllers/langaugeCotroller.dart';
import '../messages/firebase/chatUserDataModel.dart';
import '../messages/firebase/chat_screen.dart';
import '../messages/firebase/firebase.dart';
import '../moreOptions/faq.dart';
import '../prefManager.dart';
import 'dummydata.dart';
import 'package:dio/dio.dart';

import 'package:material_dialogs/material_dialogs.dart';
import 'package:lottie/lottie.dart';


class Description extends StatefulWidget {
  final Property propertyList;
  String startDate;
  String endDate;
   Description(this.propertyList,  this.startDate, this.endDate, {Key? key}) : super(key: key);

  @override
  State<Description> createState() => _Description();
}

class _Description extends State<Description> {

  final FocusNode _focusNodePassword = FocusNode();
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  bool _obscurePassword = true;
  bool isChecked = false;
  late String message;

  final TranslationController _translationController = Get.put(TranslationController());




  @override
  void initState() {
    super.initState();


  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Theme(
      data: ThemeData(
        fontFamily: GoogleFonts.harmattan().fontFamily,
      ),
      child: Scaffold(
          body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),

            Row(children: [
              const SizedBox(
                width: 10,
              ),
              const Icon(Icons.star_border),
              const SizedBox(
                width: 10,
              ),
              Text(
                widget.propertyList.avgRating.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF262626),
                  fontSize: 13,
                  fontFamily: GoogleFonts.harmattan().fontFamily,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.60,
                ),
              ),
            ]),

            const SizedBox(
              height: 10,
            ),

            Row(children: [
              const SizedBox(
                width: 10,
              ),
              const Icon(Icons.location_on_sharp),
              const SizedBox(
                width: 10,
              ),

              FutureBuilder(future: _translationController.getTransaltion('${widget.propertyList.propertyName}'),
                  builder: (context,snapshot){
                    if(snapshot.hasData)
                    {
                      return        Text(
                        snapshot.data!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFF262626),
                          fontSize: 13,
                          fontFamily: GoogleFonts.harmattan().fontFamily,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.60,
                        ),
                      );
                    }
                    else
                    {
                      return
                        Text(
                          '${widget.propertyList.propertyName}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: const Color(0xFF262626),
                            fontSize: 13,
                            fontFamily: GoogleFonts.harmattan().fontFamily,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.60,
                          ),
                        );
                    }
                  }),



            ]),

            const SizedBox(
              height: 10,
            ),

            Row(children: [
              const SizedBox(
                width: 10,
              ),
              const Icon(Icons.home),
              const SizedBox(
                width: 10,
              ),
              FutureBuilder(future: _translationController.getTransaltion('${widget.propertyList.area}'),
                  builder: (context,snapshot){
                    if(snapshot.hasData)
                    {
                      return    Row(
                        children: [
                          Text("meter",
                            style: TextStyle(
                              color:
                              const Color(0xFF303030),
                              fontSize: 13,
                              fontFamily:
                              GoogleFonts.harmattan()
                                  .fontFamily,
                              fontWeight: FontWeight.w600,
                            ),
                          ).tr(),
                          SizedBox(width: 8,),
                          Text(
                            snapshot.data!,
                            style: TextStyle(
                              color:
                              const Color(0xFF303030),
                              fontSize: 13,
                              fontFamily:
                              GoogleFonts
                                  .harmattan()
                                  .fontFamily,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      );    Text(
                        snapshot.data!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFF262626),
                          fontSize: 13,
                          fontFamily: GoogleFonts.harmattan().fontFamily,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.60,
                        ),
                      );
                    }
                    else
                    {
                      return
                        Text(
                          '${widget.propertyList.propertyName}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: const Color(0xFF262626),
                            fontSize: 13,
                            fontFamily: GoogleFonts.harmattan().fontFamily,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.60,
                          ),
                        );
                    }
                  }),

            ]),

            const SizedBox(
              height: 10,
            ),

            Row(children: [
              const SizedBox(
                width: 10,
              ),
              const Icon(Icons.family_restroom),
              const SizedBox(
                width: 10,
              ),


              FutureBuilder(future: _translationController.getTransaltion(   'For ${widget.propertyList.tenentType}'),
                  builder: (context,snapshot){
                    if(snapshot.hasData)
                    {
                      return        Text(
                        snapshot.data!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFF262626),
                          fontSize: 13,
                          fontFamily: GoogleFonts.harmattan().fontFamily,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.60,
                        ),
                      );
                    }
                    else
                    {
                      return
                        Text(
                          'For ${widget.propertyList.tenentType}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: const Color(0xFF262626),
                            fontSize: 13,
                            fontFamily: GoogleFonts.harmattan().fontFamily,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.60,
                          ),
                        );
                    }
                  }),


            ]),

            const SizedBox(
              height: 30,
            ),

            //date
            Row(children: [
              const SizedBox(
                width: 20,
              ),


              FutureBuilder(future: _translationController.getTransaltion( 'check_in_date'),
                  builder: (context,snapshot){
                    if(snapshot.hasData)
                    {   return Text(
                      snapshot.data!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontFamily: GoogleFonts.harmattan().fontFamily,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.65,
                      ),
                    );
                    }
                    else
                    {
                      return
                        Text(
                          'Check-in date',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontFamily: GoogleFonts.harmattan().fontFamily,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.65,
                          ),
                        );
                    }
                  }),





              const Spacer(),
              Container(
                margin: const EdgeInsets.only(right: 20,left: 20),
                child:

                FutureBuilder(future: _translationController.getTransaltion( 'check_out_date'),
                    builder: (context,snapshot){
                      if(snapshot.hasData)
                      {   return Text(
                        snapshot.data!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontFamily: GoogleFonts.harmattan().fontFamily,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.65,
                        ),
                      );
                      }
                      else
                      {
                        return
                          Text(
                            'Check-out date',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontFamily: GoogleFonts.harmattan().fontFamily,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.65,
                            ),
                          );
                      }
                    }),

              )
            ]),

            const SizedBox(
              height: 5,
            ),

            //date dynamic
            Row(children: [
              const SizedBox(
                width: 20,
              ),




              FutureBuilder(future: _translationController.getTransaltion( widget.startDate),
                  builder: (context,snapshot){
                    if(snapshot.hasData)
                    {   return Text(
                      snapshot.data!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontFamily: GoogleFonts.harmattan().fontFamily,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.65,
                      ),
                    );
                    }
                    else
                    {
                      return
                        Text(
                         widget.startDate,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontFamily: GoogleFonts.harmattan().fontFamily,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.65,
                          ),
                        );
                    }
                  }),


              const Spacer(),

              FutureBuilder(future: _translationController.getTransaltion( widget.endDate),
                  builder: (context,snapshot){
                    if(snapshot.hasData)
                    {   return Container(
                      margin: const EdgeInsets.only(right: 20,left: 10),

                      child: Text(
                        snapshot.data!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontFamily: GoogleFonts.harmattan().fontFamily,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.65,
                        ),
                      ),
                    );
                    }
                    else
                    {
                      return
                        Container(
                          margin: const EdgeInsets.only(right: 20),
                          child: Text(
                            widget.endDate,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFF262626),
                              fontSize: 13,
                              fontFamily: GoogleFonts.harmattan().fontFamily,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.60,
                            ),
                          ),
                        )
                      ;
                    }
                  }),

            ]),

            const SizedBox(
              height: 20,
            ),

            //tim text
            //check in and check out time
            const SizedBox(
              height: 15,
            ),

            Row(children: [
              const SizedBox(
                width: 10,
              ),
              FutureBuilder(future: _translationController.getTransaltion( "facilities"),
                  builder: (context,snapshot){
                    if(snapshot.hasData)
                    {   return Container(
                      margin: const EdgeInsets.only(right: 20),

                      child: Text(
                        snapshot.data!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: GoogleFonts.harmattan().fontFamily,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.65,
                        ),
                      ),
                    );
                    }
                    else
                    {
                      return
                        Container(
                          margin: const EdgeInsets.only(right: 20),
                          child: Text(
                           "Facilities",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFF262626),
                              fontSize: 15,
                              fontFamily: GoogleFonts.harmattan().fontFamily,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.60,
                            ),
                          ),
                        )
                      ;
                    }
                  }),




              const Spacer(),

            ]),



          Card1( "${tr("living_Room")} (${widget.propertyList.livingroom})"
              , widget.propertyList.livDescription.toString(),),
            Card1( " ${tr("bed_Room")} (${widget.propertyList.bedroom})"
              , widget.propertyList.bedDescription.toString(),),
            Card1( "${tr("kitchen")} (${widget.propertyList.kitchen})"
              , widget.propertyList.kitDescription.toString(),),
            Card1( "${tr("washroom")} (${widget.propertyList.washroom})"
              , widget.propertyList.washDescription.toString(),),

            Card1( "${tr("pool")}  (${widget.propertyList.pool})"
              , widget.propertyList.poolDescription.toString(),),
          /*  ExpansionPanelList(
              elevation: 1,
              expansionCallback: (int index, bool isExpanded) {
                setState(() {
                  faqItems[index].isExpanded = !isExpanded;
                });
              },
              children:
                  faqItems.map<ExpansionPanel>((ExpansionPanelItemFaq item) {
                return ExpansionPanel(
                  canTapOnHeader: true,
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      title:
      /
                      FutureBuilder(future: _translationController.getTransaltion( item.headerValue),
                          builder: (context,snapshot){
                            if(snapshot.hasData)
                            {   return Container(
                              margin: const EdgeInsets.only(right: 20),

                              child: Text(
                                snapshot.data!,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: GoogleFonts.harmattan().fontFamily,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.65,
                                ),
                              ),
                            );
                            }
                            else
                            {
                              return
                                Text(
                                  item.headerValue,
                                  style: const TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold),
                                )
                              ;
                            }
                          }),




                    );
                  },
                  body: ListTile(
                    title:

                    FutureBuilder(future: _translationController.getTransaltion(item.expandedValue),
                        builder: (context,snapshot){
                          if(snapshot.hasData)
                          {   return Container(
                            margin: const EdgeInsets.only(right: 20),

                            child: Text(
                              snapshot.data!,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: GoogleFonts.harmattan().fontFamily,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.65,
                              ),
                            ),
                          );
                          }
                          else
                          {
                            return
                              Text(
                                item.expandedValue,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              )
                            ;
                          }
                        }),

                  ),
                  isExpanded: true,
                );
              }).toList(),
            ),*/



            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 10, top: 10),
              child:

              FutureBuilder(future: _translationController.getTransaltion('overview'),
                  builder: (context,snapshot){
                    if(snapshot.hasData)
                    {   return     Text(
                      snapshot.data!,
                      style: TextStyle(
                        color: const Color(0xFF262626),
                        fontSize: 14,
                        fontFamily: GoogleFonts.harmattan().fontFamily,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.60,
                      ),
                    );
                    }
                    else
                    {
                      return
                        Text(
                          'Overview',
                          style: TextStyle(
                            color: const Color(0xFF262626),
                            fontSize: 14,
                            fontFamily: GoogleFonts.harmattan().fontFamily,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.60,
                          ),
                        )
                      ;
                    }
                  }),




            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 10, top: 5, right: 10),
              child:


              FutureBuilder(future: _translationController.getTransaltion(   '${widget.propertyList.propertyDescription}',
              ),
                  builder: (context,snapshot){
                    if(snapshot.hasData)
                    {   return
                      Text(
                        snapshot.data!,
                      style: TextStyle(
                        color: const Color(0xFF707070),
                        fontSize: 15,
                        fontFamily: GoogleFonts.harmattan().fontFamily,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.60,
                      ),
                    );
                    }
                    else
                    {
                      return
                        Text(
                          '${widget.propertyList.propertyDescription}',
                          style: TextStyle(
                            color: const Color(0xFF707070),
                            fontSize: 15,
                            fontFamily: GoogleFonts.harmattan().fontFamily,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.60,
                          ),
                        )
                      ;
                    }
                  }),



            ),

            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 10, top: 20),
              child:

              FutureBuilder(future: _translationController.getTransaltion( "have_a_question?"),
                  builder: (context,snapshot){
                    if(snapshot.hasData)
                    {   return
                      Text(
                        snapshot.data!,
                        style: TextStyle(
                          color: const Color(0xFF707070),
                          fontSize: 15,
                          fontFamily: GoogleFonts.harmattan().fontFamily,
                          fontWeight: FontWeight.w600,
                        ),
                      );
                    }
                    else
                    {
                      return
                        Text(
                          'Have a question?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: GoogleFonts.harmattan().fontFamily,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ;
                    }
                  }),



            ),

            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(top: 15, left: 10, right: 200),
              width: 150,
              height: 40,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.appColor,
                    elevation: 2.5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {


                    String? token = await PrefManager.getString("token");
                    if (token != null) {

                      APIs.getSelfInfo();

                        await APIs.addChatUser(widget.propertyList.ownerid.toString()).then((value) {

                        if(value)
                          {


                          /*  StreamBuilder(
                              stream: APIs.getLandlordUsers(widget.propertyList.ownerid.toString()),

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
                                    log("lanlord data   ==$data");
                                    log("lanlord chat  ==$list");


                                    if (list.isNotEmpty) {

                                      WidgetsBinding.instance.addPostFrameCallback((_) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (_) => ChatScreen(user: list[0])),
                                        );
                                      });
                                      return const SizedBox.shrink();


                                    } else {
                                      return const Center(
                                        child: Text('No Connections Found!',
                                            style: TextStyle(fontSize: 20)),
                                      );
                                    }
                                }
                              },
                            ) ;
      */

                            APIs.getChatUserAndNavigate(uid,widget.propertyList.ownerid.toString()).listen((chatUser) {
                              log("add user chatUser ==${chatUser.id}");
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ChatScreen(user: chatUser),
                                ),
                              );
                            });

                          }

                        });




                    } else {
                      showLogginScreen(context);

                    }

                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(
                        Icons.chat_outlined,
                        color: Colors.white,
                      ),

                      FutureBuilder(future: _translationController
                          .getTransaltion( "ask_the_host"),
                          builder: (context,snapshot){
                            if(snapshot.hasData)
                            {   return
                              Text(
                               snapshot.data!,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontFamily: GoogleFonts.harmattan().fontFamily,
                                  fontWeight: FontWeight.w500,
                                ),
                              );
                            }
                            else
                            {
                              return
                                Text(
                                  'Chat with us',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontFamily: GoogleFonts.harmattan().fontFamily,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ;
                            }
                          }),







                    ],
                  )),
            ),

        /*    Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 10, top: 20),
              child: Text(
                'Based on your search',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: GoogleFonts.harmattan().fontFamily,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.65,
                ),
              ),
            ),*/

            const SizedBox(
              height: 20,
            ),

            Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    FutureBuilder(future: _translationController.
                    getTransaltion( "price"),
                        builder: (context,snapshot){
                          if(snapshot.hasData)
                          {   return
                            Text(
                              snapshot.data!,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: GoogleFonts.harmattan().fontFamily,
                                fontWeight: FontWeight.w500,
                              ),
                            );
                          }
                          else
                          {
                            return
                              Text(
                                'Price',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: GoogleFonts.harmattan().fontFamily,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ;
                          }
                        }),






                    Text(
                      "${widget.propertyList.price} IQD",
                      style: TextStyle(
                        color: const Color(0xFF303030),
                        fontSize: 15,
                        fontFamily: GoogleFonts.harmattan().fontFamily,
                        fontWeight: FontWeight.w500,
                        height: 1.33,
                      ),
                    ),
                  ],
                ),
            //    const Spacer(),
           /*     Container(
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.only(top: 15, left: 10),
                  height: 40,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.appColor,
                        elevation: 2.5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () async {

                        String? token = await PrefManager.getString("token");
                        if (token != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PreCheckout(widget
                                  .propertyList,widget.startDate,widget.endDate), //const PlayList( tag: 'Playlists',title:'Podcast'),
                            ),
                          );
                        } else {
                          showLogginScreen(context);

                        }



                      },
                      child: Text(
                        "Buy Now".tr,
                        style: const TextStyle(color: Colors.white),
                      )),
                ),*/
                const SizedBox(
                  width: 10,
                ),
              ],
            ),

            const SizedBox(
              height: 10,
            ),
          ],
        ),
      )),
    );
  }
  void showLogginScreen(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
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
                        "login_to_your_account",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: GoogleFonts.harmattan().fontFamily,
                            fontSize: 18),
                      ).tr(),
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
                          labelText: tr("email"),
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
                        labelText: tr("password"),
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
                      child: Text("sign_in",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: GoogleFonts.athiti().fontFamily)).tr(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        FutureBuilder(future: _translationController
                            .getTransaltion("do_not_have_an_account?"),
                            builder: (context,snapshot){
                              if(snapshot.hasData)
                              {
                                return   Text(snapshot.data!,
                                    style: TextStyle(color: Colors.black,fontSize: 20,
                                        fontWeight: FontWeight.bold,fontFamily: GoogleFonts.athiti().fontFamily));
                              }



                              else
                              {
                                return
                                  Text("Don't have an account?",
                                      style: TextStyle(color: Colors.black,fontSize: 15,
                                          fontWeight: FontWeight.bold,fontFamily: GoogleFonts.athiti().fontFamily)); }
                            }),



                        TextButton(
                          onPressed: () {
                            //_formKey.currentState?.reset();

                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return  Signup("Customer");
                            },
                            ),
                            );
                          },
                          child:
                          FutureBuilder(future: _translationController.
                          getTransaltion("sign_up"),
                              builder: (context,snapshot){
                                if(snapshot.hasData)
                                {
                                  return   Text(snapshot.data!,
                                      style: TextStyle(color: Colors.blue,fontSize: 15,
                                          fontWeight: FontWeight.bold,fontFamily: GoogleFonts.athiti().fontFamily));
                                }



                                else
                                {
                                  return
                                    Text("Signup",
                                        style: TextStyle(color: Colors.blue,fontSize: 15,
                                            fontWeight: FontWeight.bold,fontFamily: GoogleFonts.athiti().fontFamily)); }
                              }),


                          //  const Text("Signup",style: TextStyle(color: Colors.blue),),
                        ),
                      ],
                    ),



                  ],
                ),
              ));
        });
  }

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

    /*else
      {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
          return const LandDashboard();
        }));

      };;*/

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


          Get.snackbar(message,"",colorText: Colors.white,backgroundColor: Colors.red,snackPosition: SnackPosition.BOTTOM);



          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(message),
            backgroundColor: Colors.red,
          ));
        }
      });
    }
  }

  Future<bool> loginUser(
      RetrofitInterface apiService, String email, String password) async {
    //final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;


      String? deviceId = await _firebaseMessaging.getToken();
      Model_Login user = await apiService.getLogin(email, password, "Customer",deviceId!);
      if (user.status == "true") {
        uid = user.user_id.toString();
        uName  = user.name.toString();

        PrefManager.saveString("token", user.token.toString());
        PrefManager.saveString("owner", "Customer");
        PrefManager.saveString("userId", user.user_id.toString());
        PrefManager.saveString("name", user.name.toString());

        setState(() {
        //  logged = true;
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
  }
}
