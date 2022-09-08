import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:photo_view/photo_view.dart';

import '../shared/component.dart';

class ImageViewScreen extends StatelessWidget {
  String image;
  ImageViewScreen(this.image, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Hero(
              tag: image,
              child: PhotoView(
                imageProvider: NetworkImage(image),
                backgroundDecoration: const BoxDecoration(color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15, top: 10),
            child: IconButton(
                onPressed: () async {
                  final ByteData imageData =
                      await NetworkAssetBundle(Uri.parse(image)).load("");
                  final Uint8List bytes = imageData.buffer.asUint8List();
                  await ImageGallerySaver.saveImage(bytes,
                      quality: 100, name: "newimage");
                  defaultShowToAst(
                      isError: false, msg: 'Image Saved Successfully');
                },
                icon: const Icon(
                  Icons.save_alt,
                  color: Colors.black,
                  size: 40,
                )),
          )
        ],
      ),
    );
  }
}
