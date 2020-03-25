import 'package:fantasy_app/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:fantasy_app/components/wrapper_widget.dart';
import 'package:fantasy_app/components/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:fantasy_app/components/dialogs.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = new GlobalKey<FormState>();
  String _email;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserRepository>(context);
    return WrapperWidget(
      pageWidget: Container(
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
              Container(
                padding: EdgeInsets.all(10),
                child: RaisedButton(
                  color: Colors.amber[300],
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      await user.sendPasswordResetEmail(_email);
                      await showAlert(
                        context,
                        'Success',
                        'A password reset link has been sent to ' +
                            _email +
                            '.',
                        Colors.green,
                      );
                      Navigator.pushNamed(context, 'loginscreen');
                    }
                  },
                  child: Text(
                    'Submit',
                    style: GoogleFonts.robotoSlab(
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
