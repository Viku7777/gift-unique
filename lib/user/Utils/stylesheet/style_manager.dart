// ignore_for_file: non_constant_identifier_names

import 'package:color_game/user/Utils/stylesheet/colors.dart';
import 'package:color_game/user/Utils/stylesheet/icons.dart';
import 'package:color_game/user/Utils/stylesheet/images.dart';
import 'package:color_game/user/Utils/stylesheet/shape_manager.dart';
import 'package:color_game/user/Utils/stylesheet/spacing.dart';
import 'package:color_game/user/Utils/stylesheet/text_theme.dart';
import 'package:color_game/user/Utils/stylesheet/utility.dart';

class StyleManager {
  StyleManager._privateConstructor();

  static final StyleManager _instance = StyleManager._privateConstructor();

  factory StyleManager() {
    return _instance;
  }

  // Colors Instance
  SFColors get COLORS => SFColors();

  // Text Theme Instance
  SFTextThemeCondensed get TEXT_CONDENSED => SFTextThemeCondensed();

  // Text Theme Instance
  SFTextThemeRubik get TEXT_Rubik => SFTextThemeRubik();

  // Shape / Decoration Instance
  ShapeManager get SHAPES => ShapeManager();

  // Icons Instance
  SFIcons get ICONS => SFIcons();

  // Images Instance
  SFImages get IMAGES => SFImages();

  // Config Instance
  SFImages get CONFIGIMG => SFImages();

  // Utility Instance
  SFUtility get UTILS => SFUtility();

  // Spacing Instance
  SFSpacing get SPACING => SFSpacing();
}
