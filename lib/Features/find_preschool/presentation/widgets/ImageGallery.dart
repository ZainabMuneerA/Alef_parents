import 'package:alef_parents/core/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImageGallery extends StatelessWidget {
  final List<String>? imageUrls;

  ImageGallery({required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ClipRRect(
        borderRadius: BorderRadius.circular(16), 
        child: PhotoViewGallery.builder(
          itemCount: imageUrls?.length ?? 0,
          builder: (context, index) {
               final imageUrl = imageUrls?[index] ?? 'lib/assets/images/imageHolder.jpeg';
            final imageProvider = imageUrl.startsWith('http')
                ? NetworkImage(imageUrl)
                : AssetImage(imageUrl) as ImageProvider<Object>;

            return PhotoViewGalleryPageOptions(
              imageProvider: imageProvider,
             
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.covered * 2,
            );
          },
          scrollPhysics: BouncingScrollPhysics(),
          backgroundDecoration: BoxDecoration(
            color: primaryColor,
          ),
          pageController: PageController(),
        ),
      ),
    );
  }
}
