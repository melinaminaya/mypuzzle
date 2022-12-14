import '../src/level_selection/level_selection_screen.dart';
import 'package:get_it/get_it.dart';

class IoC {
  static register() {
    _registerPages();

  }

  static _registerPages(){
     GetIt.I.registerSingleton(LevelSelectionScreen());

  }

  static get() {}
}