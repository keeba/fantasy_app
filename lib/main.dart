import 'package:fantasy_app/providers/data.dart';
import 'package:fantasy_app/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home.dart';
import 'screens/login.dart';
import 'screens/team.dart';
import 'screens/selectplayer.dart';
import 'screens/rules.dart';
import 'package:fantasy_app/screens/register.dart';
import 'package:fantasy_app/screens/selectcaptain.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserRepository(),
        ),
        ChangeNotifierProxyProvider<UserRepository, DataRepository>(
          create: (_) => DataRepository(null),
          update: (context, user, data) => DataRepository(user.user.email),
        ),
      ],
      child: Consumer<UserRepository>(
        builder: (context, user, widget) {
          return MaterialApp(
            title: 'My Fantasy',
            theme: ThemeData(
              brightness: Brightness.dark,
              primaryColor: Colors.black,
              accentColor: Colors.redAccent,
              buttonColor: Color(0Xff8F0000),

              // Define the default font family.
              fontFamily: 'Georgia',

              // Define the default TextTheme. Use this to specify the default
              // text styling for headlines, titles, bodies of text, and more.
              textTheme: TextTheme(
                headline:
                    TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
                title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
                body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
              ),
            ),
            initialRoute: user.status == UserStatus.Authenticated
                ? 'homescreen '
                : 'loginscreen',
            routes: {
              'homescreen': (context) => MyHomePage(),
              'loginscreen': (context) => LoginPage(),
              'teamscreen': (context) => TeamPage(),
              'selectplayer': (context) => SelectPlayerPage(),
              'rulesscreen': (context) => RulesPage(),
              'registerscreen': (context) => RegisterPage(),
              'selectcaptain': (context) => SelectCaptainPage(),
            },
          );
        },
      ),
    );
  }
}
