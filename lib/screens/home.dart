import 'package:fantasy_app/providers/data.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../components/reusable_card.dart';
import '../components/wrapper_widget.dart';
import '../providers/user.dart';
import 'package:fantasy_app/components/dialogs.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserRepository>(context);
    final data = Provider.of<DataRepository>(context);
    return WillPopScope(
      onWillPop: () async {
        bool leavePage = true;
        if (user.status == UserStatus.Authenticated) {
          bool returnVal = await showConfirmAlert(context);
          if (returnVal == true) {
            user.signOut();
          } else {
            leavePage = false;
          }
        }
        if (leavePage) {
          Navigator.pushNamed(context, 'loginscreen');
        }
        return Future.value(false);
      },
      child: WrapperWidget(
        pageWidget: data.status == DataStatus.Loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: SizedBox.shrink(),
                    ),
                    Expanded(
                      flex: 5,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: ReusableCard(
                              title: 'My Team',
                              onPress: () async {
                                Navigator.pushNamed(context, 'teamscreen');
                                if (data.userEmail != user.user.email) {
                                  data.userEmail = user.user.email;
                                  await data.getUserData();
                                }
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
                      child: SizedBox.shrink(),
                    ),
                    Expanded(
                      flex: 5,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: ReusableCard(
                              title: 'Live Points',
                              onPress: () {
                                data.updatePointsPage(data.prevMatch);
                                Navigator.pushNamed(context, 'pointsscreen');
                              },
                              fontIcon: Icons.live_tv,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: ReusableCard(
                              title: 'Leader Board',
                              onPress: () {
                                data.setRankingsStream('Overall');
                                Navigator.pushNamed(context, 'boardscreen');
                              },
                              fontIcon: FontAwesomeIcons.trophy,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Center(
                          child: RaisedButton(
                            color: Color(0XFFB22222),
                            onPressed: () {
                              user.signOut();
                              Navigator.pushNamed(context, 'loginscreen');
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
      ),
    );
  }
}
