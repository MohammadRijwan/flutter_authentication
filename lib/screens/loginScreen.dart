import 'package:flutter_authentications/config/constant.dart';
import 'package:flutter_authentications/services/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'screens.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = 'login';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: kColorDeepGray,
      appBar: AppBar(
        backgroundColor: kColorDeepGray,
        iconTheme: IconThemeData(color: kColorDeepOrange),
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 300.0,
                width: double.infinity,
                child: SvgPicture.asset(kLoginImage),
              ),
              Text(
                'Login',
                style: kTitle,
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Login to discover amazing things',
                style: kSubTitle,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 0.0),
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                      //border: InputBorder.none,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: kTextFiledColor,
                      filled: true,
                      hintText: 'Email Address'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    } else if (!HelperService().isValidEmail(value)) {
                      return 'Please enter correct format of email';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 30.0),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      //border: InputBorder.none,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: kTextFiledColor,
                      filled: true,
                      hintText: 'Password'),
                  // Validation
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your Password';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 0.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 50.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: kColorDeepOrange),
                    onPressed: () async {
                      try {
                        UserCredential userCredential =
                            await auth.signInWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text,
                        );

                        Navigator.pushNamed(
                          context,
                          LoginSuccessScreen.routeName,
                          arguments: LoginScreenArguments(
                            loginMethod: 'Login by Email and Password',
                          ),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Login Success'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          print('No user found for that email.');
                        } else if (e.code == 'wrong-password') {
                          print('Wrong password provided for that user.');
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Text(
                      'Login',
                      style: kButtonText,
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
