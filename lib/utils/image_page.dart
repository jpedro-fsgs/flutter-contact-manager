import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImagePage extends StatelessWidget {
  final String imagePath;
  final String title;

  const ImagePage({super.key, required this.imagePath, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Hero(
        tag: imagePath,
        child: PhotoView(
          backgroundDecoration: const BoxDecoration(color: Colors.transparent),
          maxScale: PhotoViewComputedScale.contained * 4.0,
          minScale: PhotoViewComputedScale.contained,
          strictScale: true,
          imageProvider: FileImage(File(imagePath)),
        ),
      ),
    );
  }
}
