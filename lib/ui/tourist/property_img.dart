import 'package:flutter/material.dart';
import 'package:gallery_image_viewer/gallery_image_viewer.dart';
import 'package:onyxsio_grid_view/onyxsio_grid_view.dart';

import '../../data_models/model_propertyList.dart';

class PropertyImg extends StatefulWidget {
  const PropertyImg({super.key,required this.property});
  final Property property;

  @override
  State<PropertyImg> createState() => _PropertyImgState();
}

class _PropertyImgState extends State<PropertyImg> {

   List<ImageProvider>? _imageProviders;
   List? images;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    images = widget.property.images;
    _imageProviders = images!.map((url) => NetworkImage(url)).toList();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          OnyxsioGridView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: images!.length,
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
                        MultiImageProvider(_imageProviders!,initialIndex: index);
                        showImageViewerPager(context, multiImageProvider,
                            swipeDismissible: true);

                      },
                      child: Container(child: Image.network(images![index],fit: BoxFit.cover,),)),
                ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: IconButton(
              onPressed: () {
                print("ds");
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_sharp,color: Colors.white,size: 30,),
            ),
          ),

        ],
      ),
    );
  }
}
