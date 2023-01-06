import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
//import 'package:provider/provider.dart';

class GalleryWidget extends StatefulWidget {

  final List urlImages;
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
   // var provider = NetworkImage(widget.urlImages[widget.index]);
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
          'Game On',
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
            child: 
            
            PhotoViewGallery.builder(
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
           // _Puzzle(
              
            //  key: Key('puzzle_view_puzzle'),
           // )
           ),
        ],
      ),
    );
  }
}

// class _Puzzle extends StatelessWidget {
//    const _Puzzle({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final theme = context.select((ThemeBloc bloc) => bloc.state.theme);
//     final state = context.select((PuzzleBloc bloc) => bloc.state);

//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return Stack(
//           children: [
//             if (theme is SimpleTheme)
//               theme.layoutDelegate.backgroundBuilder(state),
//             SingleChildScrollView(
//               child: ConstrainedBox(
//                 constraints: BoxConstraints(
//                   minHeight: constraints.maxHeight,
//                 ),
//                 child: Column(
//                   children: const [
//                     PuzzleHeader(),
//                     PuzzleSections(),
//                   ],
//                 ),
//               ),
//             ),
//             if (theme is! SimpleTheme)
//               theme.layoutDelegate.backgroundBuilder(state),
//           ],
//         );
//       },
//     );
//   }
// }

// /// {@template puzzle_header}
// /// Displays the header of the puzzle.
// /// {@endtemplate}
// @visibleForTesting
// class PuzzleHeader extends StatelessWidget {
  /// {@macro puzzle_header}
  // const PuzzleHeader({Key? key}) : super(key: key);

  // @override
  // Widget build(BuildContext context) {
  //   return SizedBox(
  //     height: 96,
  //     child: ResponsiveLayoutBuilder(
  //       small: (context, child) => Stack(
  //         children: [
  //           const Align(
  //             child: PuzzleLogo(),
  //           ),
  //           Align(
  //             alignment: Alignment.centerRight,
  //             child: Padding(
  //               padding: const EdgeInsets.only(right: 34),
  //               child: AudioControl(key: audioControlKey),
  //             ),
  //           ),
  //         ],
  //       ),
  //       medium: (context, child) => Padding(
  //         padding: const EdgeInsets.symmetric(
  //           horizontal: 50,
  //         ),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: const [
  //             PuzzleLogo(),
  //             PuzzleMenu(),
  //           ],
  //         ),
  //       ),
  //       large: (context, child) => Padding(
  //         padding: const EdgeInsets.symmetric(
  //           horizontal: 50,
  //         ),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: const [
  //             PuzzleLogo(),
  //             PuzzleMenu(),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
//}