import 'package:fantasy_app/components/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:fantasy_app/components/wrapper_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fantasy_app/components/widgets.dart';
import 'package:provider/provider.dart';
import 'package:fantasy_app/providers/user.dart';
import '../providers/data.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = new GlobalKey<FormState>();
  String _email;
  String _password;
  String _teamName;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserRepository>(context);
    final data = Provider.of<DataRepository>(context);
    return WrapperWidget(
      pageWidget: Container(
        margin: EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          autovalidate: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              MyTextFormField(
                hintText: 'Enter your email',
                onPressed: (input) => _email = input,
                onValidate: (value) =>
                    value.isEmpty ? 'Email can not be empty' : null,
                iconData: Icons.email,
              ),
              SizedBox(
                height: 5.0,
              ),
              MyTextFormField(
                hintText: 'Enter your password',
                onPressed: (input) => _password = input,
                onValidate: (value) =>
                    value.isEmpty ? 'Password can not be empty' : null,
                iconData: FontAwesomeIcons.key,
                obscure: true,
              ),
              SizedBox(
                height: 5.0,
              ),
              MyTextFormField(
                hintText: 'Enter your team name',
                onPressed: (input) => _teamName = input,
                onValidate: (value) =>
                    value.isEmpty ? 'Tean Name can not be empty' : null,
                iconData: FontAwesomeIcons.users,
              ),
              SizedBox(
                height: 5.0,
              ),
              user.status == UserStatus.Registering ||
                      user.status == UserStatus.Authenticated
                  ? Center(child: CircularProgressIndicator())
                  : Container(
                      padding: EdgeInsets.all(10),
                      child: RaisedButton(
                        color: Colors.amber,
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            bool userRegistered = await user.register(
                                _email, _password, _teamName);
                            if (userRegistered) {
                              data.userEmail = user.user.email;
                              data.getData();
                              Navigator.pushNamed(context, 'homescreen');
                            } else {
                              showAlert(
                                context,
                                'Error',
                                user.errorMessage,
                                Colors.red,
                              );
                            }
                          }
                        },
                        child: Text(
                          'Register',
                          style: GoogleFonts.robotoSlab(
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                            color: Colors.black87,
                          ),
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
