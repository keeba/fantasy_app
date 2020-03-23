import 'package:fantasy_app/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../components/wrapper_widget.dart';
import '../components/player_card.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/data.dart';
import 'package:fantasy_app/components/dialogs.dart';

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

  bool edit;

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<DataRepository>(context);
    final user = Provider.of<UserRepository>(context);
    return WillPopScope(
      onWillPop: () async {
        if (edit) {
          bool returnVal = await showConfirmAlert(context);
          if (returnVal == true) {
            await data.resetData(true);
            Navigator.pop(context);
          }
        } else if (data.userEmail != user.user.email) {
          data.setRankingsStream('Overall');
          Navigator.pushNamed(context, 'boardscreen');
        } else {
          Navigator.pushNamed(context, 'homescreen');
        }
        return Future.value(false);
      },
      child: OrientationBuilder(
        builder: (context, orientation) {
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
                            Column(
                              children: <Widget>[
                                Text(
                                  data.userData['team_name'],
                                  style: GoogleFonts.robotoSlab(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.greenAccent,
                                  ),
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
                                    : DropdownButton<String>(
                                        value: data.selectedMatch,
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
                                        onChanged: (String newValue) async {
                                          if (newValue != data.selectedMatch) {
                                            data.selectedMatch = newValue;
                                            await data.getPlayersList(newValue);
                                          }
                                        },
                                        items: data.matches
                                            .map<DropdownMenuItem<String>>(
                                          (match) {
                                            return DropdownMenuItem<String>(
                                              value: match['name'],
                                              child: Text(match['name']),
                                            );
                                          },
                                        ).toList(),
                                      ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Text(
                                  'Transfers',
                                  style: GoogleFonts.robotoSlab(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.lime,
                                  ),
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      'Left: ',
                                      style: GoogleFonts.robotoSlab(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.limeAccent,
                                      ),
                                    ),
                                    data.phaseStarted
                                        ? Wrap(
                                            children: <Widget>[
                                              Text(
                                                data.transfersLeft.toString() +
                                                    '/' +
                                                    data.totalTransfers
                                                        .toString(),
                                                style: GoogleFonts.robotoSlab(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Text(
                                                ' Pending: ',
                                                style: GoogleFonts.robotoSlab(
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.limeAccent,
                                                ),
                                              ),
                                              Text(
                                                data.pendingTransfers
                                                    .toString(),
                                                style: GoogleFonts.robotoSlab(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          )
                                        : Text(
                                            'Unlimited',
                                            style: GoogleFonts.robotoSlab(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                              ],
                            ),
                          ],
                        ),
                        orientation == Orientation.portrait
                            ? Expanded(
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
                              )
                            : Expanded(
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
                        orientation == Orientation.portrait
                            ? Expanded(
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
                              )
                            : Expanded(
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
                        orientation == Orientation.portrait
                            ? Expanded(
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
                              )
                            : SizedBox.shrink(),
                        orientation == Orientation.portrait
                            ? Expanded(
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
                              )
                            : SizedBox.shrink(),
                        edit
                            ? Container(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    RaisedButton(
                                      color: Colors.redAccent[300],
                                      onPressed: () async {
                                        bool returnVal =
                                            await showConfirmAlert(context);
                                        if (returnVal == true) {
                                          await data.resetData(true);
                                          Navigator.pop(context);
                                        }
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
                                        List<String> lErrors =
                                            data.checkTeamErrors();
                                        if (lErrors.length > 0) {
                                          showAlert(
                                            context,
                                            'Error',
                                            lErrors.join("\n"),
                                            Colors.red,
                                          );
                                        } else {
                                          await data.resetData(false);
                                          ConfirmAction returnVal =
                                              await showConfirmTransfersAlert(
                                                  context);
                                          if (returnVal ==
                                              ConfirmAction.ACCEPT) {
                                            await data.saveTeam();
                                            if (data.status ==
                                                DataStatus.Saved) {
                                              await showAlert(
                                                context,
                                                'Success',
                                                'Team Saved!',
                                                Colors.green,
                                              );
                                              Navigator.pushNamed(
                                                  context, 'teamscreen');
                                            } else if (data.status ==
                                                DataStatus.Failed) {
                                              showAlert(
                                                context,
                                                'Error',
                                                'Failed to save the data.',
                                                Colors.red,
                                              );
                                              Navigator.pop(context);
                                            }
                                          }
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
                                child: data.userEmail != user.user.email
                                    ? Center(
                                        child: RaisedButton(
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
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
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
                                            onPressed: () async {
                                              await data.resetData(true);
                                              if (data.status ==
                                                  DataStatus.Loaded) {
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
                                              } else if (data.status ==
                                                  DataStatus.Failed) {
                                                showAlert(
                                                  context,
                                                  'Error',
                                                  'Failed to load data!',
                                                  Colors.red,
                                                );
                                              }
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
        },
      ),
    );
  }
}
