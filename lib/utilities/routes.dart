// We use name route
// All our routes will be available here

import 'package:flutter/material.dart';

import '../all_screens.dart';

final Map<String, WidgetBuilder> routes = {
  WelcomeScreen.routeName: (context) => WelcomeScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  ChatScreen.routeName: (context) => ChatScreen(),
  EmojiColorGame.routeName: (context) => EmojiColorGame(),
  EmojiRelatedEmojiGame.routeName: (context) => EmojiRelatedEmojiGame(),
  EmojiNameGame.routeName: (context) => EmojiNameGame(),
  ScratchLevelScreen.routeName: (context) => ScratchLevelScreen(),
  MoreScreen.routeName: (context) => MoreScreen(),
};
