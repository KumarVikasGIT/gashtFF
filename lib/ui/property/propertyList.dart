import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_banner/card_banner.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:gasht/api/retrofit_interface.dart';
import 'package:gasht/ui/dashboard/controllers/dashboardController.dart';
import 'package:gasht/ui/dashboard/controllers/propertyController.dart';
import 'package:gasht/ui/dashboard/controllers/wishlistController.dart';
import 'package:gasht/ui/prefManager.dart';
import 'package:gasht/ui/property/fullMapScreen.dart';
import 'package:gasht/ui/property/propertyDetails.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';

import '../../data_models/model_propertyList.dart';
import '../../data_models/propertyObject.dart';
import '../../util/colors.dart';
import 'package:dio/dio.dart';

import '../controllers/langaugeCotroller.dart';
import '../moreOptions/dunn.dart';

class PropertyList extends StatefulWidget {
  String startDate;
  String endDate;
  int cityId;
  int propertyId;

  PropertyList(this.startDate, this.endDate, this.cityId, this.propertyId,
      {Key? key})
      : super(key: key);

  @override
  State<PropertyList> createState() => _PropertyList();
}

class _PropertyList extends State<PropertyList> {
  final TextEditingController _searchController = TextEditingController();

  List<int> selectedIds = [];

  final PropertyTypeController _proType = Get.put(PropertyTypeController());
  PropertyController propertyController = Get.put(PropertyController());

  WishlistController wishlistController = Get.put(WishlistController());

  final TranslationController _translationController =
  Get.put(TranslationController());
  int cityId = 0;
  int propertyId = 0;

  late List<Property> propertyList;
  int current = 0;
  List<String> items = [
    "Apartment",
    "Price",
    "Offers",
    "Rating",
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    propertyController.fetchProperties(
        widget.cityId, widget.startDate, widget.endDate, widget.propertyId);
  }

  static const List<IconData> iconss = [
    Icons.check_circle,
    Icons.price_check,
    Icons.percent,
    Icons.star_rate
  ];

  void handleFilterSelection(String filter, bool isSelected) {
    setState(() {
      if (isSelected) {
        //     selectedFilters.add(filter);

        if (filter == "Apartment") {
          _showApartmentList();
        }
        if (filter == "Price") {
          _showPriceSheet();
        }
        if (filter == "Offers") {
          propertyController.offerFilter();
        }
        if (filter == "Rating") {
          propertyController.ratingFilter();
        }
      } else {
        propertyController.resetFilter();
        /*   if(filter=="Apartment")
        {
          propertyController.resetFilter();
        }
        if(filter=="Price")
        {
          _showPriceSheet();
        }
        if(filter=="Offers")
        {

        }
        if(filter=="Rating")
        {
          propertyController.ratingFilter();
        }*/
      }
    });
  }

  final logger = Logger();

