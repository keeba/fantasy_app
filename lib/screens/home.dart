import 'package:fantasy_app/providers/data.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../components/reusable_card.dart';
import '../components/wrapper_widget.dart';
import '../providers/user.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserRepository>(context);
    return Consumer<DataRepository>(
      builder: (context, data, widget) {
        return WrapperWidget(
          pageWidget: data.status == DataStatus.Loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  margin:
                      EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(),
                      ),
                      Expanded(
                        flex: 7,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: ReusableCard(
                                title: 'My Team',
                                onPress: () {
                                  Navigator.pushNamed(context, 'teamscreen');
                                },
                                fontIcon: FontAwesomeIcons.user,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: ReusableCard(
                                title: 'Rules',
                                onPress: () {
                                  Navigator.pushNamed(context, 'rulesscreen');
                                },
                                fontIcon: FontAwesomeIcons.gavel,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(),
                      ),
                      Expanded(
                        flex: 7,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: ReusableCard(
                                title: 'Live Score',
                                onPress: () {
                                  print('live score');
                                },
                                fontIcon: Icons.live_tv,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: ReusableCard(
                                title: 'Leader Board',
                                onPress: () {
                                  print('Leader Board');
                                },
                                fontIcon: FontAwesomeIcons.trophy,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Center(
                            child: RaisedButton(
                              onPressed: () {
                                user.signOut();
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Log Out',
                                style: GoogleFonts.robotoSlab(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25.0,
                                  color: Color(0xfff5f5f5),
                                ),
                              ),
                            ),
                          ),
                          width: double.infinity,
                        ),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
