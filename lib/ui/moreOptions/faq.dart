import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gasht/ui/controllers/langaugeCotroller.dart';
import 'package:gasht/ui/moreOptions/controllers/faqControllers.dart';
import 'package:gasht/util/colors.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';

import '../../api/retrofit_interface.dart';
import '../../data_models/model_faq.dart';
import 'package:dio/dio.dart';

import '../../util/exapndedPanel.dart';

class FAQ extends StatefulWidget{
  const FAQ({super.key});

  @override
  State<FAQ> createState() => _FAQ ();

}

class _FAQ extends State<FAQ> {
  late  List<ExpansionPanelItemFaq> _data ;
  final TextEditingController _searchController = TextEditingController();
  late Future<Model_Faq> _faqFuture; // Store the FAQ data in a future
  List<Faq> _faqList = []; // Store the FAQ data locally


  final TranslationController _translationController = Get.put(TranslationController());

  final FAQCOontroller _faqcOontroller = Get.put(FAQCOontroller());

  @override
  void initState() {
    super.initState();
   // _faqFuture = getAllFaq();
    _faqcOontroller.fetchProperties();
    //
    // Fetch FAQ data when the widget initializes
  }

  Future<Model_Faq> getAllFaq() async {
    RetrofitInterface apiInterface = RetrofitInterface(Dio());
    return apiInterface.getfaq();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: AppColors.appColor,
        centerTitle: false,
        title:
        FutureBuilder(future: _translationController.getTransaltion( "fAQ"),
            builder: (context,snapshot){
              if(snapshot.hasData)
              {
                return            SizedBox(child: Text(snapshot.data!,
                  style: TextStyle(color: Colors.white,fontFamily: GoogleFonts.poppins().fontFamily,
                      fontSize: 18),),);

              }
              else
              {
                return

                  SizedBox(child: Text("FAQ",style: TextStyle(color: Colors.white,fontFamily: GoogleFonts.poppins().fontFamily,fontSize: 18),),);

              }
            })

      ),
      body: Column(
        children: [

          const SizedBox(height: 20,),

          Container(
            margin: const EdgeInsets.only(left: 10,right: 10,top: 10),
            child:   const Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'We’re here to help you with anything and everyting on ',
                    style: TextStyle(
                      color: Color(0xFF595656),
                      fontSize: 13,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextSpan(
                    text: 'Gasht | گەشت',
                    style: TextStyle(
                      color: Color(0xFF595656),
                      fontSize: 13,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),




          Container(
            margin: const EdgeInsets.only(left: 10,right: 10,top: 10),
            child:   Text(
              'By your use of this app, you confirm your acceptance and it would be accepted as would a written agreement would a written agreement\n\n',
              style: TextStyle(
                color: const Color(0xFF525252),
                fontSize: 12,
                fontFamily: GoogleFonts.poppins.toString(),
                fontWeight: FontWeight.w400,
                height: 1.83,
              ),
            ),
          ),


          Container(
            margin: const EdgeInsets.only(top: 10,left: 10,right: 10),
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
              maxLines: 1,
              controller: _searchController,
              onChanged: (query) {
                _faqcOontroller.searchProperties(query);
              },
              decoration: InputDecoration(
                hintText: tr('search'),
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



          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(left: 10,right: 10,top: 20),
            child:

            Text(
              tr("fAQ"),
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontFamily: GoogleFonts.poppins.toString(),
                fontWeight: FontWeight.w600,
                height: 1.83,
              ),
            ),
          ),



          Obx(() {
            if(_faqcOontroller.isLoading.isFalse)
              {

                _faqList = _faqcOontroller.filteredProperties;

                return    Expanded(
                  child: ListView.builder(
                    itemCount: _faqList.length,
                    itemBuilder: (BuildContext context, int index) {

                      return Card1(_faqList[index].title!,_faqList[index].description!) ;
                    },
                  ),
                );
              }
            if (_faqcOontroller.isLoading.isTrue) {
              return const Center(
                  child: CircularProgressIndicator(color:AppColors.appColor));
            }

            else {
              return const Text("No internet connection");
            }
          }),


      /*    FutureBuilder<Model_Faq>(
            future: _faqFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator(color: Colors.green));
              } else if (snapshot.hasData) {
                // Store the FAQ data locally
                _faqList = snapshot.data!.faqs ?? [];
                List<ExpansionPanelItemFaq> faqItems = generateFaqItems(_faqList.length, _faqList);
                return ExpansionPanelList(
                  elevation: 1,
                  expansionCallback: (int index, bool isExpanded) {
                    setState(() {
                      faqItems[index].isExpanded = !isExpanded;
                    });
                  },
                  children: faqItems.map<ExpansionPanel>((ExpansionPanelItemFaq item) {
                    return ExpansionPanel(
                      canTapOnHeader: true,
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return ListTile(
                          title: Text(
                            item.headerValue,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        );
                      },
                      body: ListTile(
                        title: Text(item.expandedValue),
                      ),
                      isExpanded: item.isExpanded,

                    );
                  }).toList(),
                );
              } else if (snapshot.hasError) {
                return Center(
                    child: Text("Encountered an error: ${snapshot.error}"));
              } else {
                return const Text("No FAQs available.");
              }
            },
          ),*/




        ],
      ),
    );
  }

 static  List<ExpansionPanelItemFaq> generateFaqItems(int numberOfItems, List<Faq?> faqList) {
    return List<ExpansionPanelItemFaq>.generate(numberOfItems, (int index) {
      return ExpansionPanelItemFaq(
        headerValue: '${faqList[index]?.title}',
        expandedValue: '${faqList[index]?.description}',
          isExpanded:false,
      );
    });

  }
}
class ExpansionPanelItemFaq {
  ExpansionPanelItemFaq({
    required this.headerValue,
    required this.expandedValue,
    this.isExpanded = true,
  });

  String headerValue;
  String expandedValue;
  bool isExpanded;
}