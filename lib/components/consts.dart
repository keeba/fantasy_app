import 'package:flutter/material.dart';

const Map teamColors = {
  'CSK': {
    'iconColor': Color(0xFFFFFF3C),
    'textColor': Colors.black,
  },
  'DD': {
    'iconColor': Color(0xFF00008B),
    'textColor': Colors.white,
  },
  'KXIP': {
    'iconColor': Color(0xFFED1B24),
    'textColor': Colors.white,
  },
  'KKR': {
    'iconColor': Color(0xFF2E0854),
    'textColor': Colors.white,
  },
  'MI': {
    'iconColor': Color(0xFF004BA0),
    'textColor': Colors.white,
  },
  'RR': {
    'iconColor': Color(0xFF254AA5),
    'textColor': Colors.white,
  },
  'RCB': {
    'iconColor': Color(0xFFEC1C24),
    'textColor': Colors.white,
  },
  'SRH': {
    'iconColor': Color(0xFFFF822A),
    'textColor': Colors.white,
  },
  'NONE': {
    'iconColor': Colors.white70,
    'textColor': Colors.white10,
  },
};

const Map playerIcons = {
  1: Image(
    image: AssetImage('images/bat.png'),
    width: 25.0,
    height: 25.0,
  ),
  2: Image(
    image: AssetImage('images/ball.png'),
    height: 15.0,
    width: 15.0,
  ),
  3: Image(
    image: AssetImage('images/batball.png'),
    height: 30.0,
    width: 30.0,
  ),
  4: Image(
    image: AssetImage('images/wicket.png'),
    height: 20.0,
    width: 20.0,
  ),
  5: Image(
    image: AssetImage('images/all.png'),
    height: 20.0,
    width: 20.0,
  ),
};

const Map playerTypeIcons = {
  'player1': Image(
    image: AssetImage('images/bat.png'),
    width: 25.0,
    height: 25.0,
  ),
  'player2': Image(
    image: AssetImage('images/bat.png'),
    width: 25.0,
    height: 25.0,
  ),
  'player3': Image(
    image: AssetImage('images/bat.png'),
    width: 25.0,
    height: 25.0,
  ),
  'player4': Image(
    image: AssetImage('images/batball.png'),
    height: 30.0,
    width: 30.0,
  ),
  'player5': Image(
    image: AssetImage('images/batball.png'),
    height: 30.0,
    width: 30.0,
  ),
  'player6': Image(
    image: AssetImage('images/wicket.png'),
    height: 25.0,
    width: 25.0,
  ),
  'player7': Image(
    image: AssetImage('images/ball.png'),
    height: 15.0,
    width: 15.0,
  ),
  'player8': Image(
    image: AssetImage('images/ball.png'),
    height: 15.0,
    width: 15.0,
  ),
  'player9': Image(
    image: AssetImage('images/ball.png'),
    height: 15.0,
    width: 15.0,
  ),
  'player10': Image(
    image: AssetImage('images/all.png'),
    height: 20.0,
    width: 20.0,
  ),
  'player11': Image(
    image: AssetImage('images/all.png'),
    height: 20.0,
    width: 20.0,
  ),
};

const CustomTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  fillColor: Colors.yellow,
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.limeAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.limeAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
