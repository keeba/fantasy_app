import 'package:fantasy_app/components/wrapper_widget.dart';
import 'package:fantasy_app/providers/data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LeaderBoardPage extends StatefulWidget {
  @override
  _LeaderBoardPageState createState() => _LeaderBoardPageState();
}

class _LeaderBoardPageState extends State<LeaderBoardPage> {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<DataRepository>(context);
    String dropdownValue = 'Overall';
    if (data.phaseStarted == false && data.totalTransfers == 80) {
      return WrapperWidget(
        pageWidget: Center(
          child: Text(
            'IPL not started yet.',
            style: GoogleFonts.robotoSlab(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: Colors.amberAccent,
            ),
          ),
        ),
      );
    } else {
      return WillPopScope(
        onWillPop: () async {
          Navigator.pushNamed(context, 'homescreen');
          return Future.value(false);
        },
        child: WrapperWidget(
          pageWidget: Container(
            margin: EdgeInsets.only(top: 10.0, left: 2.0, right: 2.0),
            child: Column(
              children: <Widget>[
                DropdownButton<String>(
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
                  onChanged: (String newValue) async {
                    if (newValue != 'Overall' &&
                        data.selectedMatch != newValue) {
                      data.selectedMatch = newValue;
                    }
                    dropdownValue = newValue;
                    data.setRankingsStream(newValue);
                  },
                  items: data.matches.map<DropdownMenuItem<String>>(
                    (match) {
                      if (match['name'] == data.currentMatch) {
                        return DropdownMenuItem<String>(
                          value: 'Overall',
                          child: Text('Overall Rankings'),
                        );
                      } else {
                        return DropdownMenuItem<String>(
                          value: match['name'],
                          child: Text(match['name']),
                        );
                      }
                    },
                  ).toList(),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: StreamBuilder(
                      stream: data.rankingsStream,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData &&
                            snapshot.data.data.keys.length > 0) {
                          DocumentSnapshot rankingsDS = snapshot.data;
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: rankingsDS.data.keys.length + 1,
                            padding: const EdgeInsets.only(top: 5.0),
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return RankingsTitle();
                              } else {
                                String team = rankingsDS.data.keys.toList()[0];
                                int points = rankingsDS.data[team];
                                return RankingsCard(team, points, index);
                              }
                            },
                          );
                        } else {
                          return Center(
                            child: Text(
                              'Rankings yet to be updated.',
                              style: GoogleFonts.robotoSlab(fontSize: 20.0),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }
  }
}

class RankingsTitle extends StatelessWidget {
  const RankingsTitle({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15.0),
      padding: EdgeInsets.all(5),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Center(
              child: Text(
                'Team',
                style: GoogleFonts.robotoSlab(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white70,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                'Points',
                style: GoogleFonts.robotoSlab(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white70,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                'Rank',
                style: GoogleFonts.robotoSlab(
                  fontWeight: FontWeight.bold,
                  color: Colors.white70,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RankingsCard extends StatelessWidget {
  RankingsCard(this.team, this.points, this.rank);
  final String team;
  final int points;
  final int rank;
  final List<Color> lColors = [
    Colors.blue[200],
    Colors.lime[200],
    Colors.red[200],
    Colors.orange[200],
    Colors.yellow[200],
    Colors.cyan[200],
    Colors.green[200],
    Colors.teal[200],
    Colors.amber[200],
    Colors.pink[200],
  ];

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<DataRepository>(context);
    return Container(
      height: 40.0,
      margin: EdgeInsets.only(top: 2.5),
      decoration: BoxDecoration(
        color: lColors[rank % 10],
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: EdgeInsets.all(5),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: GestureDetector(
              onTap: () async {
                String email = await data.getUserEmail(team);
                if (email != null) {
                  data.userEmail = email;
                  await data.getUserData();
                  Navigator.pushNamed(context, 'teamscreen');
                }
              },
              child: data.status == DataStatus.Loading
                  ? Center(child: CircularProgressIndicator())
                  : Center(
                      child: Text(
                        team,
                        style: GoogleFonts.robotoSlab(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                points.toString(),
                style: GoogleFonts.robotoSlab(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                rank.toString(),
                style: GoogleFonts.robotoSlab(
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
