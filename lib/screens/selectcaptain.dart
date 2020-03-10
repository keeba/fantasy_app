import 'package:flutter/material.dart';
import '../components/wrapper_widget.dart';
import 'package:provider/provider.dart';
import '../providers/data.dart';
import '../components/player_card.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectCaptainPage extends StatefulWidget {
  @override
  _SelectCaptainPageState createState() => _SelectCaptainPageState();
}

class _SelectCaptainPageState extends State<SelectCaptainPage> {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<DataRepository>(context);
    return WrapperWidget(
      pageWidget: data.lSelectedPlayers.length == 0
          ? Center(
              child: Text(
                'No Players to select',
                style: GoogleFonts.robotoSlab(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : ListView.builder(
              shrinkWrap: true,
              itemCount: data.lSelectedPlayers.length,
              padding: const EdgeInsets.only(top: 5.0),
              itemBuilder: (context, index) {
                final player = data.lSelectedPlayers[index];
                return PlayerEdit(player);
              },
            ),
    );
  }
}
