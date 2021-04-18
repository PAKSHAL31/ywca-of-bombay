import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'login_otp.dart';
import 'register.dart';
import '../../widgets/constants.dart';

void main() => runApp(LoginScreen());

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // TextEditingController _controller = TextEditingController();
  String phoneNumber;
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); // form key for validation

  final GlobalKey<ScaffoldState> _scaffoldkey =
      GlobalKey<ScaffoldState>(); // scaffold key for snackbar

  _showNumberNotRegisteredSnackBar() {
    final registerSnackBar = SnackBar(
      content: Text('Phone number not registered!'),
      backgroundColor: Colors.red,
      // TODO: Add action to snackbar
      action: SnackBarAction(
        label: 'Register',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );

    _scaffoldkey.currentState.showSnackBar(registerSnackBar);
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldkey,
      body: SingleChildScrollView(
        child: Container(
          // margin: EdgeInsets.all(16),
          // height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Stack(
                // circle design
                children: <Widget>[
                  Positioned(
                    child: Image.asset("assets/images/circle-design.png"),
                  ),
                  Positioned(
                    child: Center(
                      child: Padding(
                        // padding: EdgeInsets.only(top: 100),
                        padding: EdgeInsets.only(top: _height * 0.15),
                        child: Text(
                          'LOG IN',
                          style: TextStyle(
                            fontSize: 35,
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'RacingSansOne',
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: _height * 0.1,
              ),
              Text(
                'Welcome Back !',
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: _height * 0.06,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Center(
                  child: Text(
                    'We are happy to see you again. You can continue where you left off by logging in.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xff7C82A1),
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: _height * 0.06,
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: _height * 0.01,
                  right: _height * 0.02,
                  bottom: _height * 0.02,
                  left: _height * 0.02,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        // controller: _controller,
                        onChanged: (value) {
                          setState(() {
                            phoneNumber = value;
                          });
                        },
                        validator: (String value) {
                          if (value.isEmpty)
                            return 'Mobile number is required';
                          else if (!RegExp(r"^\d{10}$").hasMatch(value))
                            return 'Please enter a valid mobile number';
                          else
                            return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.phone_android,
                            color: secondaryColor,
                          ),
                          prefixText: '+91 | ',
                          labelText: 'Mobile Number',
                          filled: true,
                          fillColor: formFieldFillColor,
                          disabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                        ),
                      ),
                      SizedBox(
                        height: _height * 0.1,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                firstButtonGradientColor,
                                firstButtonGradientColor,
                                secondButtonGradientColor
                              ],
                              begin: FractionalOffset.centerLeft,
                              end: FractionalOffset.centerRight,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: FlatButton(
                          onPressed: () async {
                            if (!_formKey.currentState.validate()) {
                              return;
                            }
                            var checkuser = await FirebaseFirestore.instance
                                .collection('users')
                                .where("phoneNumber", isEqualTo: phoneNumber)
                                .get();
                            if (checkuser.docs.length == 1) {
                              print("User found");
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      LoginOtp(phoneNumber: phoneNumber),
                                ),
                              );
                            } else {
                              FocusScope.of(context).unfocus();
                              print("No user found");
                              _showNumberNotRegisteredSnackBar();
                            }
                          },
                          child: Center(
                            child: Text(
                              'Log In',
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Montserrat',
                                color: Colors.white,
                              ),
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 0.0,
                            vertical: _height * 0.035,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text("Don't have an account? ",
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Montserrat',
                        )),
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterScreen()));
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: _height * 0.02,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
