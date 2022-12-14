import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';

class GalleryWidget extends StatefulWidget {

  final List<String> urlImages;
  final int index;
  final PageController pageController;
  // ignore: use_key_in_widget_constructors
  GalleryWidget({
    required this.urlImages,
    this.index = 0,
  }) : pageController = PageController(initialPage: index);
  @override
  State<GalleryWidget> createState() => _GalleryWidgetState();
}
class _GalleryWidgetState extends State<GalleryWidget> {
  var urlImage;

  @override
  void initState() {
    var provider = NetworkImage(widget.urlImages[widget.index]);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        //backgroundColor: whitecolor,
        centerTitle: true,
        title: const Text(
          'Gallery',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: PhotoViewGallery.builder(
              pageController: widget.pageController,
              itemCount: widget.urlImages.length,
              builder: (context, index) {
                urlImage = widget.urlImages[index];
                return PhotoViewGalleryPageOptions(
                  imageProvider: NetworkImage(urlImage),
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.contained*4,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}