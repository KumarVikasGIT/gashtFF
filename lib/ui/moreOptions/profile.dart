import 'dart:io';
import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gasht/loadingScreen.dart';
import 'package:gasht/ui/authentication/login.dart';
import 'package:gasht/ui/controllers/langaugeCotroller.dart';
import 'package:gasht/ui/dashboard/bottomDashboard.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_image_picker_plus/multi_image_picker_plus.dart';
import 'package:path_provider/path_provider.dart';

import '../../api/retrofit_interface.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../../data_models/model_login.dart';
import '../../data_models/model_profile.dart';
import '../../util/colors.dart';
import '../prefManager.dart';

class Profile extends StatefulWidget {


  String type;
   Profile(this.type, {Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _Profile();
}

class _Profile extends State<Profile> with WidgetsBindingObserver {

  final TextEditingController controllerFullName = TextEditingController();

  final TranslationController _translationController = Get.put(TranslationController());

  RetrofitInterface apiInterface = RetrofitInterface(Dio());
  late Model_Profile profile_model;


  final logger = Logger();

   bool visiable = false ;
  bool image = false ;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);



    // Fetch profile data and set initial values for controllers
    fetchProfileData();

    if(widget.type =="Owner"){
      visiable = false;
      image = false;
    }

  }

  List<Asset> images = <Asset>[];
  List<File> files = [];


  // Fetch profile data and set initial values for controllers
  Future<void> fetchProfileData() async {
    try {
      String? token = await PrefManager.getString("token");

      if (token != null) {

        profile_model = await apiInterface.getProfile(token,widget.type);

        controllerFullName.text = profile_model.fullname ?? "";

       if(widget.type=="Customer") {
          if (profile_model.id_proof == null ||
              profile_model.id_proof!.isEmpty) {

            setState(() {
              visiable = true;
            });
          }
          if(profile_model.id_proof!.isNotEmpty)
            {
              image = true;
              visiable = false;
            }
        }

      } else {

        Navigator.of(context).pop();

        Navigator.push(context, MaterialPageRoute(builder: (context){
          return const Login("Customer");
        }));


      }

    } catch (e) {
      // Handle the exception appropriately
      print("Error fetching profile data: $e");
    }
  }

  @override
  void dispose() {
    // Dispose the controllers
    controllerFullName.dispose();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.white, //change your color here
          ),
          backgroundColor: AppColors.appColor,
          title:

