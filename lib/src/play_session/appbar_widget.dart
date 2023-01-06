// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_template/services/apiBack4app_service.dart';
import 'package:image_picker/image_picker.dart';

class AppBarWidget extends StatefulWidget  with PreferredSizeWidget{
  AppBarWidget( this.urlImages,);
  final List urlImages;

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
  
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _AppBarWidgetState extends State<AppBarWidget> {

  var transformedImages = [];
   List<XFile>? imageFileList;

  void _setImageFileListFromFile(XFile? value) {
    imageFileList = value == null ? null : <XFile>[value];
  }

  Future<dynamic> getSizeOfImages() async {
    transformedImages = [];
    for (int i = 0; i < widget.urlImages.length; i++) {
      final imageObject = {};
      await rootBundle.load(widget.urlImages[i]).then((value) => {
            imageObject['path'] = widget.urlImages[i],
            imageObject['size'] = value.lengthInBytes,
          });
      transformedImages.add(imageObject);
    }
  }
  Future<dynamic> sortImagesByIncreseSize() async {
 transformedImages.sort((a, b) => a['size'].compareTo(b['size']));
}

Future<dynamic> sortImagesByDecreseSize() async {
 transformedImages.sort((b, a) => a['size'].compareTo(b['size']));
}

Future<dynamic> sortImagesByNamesIncrease() async {
 transformedImages.sort((a, b) => a['path'].compareTo(b['path']));
}

Future<dynamic> sortImagesByNamesDecrease() async {
 transformedImages.sort((b, a) => a['path'].compareTo(b['path']));
}

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
     // backgroundColor: whitecolor,
      centerTitle: true,
      // title: Text(
      //   widget.title,
      //   style: const TextStyle(color: blackcolor),
      // ),
      iconTheme: const IconThemeData(color: Colors.black),
      actions: <Widget>[
        GestureDetector(
          onTap: () {
            // show the dialog
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: Colors.white,
                  title: const Text("Menu"),
                  // content: const Text("This is my message."),
                  actions: contentBox(context),
                );
              },
            );
          },
          child: Container(
            margin: const EdgeInsets.only(right: 20),
            child: const Icon(Icons.more_vert),
          ),
        )
      ],
    );
  }


  contentBox(BuildContext context) {
    return <Widget>[
        TextButton(
          child: Container(
            color: Colors.grey,
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Icon(Icons.add_a_photo),
          ),
          onPressed: () {
            getPicture();
                
            
          },
        ),
        Text("Filter By ", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
        TextButton(
          child: Column(
            children: const [
              Text('By size (Ascending)'),
            ],
          ),
          onPressed: () {
            sortImagesByIncreseSize()
                .then((value) => setState(() {}));
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: Column(
            children: const [
              Text('By size (descending)'),
            ],
          ),
          onPressed: () {
            sortImagesByDecreseSize()
                .then((value) => setState(() {}));
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: Column(
            children: const [
              Text('By name (Ascending)'),
            ],
          ),
          onPressed: () {
            sortImagesByNamesIncrease()
                .then((value) => setState(() {}));
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: Column(
            children: const [
              Text('By name (descending)'),
            ],
          ),
          onPressed: () {
            sortImagesByNamesDecrease()
                .then((value) => setState(() {}));
            Navigator.pop(context);
          },
        ),
      ];
    
  }
  
  getPicture() async {
    final ApiBack4App apiBack4app = ApiBack4App();
    XFile? pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery
    );
    if (pickedFile != null) {
       // XFile imageFile = XFile(pickedFile.path);
    }
    setState(() {
      if (pickedFile != null) {
        _setImageFileListFromFile(pickedFile);
        apiBack4app.saveImage(pickedFile);
      }
    });
  }
}