import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';
import 'package:v2/apis.dart';
import 'package:v2/controllers/old_api_controller/authontication_controller.dart';
import 'package:v2/controllers/login_controller.dart';
import 'package:v2/screens/home.dart';
import 'package:v2/screens/school_home.dart';
import 'package:v2/screens/signup.dart';

class Login extends StatefulWidget {
  _Login createState() => _Login();
}

class _Login extends State<Login> with WidgetsBindingObserver {
  int _pagerIndex = 0;
  PageController _pageController =
      PageController(initialPage: 0, keepPage: false);
  bool _passwordVisible = false;
  final loginController = Get.put(AuthonticationController());
  final _userFormState = GlobalKey<FormState>();
  final _schoolFormState = GlobalKey<FormState>();
  final _wardFormState = GlobalKey<FormState>();
  String email, password;
  final PageStorageBucket _bucket = PageStorageBucket();

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.inactive:
        // loginController.clearValues();
        print('App in active');
        break;
      case AppLifecycleState.resumed:
        print(state.toString());
        break;
      case AppLifecycleState.detached:
        print(state.toString());
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/logo.png',
                    width: 150,
                    height: 150,
                  ),
                ),
                _swichingChips(),
                _loginFormPager()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _swichingChips() {
    return Container(
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width * .7,
          maxHeight: MediaQuery.of(context).size.width * .8,
        ),
        margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        padding: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(40),
            border: Border.all(width: 1, color: Colors.grey[100])),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          direction: Axis.horizontal,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: InkWell(
                child: Chip(
                    backgroundColor:
                        _pagerIndex == 0 ? Colors.amber : Colors.white,
                    avatar: Lottie.asset(
                      'assets/lottie/user.json',
                      width: 24,
                      animate: true,
                      repeat: true,
                      height: 21,
                    ),
                    label: Text(
                      'User',
                      style: Theme.of(context).textTheme.button.copyWith(
                          color:
                              _pagerIndex == 0 ? Colors.white : Colors.black),
                    )),
                onTap: () {
                  _pageController.animateToPage(0,
                      duration: Duration(milliseconds: 1000),
                      curve: Curves.easeIn);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: InkWell(
                child: Chip(
                  backgroundColor:
                      _pagerIndex == 1 ? Colors.amber : Colors.white,
                  avatar: Lottie.asset(
                    'assets/lottie/bag.json',
                    width: 24,
                    repeat: true,
                    animate: true,
                    height: 20,
                  ),
                  label: Text(
                    'School',
                    style: Theme.of(context).textTheme.button.copyWith(
                        color: _pagerIndex == 1 ? Colors.white : Colors.black),
                  ),
                ),
                onTap: () {
                  _pageController.animateToPage(1,
                      duration: Duration(milliseconds: 1000),
                      curve: Curves.easeOut);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: InkWell(
                child: Chip(
                  backgroundColor:
                      _pagerIndex == 2 ? Colors.amber : Colors.white,
                  avatar: Lottie.asset(
                    'assets/lottie/location.json',
                    width: 24,
                    repeat: true,
                    animate: true,
                    height: 20,
                  ),
                  label: Text(
                    'Ward',
                    style: Theme.of(context).textTheme.button.copyWith(
                        color: _pagerIndex == 2 ? Colors.white : Colors.black),
                  ),
                ),
                onTap: () {
                  _pageController.animateToPage(2,
                      duration: Duration(milliseconds: 1000),
                      curve: Curves.easeIn);
                },
              ),
            ),
          ],
        ));
  }

  Widget _loginFormPager() {
    return LimitedBox(
      maxHeight: MediaQuery.of(context).size.height * .5,
      child: PageView(
        scrollDirection: Axis.horizontal,
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            _pagerIndex = index;
          });
        },
        children: [
          PageStorage(
            child: _userLoginForm(),
            bucket: _bucket,
          ),
          PageStorage(bucket: _bucket, child: _schoolLoginForm()),
          PageStorage(bucket: _bucket, child: _wardLoginForm())
        ],
      ),
    );
  }

  Widget _userLoginForm() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      padding: const EdgeInsets.all(8.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 1, color: Colors.grey[100])),
      child: Form(
        key: _userFormState,
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
                  if (value.isBlank) {
                    return 'Please enter email address';
                  } else {
                    email = value;
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: 'Enter email or Username',
                    labelText: 'Email/Phone',
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
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUp(initilaPage: 0)));
                      },
                      child: Text('Sign up')),
                  Obx(() {
                    if (loginController.isLoading.value) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      );
                    }
                    if (loginController.success.value) {
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()));
                      });
                    } else {
                      if (loginController.success.value) {
                        WidgetsBinding.instance
                            .addPostFrameCallback((timeStamp) {
                          var snackBar = SnackBar(
                              content:
                                  Text('${loginController.message.value}'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          // loginController.clearValues();
                        });
                      }
                    }
                    return ElevatedButton(
                      onPressed: () {
                        _normalUserLogin();
                      },
                      child: Text('Login'),
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

  Widget _schoolLoginForm() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      padding: const EdgeInsets.all(8.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 1, color: Colors.grey[100])),
      child: Form(
        key: _schoolFormState,
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
                decoration: InputDecoration(
                    hintText: 'Enter email or School name',
                    labelText: 'Email/phone',
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
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUp(initilaPage: 1)));
                      },
                      child: Text('Sign up')),
                  Obx(() {
                    if (loginController.success.value) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SchoolHome()));
                    } else {
                      if (loginController.success.value) {
                        WidgetsBinding.instance
                            .addPostFrameCallback((timeStamp) {
                          var snackBar = SnackBar(
                              content:
                                  Text('${loginController.message.value}'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          // loginController.clearValues();
                        });
                      }
                    }
                    return ElevatedButton(
                      onPressed: () {
                        _normalUserLogin();
                      },
                      child: loginController.isLoading.value
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : Text('Login'),
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

  Widget _wardLoginForm() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      padding: const EdgeInsets.all(8.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 1, color: Colors.grey[100])),
      child: Form(
        key: _wardFormState,
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
                decoration: InputDecoration(
                    hintText: 'Enter email or ward name',
                    labelText: 'Email/phone',
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
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUp(initilaPage: 2)));
                      },
                      child: Text('Sign up')),
                  Obx(() {
                    if (loginController.success.value) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SchoolHome()));
                    } else {
                      if (loginController.success.value) {
                        WidgetsBinding.instance
                            .addPostFrameCallback((timeStamp) {
                          var snackBar = SnackBar(
                              content:
                                  Text('${loginController.success.value}'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          // loginController.clearValues();
                        });
                      }
                    }
                    return ElevatedButton(
                      onPressed: () {
                        _normalUserLogin();
                      },
                      child: loginController.isLoading.value
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : Text('Login'),
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

  // void _loginButton(String userType) {
  //   if (_userFormState.currentState.validate()) {
  //     loginController.signIn(email, password, userType);
  //   }
  // }

  void _normalUserLogin() {
    if (_userFormState.currentState.validate()) {
      loginController.signIn(
          email, password, 'ioa;93jfd49;3rawnfjkawjef43', USER_TYPE_VOTER);
    }
  }
}
