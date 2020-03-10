import 'package:fantasy_app/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fantasy_app/components/wrapper_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:fantasy_app/components/widgets.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = new GlobalKey<FormState>();
  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserRepository>(context);
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
              user.status == UserStatus.Authenticating
                  ? Center(child: CircularProgressIndicator())
                  : Container(
                      padding: EdgeInsets.all(10),
                      child: RaisedButton(
                        color: Colors.lime,
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            await user.signIn(_email, _password).then(
                              (userSignedIn) {
                                if (userSignedIn) {
                                  Navigator.pushNamed(context, 'homescreen');
                                } else {
                                  setState(
                                    () {
                                      return Alert(
                                        type: AlertType.error,
                                        context: context,
                                        title: 'Error',
                                        desc: user.errorMessage,
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
                                    },
                                  );
                                }
                              },
                            );
                          }
                        },
                        child: Text(
                          'LogIn',
                          style: GoogleFonts.robotoSlab(
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
              Container(
                padding: EdgeInsets.all(10),
                child: RaisedButton(
                  color: Colors.amber,
                  onPressed: () {
                    Navigator.pushNamed(context, 'registerscreen');
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