          FutureBuilder(future: _translationController.getTransaltion( "profile"),
              builder: (context,snapshot){
                if(snapshot.hasData)
                {
                  return       Text(
                    snapshot.data!,
                    textAlign: TextAlign.center,

                    style: TextStyle(fontFamily: GoogleFonts
                        .harmattan()
                        .fontFamily,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  );
                }
                else
                {
                  return

                    Text("Profile", style: TextStyle(fontFamily: GoogleFonts
                        .harmattan()
                        .fontFamily,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                    )
                  ;
                }
              }),


        ),
        body:

        FutureBuilder<Model_Profile>(
            future: getProfileData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator(
                        color: Colors.green));
              }
              else if (snapshot.hasData) {
                profile_model = snapshot.data!;

                return SingleChildScrollView(
                  child: Column(children: [

                    Container(

                      margin: const EdgeInsets.only(
                          left: 10, right: 10, top: 20),

                      child: Column(children: [


                        const SizedBox(height: 20),
                        //for email field
                        TextFormField(
                            style: const TextStyle(color: Colors.black),
                            // Set the text color
                            controller: controllerFullName,
                            onFieldSubmitted: (value) {},

                            decoration: InputDecoration(
                              labelText: tr("full_Name"),
                              labelStyle: const TextStyle(
                                  color: Colors.black),

                              prefixIcon: const Icon(Icons.account_circle,
                                color: Colors.black,),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.grey),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.grey),
                                // Use the same color as enabled state
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) {
                              return null;
                            }
                        ),

                        const SizedBox(height: 20),
                        //for email field
                        TextFormField(
                            enabled: false,
                            style: const TextStyle(color: Colors.black),
                            // Set the text color
                            initialValue: profile_model.email,

                            onFieldSubmitted: (value) {},
                            decoration: InputDecoration(
                              labelText: tr("email"),
                              labelStyle: const TextStyle(
                                  color: Colors.black),

                              prefixIcon: const Icon(
                                Icons.alternate_email,
                                color: Colors.black,),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.grey),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.grey),
                                // Use the same color as enabled state
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) {
                              return null;
                            }
                        ),


                        const SizedBox(height: 20),



                        Visibility(

                          visible: visiable,
                            child:
                            Container(
                              alignment: Alignment.topLeft,
                              margin: const EdgeInsets.only(left: 10,right: 10),
                              child:
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [


                                FutureBuilder(future: _translationController.getTransaltion( "Update ID"),
                                    builder: (context,snapshot){
                                      if(snapshot.hasData)
                                      {
                                        return       Text(
                                          snapshot.data!,
                                          textAlign: TextAlign.center,

                                          style: TextStyle(fontFamily: GoogleFonts
                                              .harmattan()
                                              .fontFamily,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                          ),
                                        );
                                      }
                                      else
                                      {
                                        return

                                          Text("Update ID", style: TextStyle(fontFamily: GoogleFonts
                                              .harmattan()
                                              .fontFamily,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                          ),
                                          )
                                        ;
                                      }
                                    }),


                               InkWell(
                                 onTap: (){

                                   loadAssets();
                                 },

                                 child: SizedBox(
                                   width: double.maxFinite,
                                   height: 50,
                                   child: Image.asset(
                                     "assets/images/gallery.png"
                                   ),

                                 ),
                               ),

                                  Center(
                                    child: FutureBuilder(future: _translationController.getTransaltion( "Add Images"),
                                        builder: (context,snapshot){
                                          if(snapshot.hasData)
                                          {
                                            return       Text(
                                              snapshot.data!,
                                              textAlign: TextAlign.center,

                                              style: TextStyle(fontFamily: GoogleFonts
                                                  .harmattan()
                                                  .fontFamily,
                                                color: Colors.blue,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                              ),
                                            );
                                          }
                                          else
                                          {
                                            return

                                              Text("Add Images", style: TextStyle(fontFamily: GoogleFonts
                                                  .harmattan()
                                                  .fontFamily,
                                                color: Colors.blue,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                              ),
                                              )
                                            ;
                                          }
                                        }),
                                  ),
                                  
                                const  SizedBox(height: 10,),


                              ],)

                              ,
                            )




                        ),


                        const SizedBox(height: 20),



                        Visibility(

                            visible: image,
                            child:
                            Container(
                              alignment: Alignment.topLeft,
                              margin: const EdgeInsets.only(left: 10,right: 10),
                              child:
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [


                                  FutureBuilder(future: _translationController
                                      .getTransaltion( "iD_Proof"),
                                      builder: (context,snapshot){
                                        if(snapshot.hasData)
                                        {
                                          return       Text(
                                            snapshot.data!,
                                            textAlign: TextAlign.center,

                                            style: TextStyle(fontFamily: GoogleFonts
                                                .harmattan()
                                                .fontFamily,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                            ),
                                          );
                                        }
                                        else
                                        {
                                          return

                                            Text("Update ID", style: TextStyle(fontFamily: GoogleFonts
                                                .harmattan()
                                                .fontFamily,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                            ),
                                            )
                                          ;
                                        }
                                      }),



                                  const  SizedBox(height: 10,),

                                  Center(child: Image.network(profile_model.id_proof!,scale: 10,)),



                                ],)

                              ,
                            )




                        ),
                        const SizedBox(height: 20),


                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.appColor,
                            elevation: 2.5,
                            minimumSize: const Size.fromHeight(50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ), onPressed: () async {
                          // loginValidator(context);

                          buildLoading(context);
                          updateProfile().then((value)
                              {
                                if(value)
                                  {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                         SnackBar(content:const Text(
                                            'Profile_Updated_Successfully').tr(),
                                          backgroundColor: Colors.green,));
                                    Navigator.pop(context);
                                  }
                                else
                                  {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text(
                                            'Failed to update Profile'),
                                          backgroundColor: Colors.red,));
                                    Navigator.pop(context);

                                  }


                              });





                         // bool? updated = true; //await updateProfile();
                       /*   if (await updateProfile()) {
                            await fetchProfileData();
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text(
                                    'Profile Updated Successfully'),
                                  backgroundColor: Colors.green,));
                          }*/
                        }, child:









                        FutureBuilder(future: _translationController.getTransaltion( "update"),
                            builder: (context,snapshot){
                              if(snapshot.hasData)
                              {
                                return       Text(
                                  snapshot.data!,
                                  textAlign: TextAlign.center,

                                    style: TextStyle(fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: GoogleFonts
                                            .lato()
                                            .fontFamily,
                                        color: Colors.white)
                                );
                              }
                              else
                              {
                                return

                                  Text(
                                      "Update", style: TextStyle(fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: GoogleFonts
                                          .lato()
                                          .fontFamily,
                                      color: Colors.white))
                                ;
                              }
                            }),


                        ),
                        const SizedBox(height: 20),


                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.appColor,
                            elevation: 2.5,
                            minimumSize: const Size.fromHeight(50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ), onPressed: () async {
                          // loginValidator(context);


                          PrefManager.clearPref();
  
                          Get.offAll(const DashboardBottom());



                        }, child:









                        FutureBuilder(future: _translationController.getTransaltion( "Delete Account"),
                            builder: (context,snapshot){
                              if(snapshot.hasData)
                              {
                                return       Text(
                                    snapshot.data!,
                                    textAlign: TextAlign.center,

                                    style: TextStyle(fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: GoogleFonts
                                            .lato()
                                            .fontFamily,
                                        color: Colors.white)
                                );
                              }
                              else
                              {
                                return

                                  Text(
                                      "Delete Account", style: TextStyle(fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: GoogleFonts
                                          .lato()
                                          .fontFamily,
                                      color: Colors.white))
                                ;
                              }
                            }),


                        ),
                        const SizedBox(height: 20),


                      ],),
                    ),


                  ],),
                );
              }

              else if (snapshot.hasError) {
                //  profileModel = snapshot!;
                return Center(
                    child: Text(
                        "Encountered an error: ${snapshot.error}"));
              }
              else {
                return const Text("No internet connection");
              }
            }


        )
    );
  }

  Future<Model_Profile> getProfileData() async {
    try {
      String? token = await PrefManager.getString("token");

      if (token != null) {
        //  int userId = int.parse(token);
        return apiInterface.getProfile(token,widget.type);
      } else {
        // Handle the case where the token is null
        throw Exception("Token is null");
      }
    } catch (e) {
      rethrow; // Rethrow the exception to be handled by the FutureBuilder
    }
  }



  Future<bool> updateProfile() async {
    try {
      String? token = await PrefManager.getString("token");


      if (token != null) {
        logger.d("token ==>>>   $token");
        Model_Login updateProfile = await apiInterface.setprofile(
            token,
            controllerFullName.text,
            widget.type
        );

        logger.d("updates profile === ${updateProfile.message}");
        if (updateProfile.status == "true") {
          return true;
        }
        else {
          return false;
        }
      }
      else {

        // Handle the case where the token is null
        throw Exception("Token is null");
      }
    } catch (e) {
      rethrow; // Rethrow the exception to be handled by the FutureBuilder
    }
  }



  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    const AlbumSetting albumSetting = AlbumSetting(
      fetchResults: {
        PHFetchResult(
          type: PHAssetCollectionType.smartAlbum,
          subtype: PHAssetCollectionSubtype.smartAlbumUserLibrary,
        ),
        PHFetchResult(
          type: PHAssetCollectionType.smartAlbum,
          subtype: PHAssetCollectionSubtype.smartAlbumFavorites,
        ),
        PHFetchResult(
          type: PHAssetCollectionType.album,
          subtype: PHAssetCollectionSubtype.albumRegular,
        ),
        PHFetchResult(
          type: PHAssetCollectionType.smartAlbum,
          subtype: PHAssetCollectionSubtype.smartAlbumSelfPortraits,
        ),
        PHFetchResult(
          type: PHAssetCollectionType.smartAlbum,
          subtype: PHAssetCollectionSubtype.smartAlbumPanoramas,
        ),
        PHFetchResult(
          type: PHAssetCollectionType.smartAlbum,
          subtype: PHAssetCollectionSubtype.smartAlbumVideos,
        ),
      },
    );

    String error = 'No Error Detected';



    const SelectionSetting selectionSetting = SelectionSetting(
      min: 0,
      max: 3,
      unselectOnReachingMax: true,
    );
    const DismissSetting dismissSetting = DismissSetting(
      enabled: true,
      allowSwipe: true,
    );
    const ThemeSetting themeSetting = ThemeSetting(
      backgroundColor: AppColors.appColor,
      selectionFillColor: AppColors.appColor,
      selectionStrokeColor: AppColors.appColor,
      previewSubtitleAttributes: TitleAttribute(fontSize: 12.0),
      previewTitleAttributes: TitleAttribute(
        foregroundColor: AppColors.appColor,
      ),
      albumTitleAttributes: TitleAttribute(
        foregroundColor:AppColors.appColor,
      ),
    );
    const ListSetting listSetting = ListSetting(
      spacing: 5.0,
      cellsPerRow: 4,
    );




    const CupertinoSettings iosSettings = CupertinoSettings(
      fetch: FetchSetting(album: albumSetting),
      theme: themeSetting,
      selection: selectionSetting,
      dismiss: dismissSetting,
      list: listSetting,
    );
    try {
      resultList = await MultiImagePicker.pickImages(

        selectedAssets: images,
        cupertinoOptions:const CupertinoOptions(
          doneButton:
          UIBarButtonItem(title: 'Confirm', tintColor:AppColors.appColor),
          cancelButton:
          UIBarButtonItem(title: 'Cancel', tintColor: Colors.red),
          albumButtonColor: AppColors.appColor,
          settings: iosSettings,
        ),
        materialOptions: const MaterialOptions(
          actionBarColor: AppColors.appColor,
          actionBarTitle: "Pick photos",
          allViewTitle: "All Photos",
          enableCamera: true,
          useDetailsView: true,
          maxImages: 1,
          selectCircleStrokeColor: AppColors.appColor,
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }
    if (!mounted) return;

    setState(() {
      images = resultList;
      multipart();
    });
  }
  bool selectedImg = false;

  Future<void> multipart() async {
    // ... (Your existing code to fetch images)

    // Prepare the images for upload as MultipartFile objects

    List <File> file = [];

    for (Asset asset in images) {
      ByteData byteData = await asset.getByteData();
      final buffer = byteData.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final tempFile = File('${tempDir.path}/${asset.name}');

      await tempFile.writeAsBytes(buffer);

      if (tempFile.existsSync()) {
        file.add(tempFile);
        selectedImg = true;

        updateImage(tempFile);

      }




    }

    setState(() {
      files = file;
    });





  }






  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:

        break;
      case AppLifecycleState.resumed:

        fetchProfileData();
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

  Future<void> updateImage(File tempFile) async {





    buildLoading(context);
    Dio dio = Dio();
    dio.options.baseUrl = 'https://gasht.co/public/api';

    String ? token  = await PrefManager.getString("token");

    FormData formData = FormData();
    formData.fields.add(MapEntry('token', token!));
    formData.fields.add(const MapEntry('user_type', "Customer"));
    formData.files.add(
      MapEntry(
        'image',
        await MultipartFile.fromFile(tempFile.path),
      ),
    );
    Response response = await dio.post(
      '/setprofile',
      // Replace with your API endpoint for uploading business data
      data: formData,
    );
    if (response.statusCode == 200) {

      Get.snackbar( "Id uploaded successfully", "",colorText: Colors.white,backgroundColor: Colors.green,snackPosition: SnackPosition.BOTTOM);

      setState(() {
        visiable=false;
      });
      Navigator.pop(context);

    //  return true;
    } else {

      Get.snackbar( "Failed to upload the Id", "",colorText: Colors.white,backgroundColor: Colors.red,snackPosition: SnackPosition.BOTTOM);
      Navigator.pop(context);

      print(
          '=====>>>>>>>>>Failed to upload business data. Status code: ${response
              .statusCode}');
    //  return false;
    }
  }

}