  Card foodCard(String url) {
    return Card(
      elevation: 0,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Image.network(
          url,
          fit: BoxFit.fitWidth,
          height: 240,
          width: double.infinity,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return SafeArea(
      child: Scaffold(
        //appBar: AppBar(),
        /* appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColors.appColor,
            iconTheme: const IconThemeData(color: Colors.white),
          */
        /*  title:
            FutureBuilder(future: _translationController.getTransaltion("Property List"),
                builder: (context,snapshot){
                  if(snapshot.hasData)
                  {
                    return    Text(snapshot.data!,style: TextStyle(color: Colors.white),);
                  }
                  else
                  {
                    return
                      const Text("Property List",style: TextStyle(color: Colors.white),);
                  }
                }),
            centerTitle: true,

            actions: [

          Expanded(child:
          Container(
                height: 50,

                decoration: const ShapeDecoration(
                  color:AppColors.appColor,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                ),

                // Add padding around the search bar
                // Use a Material design search bar
                child:   Container(
               //   margin: const EdgeInsets.only(top: 10,left: 10,right: 10),
                  height: 50,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),

                  // Add padding around the search bar
                  // Use a Material design search bar
                  child: TextField(
                    controller: _searchController,
                    onChanged: (query) {
                      propertyController.searchProperties(query);
                    },
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      // Add a clear button to the search bar
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () => _searchController.clear(),
                      ),
                      // Add a search icon or button to the search bar
                      prefixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          // Perform the search here
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),

                    ),
                  ),
                ),

              ),
          ),


              InkWell(
                  onTap: (){



                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FullMapScreen(propertyList),//const PlayList( tag: 'Playlists',title:'Podcast'),
                      ),
                    );

                    //    ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text('${markers.length}'),backgroundColor: Colors.red));

                  },
                  child:   Container(
                    width: 35,
                    height: 30,
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.shadowColor.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: const Offset(0, 1), // changes position of shadow
                        ),
                      ],
                    ),
                    child: const Icon(Icons.location_on_sharp,color: Colors.white,),
                  ))

            ],),*/

          body: Column(
            children: [
              Container(
                height: 110,
                decoration: const ShapeDecoration(
                  color: AppColors.appColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset(
                        "assets/images/arrowBack.png",
                        width: 40,
                        height: 40,
                      ),
                    ),
                    Expanded(
                        child: InkWell(
                            onTap: () => _showSearchCityBottomSheet(context),
                            child: Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(left: 5, right: 5),
                              height: 40,
                              decoration: BoxDecoration(
                                color: AppColors.textBoxColor,
                                border: Border.all(color: AppColors
                                    .textBoxColor),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.shadowColor.withOpacity(
                                        .05),
                                    spreadRadius: .5,
                                    blurRadius: .5,
                                    offset: const Offset(
                                        0, 1), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: TextField(
                                readOnly: true,
                                enabled: false,
                                controller: _searchController,
                                decoration: InputDecoration(
                                  prefixIcon:
                                  Icon(Icons.search, color: Colors.grey),
                                  border: InputBorder.none,
                                  hintText: tr("search"),
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15,
                                    fontFamily: GoogleFonts
                                        .harmattan()
                                        .fontFamily,
                                  ),
                                ),
                              ),
                            ))),
                    InkWell(
                        onTap: () {
                          print("called--");

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  FullMapScreen(
                                      propertyList), //const PlayList( tag: 'Playlists',title:'Podcast'),
                            ),
                          );

                          //    ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text('${markers.length}'),backgroundColor: Colors.red));
                        },
                        child: Container(
                          width: 35,
                          height: 30,
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.shadowColor.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: const Offset(
                                    0, 1), // changes position of shadow
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.location_on_sharp,
                            color: Colors.white,
                          ),
                        )),
                    const SizedBox(
                      width: 5,
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 10,
              ),
              //filter list
              Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                width: double.infinity,
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    /*

             Icons.check_circle,
      Icons.price_check,
      Icons.percent,
      Icons.star_rate

                      */
                    FilterBox(
                        label: tr('apartment'),
                        onSelected: (isSelected) {
                          handleFilterSelection('Apartment', isSelected);
                        },
                        icon: Icons.price_check),
                    FilterBox(
                        label: tr('price'),
                        onSelected: (isSelected) {
                          handleFilterSelection('Price', isSelected);
                        },
                        icon: Icons.monetization_on_outlined),
                    FilterBox(
                        label: tr('offers'),
                        onSelected: (isSelected) {
                          handleFilterSelection('Offers', isSelected);
                        },
                        icon: Icons.percent),
                    FilterBox(
                        label: tr('rating'),
                        onSelected: (isSelected) {
                          handleFilterSelection('Rating', isSelected);
                        },
                        icon: Icons.star_rate),
                  ],
                ),
              ),

              Obx(() {
                if (propertyController.isLoading.isFalse) {
                  propertyList = propertyController.filteredProperties;

                  /*  final currentLanguage = translationController.selectedLanguage.value;
                final translatedText = translationController.translateText('YourTextHere') ?? 'YourTextHere';
      */

                  return Expanded(
                    child: propertyList.isNotEmpty
                        ? ListView.builder(
                      itemCount: propertyList.length,
                      itemBuilder: (BuildContext context, int index) {
                        String discount = "";
                        if (propertyList[index].discount.toString() == "0%") {
                          discount = "";
                        } else {
                          discount =
                          "${propertyList[index].discount.toString()} Off";
                        }

                        final images = propertyList[index].images;
                        final imageUrl = (images != null && images.isNotEmpty)
                            ? images[0].toString()
                            : "https://via.placeholder.com/240";

                        return InkWell(
                          child: Container(
                              margin: const EdgeInsets.only(
                                  left: 10, right: 10, top: 0, bottom: 10),
                              width: double.infinity,
                              height: 370,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      width: 0.70, color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              child: Column(
                                children: [
                              discount.isNotEmpty
                              ? CardBanner(
                              text: discount,
                                color: AppColors.appColor,
                                child: foodCard(imageUrl),
                              )
                                : Image.network(
                            imageUrl,
                            height: 240,
                            fit: BoxFit.fill,
                            width: double.infinity,
                          ),

                                  //for price and heart
                                  Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 10, top: 5, right: 10),
                                        child: FutureBuilder(
                                            future: _translationController
                                                .getTransaltion(
                                                "${propertyList[index]
                                                    .price}"),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                return Row(
                                                  children: [
                                                  Text(
                                                  snapshot.data!,
                                                  style: TextStyle(
                                                    color: const Color(
                                                        0xFF303030),
                                                    fontSize: 13,
                                                    fontFamily: GoogleFonts
                                                        .harmattan()
                                                        .fontFamily,
                                                    fontWeight:
                                                    FontWeight.w600,
                                                    height: 1.54,
                                                  ),
                                                ),
                                                    SizedBox(width: 8,),
                                                  Text(
                                                    "IQD",
                                                  style: TextStyle(
                                                    color: const Color(
                                                        0xFF303030),
                                                    fontSize: 13,
                                                    fontFamily: GoogleFonts
                                                        .harmattan()
                                                        .fontFamily,
                                                    fontWeight:
                                                    FontWeight.w600,
                                                    height: 1.54,
                                                  ),
                                                ),
                                                    SizedBox(width: 8,),
                                                    Text(
                                                    "/",
                                                  style: TextStyle(
                                                    color: const Color(
                                                        0xFF303030),
                                                    fontSize: 13,
                                                    fontFamily: GoogleFonts
                                                        .harmattan()
                                                        .fontFamily,
                                                    fontWeight:
                                                    FontWeight.w600,
                                                    height: 1.54,
                                                  ),
                                                ),
                                                    Text(
                                                      "Night",
                                                      style: TextStyle(
                                                        color: const Color(
                                                            0xFF303030),
                                                        fontSize: 13,
                                                        fontFamily: GoogleFonts
                                                            .harmattan()
                                                            .fontFamily,
                                                        fontWeight:
                                                        FontWeight.w600,
                                                        height: 1.54,
                                                      ),
                                                    ),

                                                  ],
                                                );
                                              } else {
                                                return  Row(
                                                  children: [
                                                    Text(
                                                      "${propertyList[index]
                                                          .price}",
                                                      style: TextStyle(
                                                        color: const Color(
                                                            0xFF303030),
                                                        fontSize: 13,
                                                        fontFamily: GoogleFonts
                                                            .harmattan()
                                                            .fontFamily,
                                                        fontWeight:
                                                        FontWeight.w600,
                                                        height: 1.54,
                                                      ),
                                                    ),
                                                    SizedBox(width: 8,),
                                                    Text(
                                                      "IQD",
                                                      style: TextStyle(
                                                        color: const Color(
                                                            0xFF303030),
                                                        fontSize: 13,
                                                        fontFamily: GoogleFonts
                                                            .harmattan()
                                                            .fontFamily,
                                                        fontWeight:
                                                        FontWeight.w600,
                                                        height: 1.54,
                                                      ),
                                                    ),


                                                  ],
                                                );
                                              }
                                            }),
                                      ),
                                      const Spacer(),
                                      Container(
                                        width: 50,
                                        height: 50,
                                        child: IconButton(
                                          onPressed: () {
                                            if (!wishlistController
                                                .isInWishlist(
                                                propertyList[index])) {
                                              wishlistController
                                                  .addToWishlist(
                                                  propertyList[index]);
                                              Get.snackbar(
                                                  "Added to wishlist", "",
                                                  colorText: Colors.white,
                                                  snackPosition:
                                                  SnackPosition.BOTTOM,
                                                  backgroundColor:
                                                  Colors.green);
                                            } else {
                                              wishlistController
                                                  .removeFromWishlist(
                                                  propertyList[index]);
                                              Get.snackbar(
                                                  "Removed from wishlist", "",
                                                  colorText: Colors.white,
                                                  snackPosition:
                                                  SnackPosition.BOTTOM,
                                                  backgroundColor:
                                                  Colors.red);
                                            }
                                          },
                                          icon: Obx(
                                                () =>
                                                Icon(
                                                  wishlistController
                                                      .isInWishlist(
                                                      propertyList[index])
                                                      ? Icons.favorite
                                                      : Icons
                                                      .favorite_border_outlined,
                                                  color: wishlistController
                                                      .isInWishlist(
                                                      propertyList[index])
                                                      ? Colors.red
                                                      : null,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  Row(
                                    children: [
                                      const SizedBox(width: 10),
                                      const Icon(Icons.bed),
                                      FutureBuilder(
                                          future: _translationController
                                              .getTransaltion(
                                              propertyList[index]
                                                  .bedroom
                                                  .toString()),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              return Text(
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
                                                  height: 1.54,
                                                ),
                                              );
                                            } else {
                                              return Text(
                                                propertyList[index]
                                                    .bedroom
                                                    .toString(),
                                                style: TextStyle(
                                                  color:
                                                  const Color(0xFF303030),
                                                  fontSize: 13,
                                                  fontFamily:
                                                  GoogleFonts
                                                      .harmattan()
                                                      .fontFamily,
                                                  fontWeight: FontWeight.w600,
                                                  height: 1.54,
                                                ),
                                              );
                                            }
                                          }),
                                      const SizedBox(width: 10),
                                      const Icon(Icons.crop_square),
                                      FutureBuilder(
                                          future: _translationController
                                              .getTransaltion(
                                              propertyList[index]
                                                  .area
                                                  .toString()),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              return
                                                Row(
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
                                                );
                                            } else {
                                              return
                                                Row(
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
                                                Text(
                                                propertyList[index]
                                                    .area
                                                    .toString(),
                                            style: TextStyle(
                                            color:
                                            const Color(0xFF303030),
                                            fontSize: 13,
                                            fontFamily:
                                            GoogleFonts.harmattan()
                                                .fontFamily,
                                            fontWeight: FontWeight.w600,
                                            ),
                                            )
                                            ],
                                            );

                                          }
                                          }),
                                    ],
                                  ),

                                  Row(
                                    children: [
                                      SizedBox(width: 8,),
                                      Image.asset(
                                        getResortImage(
                                            propertyList[index]
                                                .propertyType),
                                        width: 25,
                                        height: 25,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 10, top: 5, right: 10),
                                        child: FutureBuilder(
                                            future: _translationController
                                                .getTransaltion(
                                              "${propertyList[index]
                                                  .propertyName}",
                                            ),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                return Text(
                                                  //  currentLanguage == Language.english ? 'Your Text Here' : translatedText.toString(),

                                                  snapshot.data!,
                                                  style: TextStyle(
                                                    color: const Color(
                                                        0xFF303030),
                                                    fontSize: 13,
                                                    fontFamily: GoogleFonts
                                                        .harmattan()
                                                        .fontFamily,
                                                    fontWeight:
                                                    FontWeight.w600,
                                                  ),
                                                );
                                              } else {
                                                return Row(children: [
                                                  Image.asset(
                                                    getResortImage(
                                                        propertyList[index]
                                                            .propertyType),
                                                    width: 25,
                                                    height: 25,
                                                  ),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  Text(
                                                    //  currentLanguage == Language.english ? 'Your Text Here' : translatedText.toString(),

                                                    "${propertyList[index]
                                                        .propertyName}",

                                                    style: TextStyle(
                                                      color: const Color(
                                                          0xFF303030),
                                                      fontSize: 13,
                                                      fontFamily: GoogleFonts
                                                          .harmattan()
                                                          .fontFamily,
                                                      fontWeight:
                                                      FontWeight.w500,
                                                    ),
                                                  ),
                                                ]);
                                              }
                                            }),
                                      ),
                                      const Spacer(),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            right: 10, top: 5, left: 10),
                                        child: FutureBuilder(
                                            future: _translationController
                                                .getTransaltion(
                                              " Unit Code(${propertyList[index]
                                                  .id})",
                                            ),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                return Text(
                                                  //  currentLanguage == Language.english ? 'Your Text Here' : translatedText.toString(),

                                                  snapshot.data!,
                                                  style: TextStyle(
                                                    color: const Color(
                                                        0xFF303030),
                                                    fontSize: 13,
                                                    fontFamily: GoogleFonts
                                                        .harmattan()
                                                        .fontFamily,
                                                    fontWeight:
                                                    FontWeight.w500,
                                                  ),
                                                );
                                              } else {
                                                return Text(
                                                  //  currentLanguage == Language.english ? 'Your Text Here' : translatedText.toString(),

                                                  'Unit Code(${propertyList[index]
                                                      .id})',
                                                  style: TextStyle(
                                                    color: const Color(
                                                        0xFF303030),
                                                    fontSize: 13,
                                                    fontFamily: GoogleFonts
                                                        .harmattan()
                                                        .fontFamily,
                                                    fontWeight:
                                                    FontWeight.w500,
                                                  ),
                                                );
                                              }
                                            }),
                                      ),
                                    ],
                                  ),

                                  Row(
                                    children: [],
                                  )
                                ],
                              )),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PropertyDetails(
                                        propertyList[index],
                                        widget.startDate,
                                        widget
                                            .endDate), //const PlayList( tag: 'Playlists',title:'Podcast'),
                              ),
                            );
                          },
                        );
                      },
                    )
                        : Center(
                      child: Text(
                        "No Property Found!",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: GoogleFonts
                              .harmattan()
                              .fontFamily,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.75,
                        ),
                      ),
                    ),
                  );
                }
                if (propertyController.isLoading.isTrue) {
                  return const Center(
                      child: CircularProgressIndicator(
                          color: AppColors.appColor));
                } else {
                  return const Text("No harmattannet connection");
                }
              })
            ],
          )),
    );
  }

  Future<PropertyObjects> getPropertyList() async {
    RetrofitInterface apiharmattanface = RetrofitInterface(Dio());

    String? token = await PrefManager.getString("token");

    try {
      return apiharmattanface.getPropertyList(token ?? "", widget.cityId,
          widget.startDate, widget.endDate, widget.propertyId);
    } catch (e) {
      rethrow; // Rethrow the exception to be handled by the FutureBuilder
    }
    // return apiharmattanface.getJobList("", "", "datePosted", "DESC");
  }

  //SfRangeValues values = const SfRangeValues(40.0, 80.0);
  void _showPriceSheet() {
    var startValue = 0.0;
    var endValue = 1500.0;

    Get.bottomSheet(
      Container(
        color: Colors.white,
        margin: const EdgeInsets.only(left: 10, right: 10),

        height: 200, // Adjust the height as needed
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Select the price range",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.only(top: 50, left: 50, right: 50),
                alignment: Alignment.centerLeft,
                child: FlutterSlider(
                  values: [startValue, endValue],
//              ignoreSteps: [
//                FlutterSliderIgnoreSteps(from: 120, to: 150),
//                FlutterSliderIgnoreSteps(from: 160, to: 190),
//              ],
                  max: 5000,
                  min: 0,
                  // maximumDistance: 300,
                  rangeSlider: true,
                  //  rtl: true,
                  handlerAnimation: const FlutterSliderHandlerAnimation(
                      curve: Curves.elasticOut,
                      reverseCurve: null,
                      duration: Duration(milliseconds: 700),
                      scale: 1.4),
                  onDragging: (handlerIndex, lowerValue, upperValue) {
                    setState(() {
                      startValue = lowerValue;
                      endValue = upperValue;
                      propertyController.filterProperties(
                          lowerValue, upperValue, "");
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }

  Set<int> selectedIds1 = <int>{};

  void _showApartmentList() {
    Get.bottomSheet(
      StatefulBuilder(builder: (context, setState) {
        return Container(
          color: Colors.white,
          margin: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 15),
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                    ),
                  ),
                  Text(
                    'choose_a_property',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: GoogleFonts
                          .harmattan()
                          .fontFamily,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.75,
                    ),
                  ).tr()
                ],
              ),
              Expanded(
                child: Obx(() =>
                    ListView.builder(
                      itemCount: _proType.wishlist.length,
                      itemBuilder: (BuildContext context, int index) {
                        bool values = propertyController.selectedIds
                            .contains(_proType.wishlist[index].propertyType!);

                        return Container(
                          margin: const EdgeInsets.only(left: 20, top: 15),
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              CircleAvatar(
                                  radius: 30, // Image radius
                                  backgroundImage: CachedNetworkImageProvider(
                                    _proType.wishlist[index].image!,
                                  )),
                              const SizedBox(
                                width: 10,
                              ),
                              FutureBuilder(
                                  future: _translationController.getTransaltion(
                                      _proType.wishlist[index].propertyType!),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Text(
                                        snapshot.data!,
                                        style: TextStyle(
                                          color: const Color(0xFF434343),
                                          fontSize: 18,
                                          fontFamily: GoogleFonts
                                              .harmattan()
                                              .fontFamily,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      );
                                    } else {
                                      return Text(
                                        _proType.wishlist[index].propertyType!,
                                        style: TextStyle(
                                          color: const Color(0xFF434343),
                                          fontSize: 18,
                                          fontFamily: GoogleFonts
                                              .harmattan()
                                              .fontFamily,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      );
                                    }
                                  }),
                              const Spacer(),
                              Checkbox(
                                value: values,
                                onChanged: (bool? value) {
                                  setState(() {
                                    values = !values;
                                    print("bool object ===>>$values");

                                    if (value != null && value) {
                                      propertyController.toggleSelection(
                                          _proType
                                              .wishlist[index].propertyType!);
                                    } else {
                                      propertyController.toggleSelection(
                                          _proType
                                              .wishlist[index].propertyType!);
                                    }
                                  });
                                },
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        );
                      },
                    )),
              ),
            ],
          ),
        );
      }),
      backgroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }

  _showSearchCityBottomSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        color: Colors.white,
        margin: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 15),
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      )),
                ),
                FutureBuilder(
                    future: _translationController
                        .getTransaltion('your_destination?'),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          snapshot.data!,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: GoogleFonts
                                .harmattan()
                                .fontFamily,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.75,
                          ),
                        );
                      } else {
                        return Text(
                          " Choose Destination",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: GoogleFonts
                                .harmattan()
                                .fontFamily,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.75,
                          ),
                        );
                      }
                    }),
              ],
            ),
            Expanded(
                child: ListView.builder(
                  itemCount: _proType.cityList.length,
                  //_proType.cityList.length,

                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        margin: const EdgeInsets.only(
                            left: 20, top: 15, right: 20),
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          onTap: () {
                            cityId = _proType.cityList[index].id!;
                            //  _showDateSheet(context, index);

                            _showApparmentBottomSheet(context, index);
                          },
                          child: Row(
                            children: [
                              CircleAvatar(
                                  radius: 30, // Image radius
                                  backgroundImage: CachedNetworkImageProvider(
                                    _proType.cityList[index].image!,
                                  )),
                              const SizedBox(
                                width: 10,
                              ),
                              FutureBuilder(
                                  future: _translationController.getTransaltion(
                                      _proType.cityList[index].name!),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Text(
                                        snapshot.data!,
                                        style: TextStyle(
                                          color: const Color(0xFF434343),
                                          fontSize: 15,
                                          fontFamily:
                                          GoogleFonts
                                              .harmattan()
                                              .fontFamily,
                                          fontWeight: FontWeight.w500,
                                          height: 1.67,
                                        ),
                                      );
                                    } else {
                                      return Text(
                                        _proType.cityList[index].name!,
                                        style: TextStyle(
                                          color: const Color(0xFF434343),
                                          fontSize: 15,
                                          fontFamily:
                                          GoogleFonts
                                              .harmattan()
                                              .fontFamily,
                                          fontWeight: FontWeight.w500,
                                          height: 1.67,
                                        ),
                                      );
                                    }
                                  }),
                            ],
                          ),
                        ));
                  },
                )),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }

  void _showApparmentBottomSheet(BuildContext context, int index) {
    Get.bottomSheet(
      Container(
        color: Colors.white,
        margin: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 15, right: 15),
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                  ),
                ),
                FutureBuilder(
                    future: _translationController
                        .getTransaltion('choose_a_property'),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(snapshot.data!,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontFamily: GoogleFonts.harmattan().toString(),
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.75,
                            ));
                      } else {
                        return Text(
                          'Choose Properties',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: GoogleFonts.harmattan().toString(),
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.75,
                          ),
                        );
                      }
                    }),
              ],
            ),
            Expanded(
                child: ListView.builder(
                  itemCount: _proType.propertyType.length,
                  // propertyType.length,

                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        margin: const EdgeInsets.only(
                            left: 20, top: 15, right: 20),
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          onTap: () {
                            propertyId = propertyList[index].id!;
                            //  _showDateSheet(context, index);
                            Navigator.pop(context);

                            Navigator.pop(context);
                            propertyController.fetchProperties(cityId,
                                widget.startDate, widget.endDate, propertyId);
                          },
                          child: Row(
                            children: [
                              CircleAvatar(
                                  radius: 30, // Image radius
                                  backgroundImage: CachedNetworkImageProvider(
                                    _proType.propertyType[index].image!,
                                  )),
                              const SizedBox(
                                width: 10,
                              ),
                              FutureBuilder(
                                  future: _translationController.getTransaltion(
                                      _proType.propertyType[index]
                                          .propertyType!),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Text(
                                        snapshot.data!,
                                        style: TextStyle(
                                          color: const Color(0xFF434343),
                                          fontSize: 18,
                                          fontFamily:
                                          GoogleFonts
                                              .harmattan()
                                              .fontFamily,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      );
                                    } else {
                                      return Text(
                                        _proType.propertyType[index]
                                            .propertyType!,
                                        style: TextStyle(
                                          color: const Color(0xFF434343),
                                          fontSize: 18,
                                          fontFamily:
                                          GoogleFonts
                                              .harmattan()
                                              .fontFamily,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      );
                                    }
                                  }),
                            ],
                          ),
                        ));
                  },
                )),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }

  String getResortImage(String? propertyType) {
    debugPrint("type:  $propertyType");

    switch (propertyType) {
      case "resort Houses":
        return "assets/images/resort.png";

      case "cravans & Kepr":
        return "assets/images/vacations.png";

      case "farm Houses":
        return "assets/images/farmer.png";

      case "hotel":
        return "assets/images/hotel.png";

      case "Motel & Apartments":
        return "assets/images/motel.png";

      default:
        return "assets/images/resort.png";
    }
  }
}

class FilterBox extends StatefulWidget {
  final String label;
  final ValueChanged<bool> onSelected;
  final IconData icon;

  FilterBox(
      {required this.label, required this.onSelected, required this.icon});

  @override
  _FilterBoxState createState() => _FilterBoxState();
}

class _FilterBoxState extends State<FilterBox> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
        widget.onSelected(isSelected);
      },
      child: Container(
        height: 30,
        padding: const EdgeInsets.only(right: 10, left: 10),
        margin: const EdgeInsets.only(right: 10, left: 10),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.lightGrey,
            width: 2, // Adjust the width of the border as needed
          ),
          color: isSelected ? AppColors.appColor : AppColors.lightGrey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              widget.icon,
              color: isSelected ? Colors.white : Colors.black,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              widget.label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontFamily: GoogleFonts
                    .harmattan()
                    .fontFamily,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (isSelected)
              IconButton(
                icon: const Icon(
                  Icons.clear,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    isSelected = false;
                  });
                  widget.onSelected(false);
                },
              ),
          ],
        ),
      ),
    );
  }
}
