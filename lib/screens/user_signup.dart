import 'package:flutter/material.dart';

class UserSignUp extends StatefulWidget {
  _UserSignUp createState() => _UserSignUp();
}

class _UserSignUp extends State<StatefulWidget> {
  bool _passwordVisible = false;
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
                    width: 50,
                    height: 50,
                  ),
                ),
                _userSignUpForm()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _userSignUpForm() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      padding: const EdgeInsets.all(8.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 1, color: Colors.grey[100])),
      child: Form(
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
                  TextButton(onPressed: () {}, child: Text('Sign up')),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Login'),
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.resolveWith<double>(
                            (states) => 0),
                        shape:
                            MaterialStateProperty.resolveWith<OutlinedBorder>(
                                (states) => RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)))),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
