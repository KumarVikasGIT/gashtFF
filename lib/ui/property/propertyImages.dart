import 'package:flutter/material.dart';
import 'package:gallery_image_viewer/gallery_image_viewer.dart';
import 'package:gasht/util/colors.dart';


import 'package:onyxsio_grid_view/onyxsio_grid_view.dart';

class PropertyImages extends StatefulWidget{
  List<String> images;
   PropertyImages( this.images, {super.key});

  @override
  State<PropertyImages> createState() => _PropertyImages ();

}

class _PropertyImages extends State<PropertyImages> {


  late List<ImageProvider> _imageProviders;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_imageProviders = widget.images.map((e) =>Image.network(e)).image.toList();


      _imageProviders = widget.images.map((url) => NetworkImage(url)).toList();


    /*[
      Image.network("https://picsum.photos/id/237/200/300").image,
      Image.network("https://picsum.photos/seed/picsum/200/300").image,
      Image.network("https://picsum.photos/200/300?grayscale").image,
      Image.network("https://picsum.photos/200/300").image,
      Image.network("https://picsum.photos/200/300?grayscale").image
    ];*/
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text("Property Images",style: TextStyle(color: Colors.white),),
      ),
      body: OnyxsioGridView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: widget.images.length,
        physics: const BouncingScrollPhysics(),
        staggeredTileBuilder: (index) =>
        // OnyxsioStaggeredTile.count(2, index.isEven ? 2 : 1),
        // OnyxsioStaggeredTile.extent(2, index.isEven ? 200 : 50),
        const OnyxsioStaggeredTile.fit(2),
        crossAxisCount: 4,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        shrinkWrap: true,
        itemBuilder: (context, index) =>
            OnyxsioGridTile(
              index: index,
              heightList: const [300, 220, 220, 520],
              child: InkWell(
                  onTap: (){
                    MultiImageProvider multiImageProvider =
                    MultiImageProvider(_imageProviders,initialIndex: index);
                    showImageViewerPager(context, multiImageProvider,
                        swipeDismissible: true);

                  },
                  child: Container(child: Image.network(widget.images[index],fit: BoxFit.fill,),)),
            ),
      ),
    );
  }
}