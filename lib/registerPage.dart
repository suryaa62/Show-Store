import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({
    this.registerWithEmailAndPassword,
    this.verifyEmail,
    this.cancelRegistration,
  });

  final void Function(
    String email,
    String displayName,
    String password,
    void Function(Exception e) errorCallback,
  ) registerWithEmailAndPassword;

  final Future<bool> Function(String email, void Function(Exception e) error)
      verifyEmail;

  final void Function() cancelRegistration;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
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
                "Sign Up to continue!",
                style: TextStyle(
                  color: Colors.black45,
                  fontSize: 20,
                ),
              ),
              Expanded(
                child: SignUpForm(
                  registerWithEmailAndPassword: registerWithEmailAndPassword,
                  verifyEmail: verifyEmail,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already a User?",
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
                        cancelRegistration();
                      },
                      child: Text(
                        "Sign In",
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

class SignUpForm extends StatefulWidget {
  const SignUpForm(
      {Key key, this.registerWithEmailAndPassword, this.verifyEmail})
      : super(key: key);

  final void Function(
    String email,
    String displayName,
    String password,
    void Function(Exception e) errorCallback,
  ) registerWithEmailAndPassword;

  final Future<bool> Function(String email, void Function(Exception e) error)
      verifyEmail;

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final GlobalKey<FormState> _signUpFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
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
      key: _signUpFormKey,
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
              controller: _nameController,
              cursorColor: Colors.orange.shade400,
              decoration: _fieldDecoration(label: "Name"),
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
          _formButton(
              text: "Register",
              onPressed: () {
                widget.registerWithEmailAndPassword(_emailController.text,
                    _nameController.text, _passwordController.text, (e) {
                  print("=============>${e}");
                });
              },
              backColor: Colors.deepOrange.shade400)
        ],
      ),
    );
  }
}
