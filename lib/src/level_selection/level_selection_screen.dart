// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:game_template/services/api_service.dart';
import 'package:provider/provider.dart';

import '../play_session/appbar_widget.dart';
import '../play_session/gallery_widget.dart';
//import '../player_progress/player_progress.dart';
import '../style/palette.dart';

class LevelSelectionScreen extends StatefulWidget {
  const LevelSelectionScreen({super.key});


  @override
  State<LevelSelectionScreen> createState() => _LevelSelectionScreenState();
}

class _LevelSelectionScreenState extends State<LevelSelectionScreen> {
  ApiService apiService = ApiService();
   List urlImages = [];

  @override
  void initState() {
    super.initState();
    
    futureData();
    
  }

  void futureData() async{

    // final jsonAlbum = apiService.fetchAlbum();
    // log('jsonAlbum: $jsonAlbum');
    
    final result = await  apiService.fetchImagesToUrl();
    log('jsonAlbum: $result');
    setState(() {
        urlImages = result;
      
        
    });
    final responseApi = await apiService.fetchApiTest();
    log('jsonApi: $responseApi');
    
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();
   // final playerProgress = context.watch<PlayerProgress>();

    return Scaffold(
      backgroundColor: palette.backgroundLevelSelection,
      appBar: AppBarWidget(urlImages),
      body: 
      // ResponsiveScreen(
      //   squarishMainArea: 
        SafeArea(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Center(
                  child: Text(
                    'Select Puzzle',
                    style:
                        TextStyle(fontFamily: 'Permanent Marker', fontSize: 30),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              // Expanded(
              //   child: ListView(
              //     children: [
              //       for (final level in gameLevels)
              //         ListTile(
              //           enabled: playerProgress.highestLevelReached >=
              //               level.number - 1,
              //           onTap: () {
              //             final audioController = context.read<AudioController>();
              //             audioController.playSfx(SfxType.buttonTap);
              
              //             GoRouter.of(context)
              //                 .go('/play/session/${level.number}');
              //           },
              //           leading: Text(level.number.toString()),
              //           title: Text('Level #${level.number}'),
              //         ),
                      
              //     ],
                  
              //   ),
              // ),
              Expanded(
                child: GridView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    //crossAxisSpacing: 5,
                    // mainAxisSpacing: 5,
                    childAspectRatio: 3/4,
                  ),
                  itemBuilder: (context, index) {
                    return RawMaterialButton(
                      child: InkWell(
                        child: Ink.image(
                          image: NetworkImage(urlImages.elementAt(index).toString()),
                          height: 300,
                          fit: BoxFit.cover,
                        ),
                      ),
                      onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GalleryWidget(
                                      urlImages: urlImages,
                                      index: index,
                                    )));
                      },
                    );
                  },
                  itemCount: urlImages.length,   
                ),
              )
                  
            ],
            
          ),
        ),
        // rectangularMenuArea: ElevatedButton(
        //   onPressed: () {
        //     GoRouter.of(context).pop();
        //   },
        //   child: const Text('Back'),
        // ),
      );
  //  );
  }
}

