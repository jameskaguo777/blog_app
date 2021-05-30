import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:v2/controllers/signup_controller.dart';

class SignUp extends StatefulWidget {
  SignUp({Key key, @required this.initilaPage}) : super(key: key);
  final initilaPage;
  _SignUp createState() => _SignUp();
}

class _SignUp extends State<SignUp> {
  final _formState = GlobalKey<FormState>();
  String fullName, phone, email, locationAddress, password;
  bool _passwordVisible = false;
  final _signupController = Get.put(SignUpController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: SafeArea(
          child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: _pageViewer(),
      )),
    );
  }

  Widget _pageViewer() {
    return PageView(
      scrollDirection: Axis.horizontal,
      physics: NeverScrollableScrollPhysics(),
      controller:
          PageController(keepPage: true, initialPage: widget.initilaPage),
      children: <Widget>[
        _userSignUp(),
      ],
    );
  }

  Widget _userSignUp() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _signUpForm(),
      ],
    );
  }

  Widget _signUpForm() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Form(
        key: _formState,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Text(
                'Login',
                style: Theme.of(context).textTheme.headline6,
              )),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8.0, 10, 8.0),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                keyboardAppearance: Brightness.dark,
                validator: (value) {
                  if (value.contains(' ')) {
                    return 'Please enter full name';
                  } else if (value.isBlank) {
                    return 'Please enter full name not single name';
                  } else {
                    fullName = value;
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: 'Enter Full name',
                    labelText: 'Full Name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          style: BorderStyle.solid,
                        ))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8.0, 10, 8.0),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                keyboardAppearance: Brightness.dark,
                validator: (value) {
                  if (value.isBlank) {
                    return 'Please enter email address';
                  } else {
                    email = value;
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: 'Enter email or Username',
                    labelText: 'Email/Username',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          style: BorderStyle.solid,
                        ))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8.0, 10, 8.0),
              child: TextFormField(
                obscureText: _passwordVisible,
                keyboardType: TextInputType.visiblePassword,
                keyboardAppearance: Brightness.dark,
                validator: (value) {
                  if (value.isBlank) {
                    return 'Please enter password';
                  } else {
                    password = value;
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: 'Enter password',
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      icon: _passwordVisible
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility),
                      onPressed: () {
                        setState(() {
                          if (_passwordVisible) {
                            _passwordVisible = false;
                          } else {
                            _passwordVisible = true;
                          }
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          style: BorderStyle.solid,
                        ))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8.0, 10, 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(onPressed: () {}, child: Text('Login')),
                  Obx(() {
                    return ElevatedButton(
                      onPressed: () {
                        _signupButton();
                      },
                      child: _signupController.isLoading.value
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : Text('Sign up'),
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.resolveWith<double>(
                              (states) => 0),
                          shape:
                              MaterialStateProperty.resolveWith<OutlinedBorder>(
                                  (states) => RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20)))),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _signupButton() {
    if (_formState.currentState.validate()) {}
  }
}
