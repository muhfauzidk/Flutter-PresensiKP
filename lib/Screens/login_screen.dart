import 'package:absensi/Controller/login_controller.dart';
import 'package:absensi/Controller/user_service.dart';
import 'package:absensi/Screens/forgot_password_view.dart';
import 'package:absensi/Screens/formregist_screen.dart';
import 'package:absensi/Screens/main_screen.dart';
import 'package:absensi/Screens/signup_screen.dart';
import 'package:absensi/common/common.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = "/login_screen";
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final controller = Get.put<LoginController>(LoginController());

  // string for displaying the error Message
  String? errorMessage;

  // our form key
  final _formKey = GlobalKey<FormState>();

  //firebase
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    //email field
    final emailField = TextFormField(
        autofocus: false,
        controller: controller.emailC,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Masukkan Email");
          }
          // reg expression for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Masukkan Email yang valid");
          }
          return null;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          labelText: "Email",
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //password field
    final passwordField = TextFormField(
        autofocus: false,
        controller: controller.passC,
        obscureText: true,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Masukkan Password");
          }
          if (!regex.hasMatch(value)) {
            return ("Masukkan Password yang valid");
          }
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //login button
    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.green,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            controller.login();
          },
          child: Text(
            "Masuk",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );

    final signUpButton =
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Material(
        child: InkWell(
          child: Text(
            "Belum punya akun?",
            style: semiGreyFont.copyWith(
              fontSize: 15,
              color: darkColor,
            ),
          ),
        ),
      ),
      SizedBox(
        width: 5,
      ),
      Material(
        child: InkWell(
          splashColor: Colors.black.withOpacity(0.3),
          child: Text(
            "Daftar",
            style: semiGreyFont.copyWith(
              fontSize: 15,
              color: primaryColor,
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignUpScreen()),
            );
          },
        ),
      ),
    ]);

    final resetPasswordButton =
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Material(
        child: InkWell(
          splashColor: Colors.black.withOpacity(0.3),
          child: Text(
            "Lupa Password",
            style: semiGreyFont.copyWith(
              fontSize: 15,
              color: maroonColor,
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
            );
          },
        ),
      ),
    ]);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Masuk",
                      style: TextStyle(
                        fontSize: 44.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 44),
                    emailField,
                    SizedBox(height: 20),
                    passwordField,
                    SizedBox(height: 44),
                    loginButton,
                    SizedBox(height: 30),
                    signUpButton,
                    SizedBox(height: 15),
                    resetPasswordButton,
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // login function
  void login(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
                  Fluttertoast.showToast(msg: "Login Successful"),
                  if (getUserData() == null)
                    {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => formRegister()),
                      )
                    }
                  else
                    {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => MainScreen())),
                    }
                });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "loging in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }
}
