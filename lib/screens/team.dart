import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../components/wrapper_widget.dart';
import '../components/player_card.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/data.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TeamPage extends StatefulWidget {
  TeamPage({this.edit: false});
  final bool edit;

  @override
  _TeamPageState createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  void initState() {
    super.initState();
    edit = widget.edit;
  }

  void showToast() {
    Fluttertoast.showToast(
        msg: 'Team Saved!',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white);
  }

  int dropdownValue;
  bool edit;
  String playerEdit;

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<DataRepository>(context);
    dropdownValue = data.currentMatchID;
    return WrapperWidget(
      pageWidget: data.status == DataStatus.Loading
          ? Center(child: CircularProgressIndicator())
          : Container(
              margin: EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        data.userData['team_name'],
                        style: GoogleFonts.robotoSlab(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.greenAccent,
                        ),
                      ),
                      Container(
                        child: Row(
                          children: <Widget>[
                            Text(
                              'Transfers: ',
                              style: GoogleFonts.robotoSlab(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.limeAccent,
                              ),
                            ),
                            data.configurations['phase_started']
                                ? Row(
                                    children: <Widget>[
                                      Text(
                                        data.userData['transfers_left']
                                            .toString(),
                                        style: GoogleFonts.robotoSlab(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        '/',
                                        style: GoogleFonts.robotoSlab(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.lime,
                                        ),
                                      ),
                                      Text(
                                        data.userData['transfers_total']
                                            .toString(),
                                        style: GoogleFonts.robotoSlab(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.limeAccent,
                                        ),
                                      ),
                                    ],
                                  )
                                : Text(
                                    'Unlimited',
                                    style: GoogleFonts.robotoSlab(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  edit
                      ? Container(
                          margin: EdgeInsets.only(top: 10.0),
                          child: Text(
                            data.currentMatch,
                            style: GoogleFonts.robotoSlab(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.amber[200],
                            ),
                          ),
                        )
                      : Container(
                          child: DropdownButton<int>(
                            value: dropdownValue,
                            icon: Icon(FontAwesomeIcons.arrowDown),
                            iconSize: 16,
                            elevation: 16,
                            style: TextStyle(
                              color: Colors.amber[200],
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            underline: Container(
                              height: 2,
                              color: Colors.amberAccent,
                            ),
                            onChanged: (int newValue) {
                              setState(() {
                                dropdownValue = newValue;
                              });
                            },
                            items: data.matches
                                .map<DropdownMenuItem<int>>((match) {
                              return DropdownMenuItem<int>(
                                value: match['id'],
                                child: Text(match['name']),
                              );
                            }).toList(),
                          ),
                        ),
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        PlayerShow(
                          playerType: 'player1',
                          edit: edit,
                        ),
                        PlayerShow(
                          playerType: 'player2',
                          edit: edit,
                        ),
                        PlayerShow(
                          playerType: 'player3',
                          edit: edit,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        PlayerShow(
                          playerType: 'player4',
                          edit: edit,
                        ),
                        PlayerShow(
                          playerType: 'player5',
                          edit: edit,
                        ),
                        PlayerShow(
                          playerType: 'player6',
                          edit: edit,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        PlayerShow(
                          playerType: 'player7',
                          edit: edit,
                        ),
                        PlayerShow(
                          playerType: 'player8',
                          edit: edit,
                        ),
                        PlayerShow(
                          playerType: 'player9',
                          edit: edit,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        PlayerShow(
                          playerType: 'player10',
                          edit: edit,
                        ),
                        PlayerShow(
                          playerType: 'player11',
                          edit: edit,
                        ),
                        Captain(
                          edit: edit,
                        ),
                      ],
                    ),
                  ),
                  edit
                      ? Container(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              RaisedButton(
                                color: Colors.redAccent[300],
                                onPressed: () async {
                                  await data.setPlayersList(data.currentMatch);
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Discard',
                                  style: GoogleFonts.robotoSlab(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              RaisedButton(
                                color: Colors.amber,
                                onPressed: () async {
                                  bool errors = data.checkTeamErrors();
                                  if (errors) {
                                    Alert(
                                      type: AlertType.error,
                                      context: context,
                                      title: 'Error',
                                      content: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            'All the 11 players and captain should be selected.',
                                            style: GoogleFonts.robotoSlab(
                                              fontSize: 15.0,
                                            ),
                                          ),
                                          Text(
                                            'Max 4 Oversears players allowed.',
                                            style: GoogleFonts.robotoSlab(
                                              fontSize: 15.0,
                                            ),
                                          ),
                                          Text(
                                            'Not more than 6 players from the same team allowed.',
                                            style: GoogleFonts.robotoSlab(
                                              fontSize: 15.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                      buttons: [
                                        DialogButton(
                                          child: Text(
                                            "OK",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          width: 120,
                                        )
                                      ],
                                    ).show();
                                  } else {
                                    await data.saveTeam().then((temp) {
                                      if (data.status == DataStatus.Saved) {
                                        showToast();
                                        Navigator.pop(context);
                                      } else if (data.status ==
                                          DataStatus.Failed) {
                                        Alert(
                                          type: AlertType.error,
                                          context: context,
                                          title: 'Error',
                                          content: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                'Failed to save the data.',
                                                style: GoogleFonts.robotoSlab(
                                                  fontSize: 15.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                          buttons: [
                                            DialogButton(
                                              child: Text(
                                                "OK",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20),
                                              ),
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              width: 120,
                                            )
                                          ],
                                        ).show();
                                      }
                                    });
                                  }
                                },
                                child: Text(
                                  'Save Changes',
                                  style: GoogleFonts.robotoSlab(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              RaisedButton(
                                color: Colors.lime,
                                onPressed: () {},
                                child: Text(
                                  'View Points',
                                  style: GoogleFonts.robotoSlab(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                              RaisedButton(
                                color: Colors.amber,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return TeamPage(
                                          edit: true,
                                        );
                                      },
                                    ),
                                  );
                                },
                                child: Text(
                                  'Change Team',
                                  style: GoogleFonts.robotoSlab(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            ),
    );
  }
}
