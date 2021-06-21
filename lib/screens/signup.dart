import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:v2/controllers/signup_controller.dart';
import 'package:v2/screens/home.dart';
import 'package:v2/screens/school_home.dart';

class SignUp extends StatefulWidget {
  SignUp({Key key, @required this.initilaPage}) : super(key: key);
  final initilaPage;
  _SignUp createState() => _SignUp();
}

class _SignUp extends State<SignUp> {
  final _formState = GlobalKey<FormState>();
  String fullName, phone, email, locationAddress, password, schoolName;
  bool _passwordVisible = true;
  final _signupController = Get.put(SignUpController());
  final PageStorageBucket _bucket = PageStorageBucket();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: _pageViewer(),
        ),
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
        PageStorage(bucket: _bucket, child: _userSignUp()),
        PageStorage(bucket: _bucket, child: _schoolSignUp()),
        PageStorage(bucket: _bucket, child: _wardSignUp())
      ],
    );
  }

  Widget _userSignUp() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: _userSignUpForm(),
        ),
      ],
    );
  }

  Widget _schoolSignUp() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: _schoolSignUpForm(),
        ),
      ],
    );
  }

  Widget _wardSignUp() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: _wardSignUpForm(),
        ),
      ],
    );
  }

  Widget _userSignUpForm() {
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
                'User Sign Up',
                style: Theme.of(context).textTheme.headline6,
              )),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8.0, 10, 8.0),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                keyboardAppearance: Brightness.dark,
                validator: (value) {
                  if (value.isBlank) {
                    return 'Please enter full name';
                  } else if (value.split(RegExp('([A-Za-z+]*)')).length != 3) {
                    return 'Please enter First Name and Last name';
                  } else {
                    fullName = value;
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: 'Enter First & Last Name',
                    labelText: 'First & Last Name',
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
                    hintText: 'Enter email',
                    labelText: 'Email',
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
                keyboardType: TextInputType.phone,
                keyboardAppearance: Brightness.dark,
                validator: (value) {
                  if (value.isBlank) {
                    return 'Please enter phone number';
                  } else {
                    email = value;
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: 'Enter phone number',
                    labelText: 'Phone Number',
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
                keyboardType: TextInputType.streetAddress,
                keyboardAppearance: Brightness.dark,
                validator: (value) {
                  if (value.isBlank) {
                    return 'Please enter your location address';
                  } else {
                    email = value;
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: 'Enter your location address',
                    labelText: 'Adddress',
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
                onChanged: (value) => password = value,
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
              child: TextFormField(
                obscureText: _passwordVisible,
                keyboardType: TextInputType.visiblePassword,
                keyboardAppearance: Brightness.dark,
                validator: (value) {
                  if (value.isBlank) {
                    return 'Please confirm password';
                  } else if (value != password) {
                    return 'Pasword doesn\'t match';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: 'Confirm Password',
                    labelText: 'Confirm Password',
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
                    if (_signupController.isSuccess.value) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    }
                    if (_signupController.successRequest.value) {
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        var snackBar = SnackBar(
                            content: Text(
                                '${_signupController.signUpResponse.value}'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      });
                      // _signupController.clearValues();
                    }

                    return ElevatedButton(
                      onPressed: () {
                        _userSignupButton();
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

  Widget _schoolSignUpForm() {
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
                'School Sign Up',
                style: Theme.of(context).textTheme.headline6,
              )),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8.0, 10, 8.0),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                keyboardAppearance: Brightness.dark,
                validator: (value) {
                  if (value.isBlank) {
                    return 'Please enter School name';
                  } else {
                    fullName = value;
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: 'Enter School Name',
                    labelText: 'School Name',
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
                    hintText: 'Enter email',
                    labelText: 'Email',
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
                keyboardType: TextInputType.phone,
                keyboardAppearance: Brightness.dark,
                validator: (value) {
                  if (value.isBlank) {
                    return 'Please enter phone number';
                  } else {
                    email = value;
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: 'Enter phone number',
                    labelText: 'Phone Number',
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
                keyboardType: TextInputType.streetAddress,
                keyboardAppearance: Brightness.dark,
                validator: (value) {
                  if (value.isBlank) {
                    return 'Please enter school location address';
                  } else {
                    email = value;
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: 'Enter school location address',
                    labelText: 'Adddress',
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
              child: TextFormField(
                obscureText: _passwordVisible,
                keyboardType: TextInputType.visiblePassword,
                keyboardAppearance: Brightness.dark,
                validator: (value) {
                  if (value.isBlank) {
                    return 'Please confirm password';
                  } else if (value == password) {
                    return 'Pasword doesn\'t match';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: 'Confirm Password',
                    labelText: 'Confirm Password',
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
                    if (_signupController.successRequest.value) {
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        var snackBar = SnackBar(
                            content: Text(
                                '${_signupController.signUpResponse.value}'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      });
                      if (_signupController.isSuccess.value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SchoolHome()));
                      }
                    }
                    return ElevatedButton(
                      onPressed: () {
                        _schoolSignupButton();
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

  Widget _wardSignUpForm() {
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
                'Ward Sign Up',
                style: Theme.of(context).textTheme.headline6,
              )),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8.0, 10, 8.0),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                keyboardAppearance: Brightness.dark,
                validator: (value) {
                  if (value.isBlank) {
                    return 'Please enter School name';
                  } else {
                    fullName = value;
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: 'Enter Ward Name',
                    labelText: 'Ward Name',
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
                    hintText: 'Enter email',
                    labelText: 'Email',
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
                keyboardType: TextInputType.phone,
                keyboardAppearance: Brightness.dark,
                validator: (value) {
                  if (value.isBlank) {
                    return 'Please enter phone number';
                  } else {
                    email = value;
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: 'Enter phone number',
                    labelText: 'Phone Number',
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
                keyboardType: TextInputType.streetAddress,
                keyboardAppearance: Brightness.dark,
                validator: (value) {
                  if (value.isBlank) {
                    return 'Please enter ward location address';
                  } else {
                    email = value;
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: 'Enter ward location address',
                    labelText: 'Adddress',
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
              child: TextFormField(
                obscureText: _passwordVisible,
                keyboardType: TextInputType.visiblePassword,
                keyboardAppearance: Brightness.dark,
                validator: (value) {
                  if (value.isBlank) {
                    return 'Please confirm password';
                  } else if (value == password) {
                    return 'Pasword doesn\'t match';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: 'Confirm Password',
                    labelText: 'Confirm Password',
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
                    if (_signupController.successRequest.value) {
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        var snackBar = SnackBar(
                            content: Text(
                                '${_signupController.signUpResponse.value}'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      });
                      if (_signupController.isSuccess.value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SchoolHome()));
                      }
                    }
                    return ElevatedButton(
                      onPressed: () {
                        _schoolSignupButton();
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

  void _userSignupButton() {
    if (_formState.currentState.validate()) {
      _signupController.signUp(
          fullName, email, phone, password, locationAddress, "1");
    }
  }

  void _schoolSignupButton() {
    if (_formState.currentState.validate()) {
      _signupController.signUp(
          schoolName, email, phone, password, locationAddress, "2");
    } else {}
  }
}
