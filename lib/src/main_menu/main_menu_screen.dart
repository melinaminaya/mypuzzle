// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../audio/audio_controller.dart';
import '../audio/sounds.dart';
import '../games_services/games_services.dart';
import '../settings/settings.dart';
import '../style/palette.dart';
import '../style/responsive_screen.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();
    final gamesServicesController = context.watch<GamesServicesController?>();
    final settingsController = context.watch<SettingsController>();
    final audioController = context.watch<AudioController>();

    return Scaffold(
      //backgroundColor: palette.backgroundMain,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
               stops: [
                0.1,
                0.4,
                0.6,
                0.9,
              ],
              colors: [
<<<<<<< HEAD
                Color.fromARGB(255, 133, 132, 132),
                Color.fromARGB(255, 83, 82, 82),
                Color.fromARGB(255, 56, 56, 56),
                Color.fromARGB(255, 17, 17, 17),
              ],

            ),
            image: DecorationImage(
              image: AssetImage("assets/images/pngegg.png"),
              fit: BoxFit.cover,
              opacity: 0.8
              
            ),
=======
                Color.fromARGB(255, 255, 187, 0),
                Colors.red,
                Colors.indigo,
                Colors.teal,
              ],

            )
>>>>>>> 50f4ea7 (First commit of puzzle main and screens)
          ),
          child: ResponsiveScreen(
            mainAreaProminence: 0.45,
            squarishMainArea: Center(
<<<<<<< HEAD
              child: Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top:50.0),
                      child: Transform.rotate(
                        angle: -0.1,
                        child: const Text(
                          'My Puzzle',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Permanent Marker',
                            fontSize: 55,
                            height: 1,
                            color: Color.fromARGB(255, 233, 243, 252)
                          ),
                        ),
                      ),
                    ),
                    Spacer()
                  ],
                ),
                
              ),
            ),

=======
              child: Transform.rotate(
                angle: -0.1,
                child: const Text(
                  'My Puzzle',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Permanent Marker',
                    fontSize: 55,
                    height: 1,
                  ),
                ),
              ),
            ),
>>>>>>> 50f4ea7 (First commit of puzzle main and screens)
            rectangularMenuArea: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    audioController.playSfx(SfxType.buttonTap);
                    GoRouter.of(context).go('/play');
                  },
                  child: const Text('Play'),
                  style: ElevatedButton.styleFrom(elevation: 20, shadowColor: palette.darkPen ),
                ),
                _gap,
                if (gamesServicesController != null) ...[
                  _hideUntilReady(
                    ready: gamesServicesController.signedIn,
                    child: ElevatedButton(
                      onPressed: () => gamesServicesController.showAchievements(),
                      child: const Text('Achievements'),
                      
                    ),
                  ),
                  _gap,
                  _hideUntilReady(
                    ready: gamesServicesController.signedIn,
                    child: ElevatedButton(
                      onPressed: () => gamesServicesController.showLeaderboard(),
                      child: const Text('Leaderboard'),
                    ),
                  ),
                  _gap,
                ],
                ElevatedButton(
                  onPressed: () => GoRouter.of(context).go('/settings'),
                  child: const Text('Settings'),
                ),
                _gap,
                Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: ValueListenableBuilder<bool>(
                    valueListenable: settingsController.muted,
                    builder: (context, muted, child) {
                      return IconButton(
                        onPressed: () => settingsController.toggleMuted(),
                        icon: Icon(muted ? Icons.volume_off : Icons.volume_up),
                      );
                    },
                  ),
                ),
                _gap,
                const Text('Music by Mr Smith'),
                _gap,
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Prevents the game from showing game-services-related menu items
  /// until we're sure the player is signed in.
  ///
  /// This normally happens immediately after game start, so players will not
  /// see any flash. The exception is folks who decline to use Game Center
  /// or Google Play Game Services, or who haven't yet set it up.
  Widget _hideUntilReady({required Widget child, required Future<bool> ready}) {
    return FutureBuilder<bool>(
      future: ready,
      builder: (context, snapshot) {
        // Use Visibility here so that we have the space for the buttons
        // ready.
        return Visibility(
          visible: snapshot.data ?? false,
          maintainState: true,
          maintainSize: true,
          maintainAnimation: true,
          child: child,
        );
      },
    );
  }

  static const _gap = SizedBox(height: 10);
}
