import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({
    this.loginWithEmailAndPassword,
    this.verifyEmail,
    this.startSignUp,
  });

  final void Function(
    String email,
    String password,
    void Function(FirebaseAuthException e) errorCallback,
  ) loginWithEmailAndPassword;

  final Future<bool> Function(String email, void Function(Exception e) error)
      verifyEmail;

  final void Function() startSignUp;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.all(16),
        color: Colors.white,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome,",
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 30,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                "Sign in to continue!",
                style: TextStyle(
                  color: Colors.black45,
                  fontSize: 20,
                ),
              ),
              Expanded(
                child: SignInForm(
                  loginWithEmailAndPassword: loginWithEmailAndPassword,
                  verifyEmail: verifyEmail,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "New User?",
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: 15,
                    ),
                  ),
                  TextButton(
                      style: ButtonStyle(
                          overlayColor:
                              MaterialStateProperty.all(Colors.orange.shade400),
                          padding:
                              MaterialStateProperty.all(EdgeInsets.all(0))),
                      onPressed: () {
                        startSignUp();
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 15,
                        ),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SignInForm extends StatefulWidget {
  const SignInForm({Key key, this.loginWithEmailAndPassword, this.verifyEmail})
      : super(key: key);

  final void Function(
    String email,
    String password,
    void Function(Exception e) errorCallback,
  ) loginWithEmailAndPassword;

  final Future<bool> Function(String email, void Function(Exception e) error)
      verifyEmail;

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final GlobalKey<FormState> _signInFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  InputDecoration _fieldDecoration({String label}) {
    Color color = Colors.orange.shade400;
    return InputDecoration(
        labelStyle: TextStyle(color: Colors.black87, fontSize: 20),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: color, width: 2)),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: label,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 2)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 2)));
  }

  Widget _formButton(
      {String text,
      Color color = Colors.black87,
      Function onPressed,
      Color backColor}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: OutlinedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(backColor),
          overlayColor: MaterialStateProperty.all(Colors.orange.shade400),
        ),
        onPressed: onPressed,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              text,
              style: TextStyle(fontSize: 15, color: color),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _signInFormKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _emailController,
              cursorColor: Colors.orange.shade400,
              decoration: _fieldDecoration(label: "Email"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _passwordController,
              obscureText: true,
              cursorColor: Colors.orange.shade400,
              decoration: _fieldDecoration(label: "Password"),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
                style: ButtonStyle(
                  overlayColor:
                      MaterialStateProperty.all(Colors.orange.shade400),
                ),
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(color: Colors.black87),
                ),
                onPressed: () {}),
          ),
          _formButton(
              text: "Login",
              onPressed: () {
                widget.loginWithEmailAndPassword(
                    _emailController.text, _passwordController.text, (e) {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text((e as dynamic).message)));
                });
              },
              backColor: Colors.deepOrange.shade400),
          _formButton(
              text: "Connect With Google",
              onPressed: () {},
              color: Colors.red,
              backColor: Colors.grey.shade200),
        ],
      ),
    );
  }
}
