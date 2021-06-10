import 'package:flutter_authentications/config/constant.dart';
import 'package:flutter_authentications/screens/registrationSuccessScreen.dart';
import 'package:flutter_authentications/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistrationScreen extends StatefulWidget {
  static const routeName = 'registration';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
        elevation: 0,
        iconTheme: IconThemeData(color: kColorDeepOrange),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 300.0,
                width: double.infinity,
                child: SvgPicture.asset(kRegisterImage),
              ),
              Text(
                'Registration',
                style: kTitle
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                "Create Your Free Account",
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
                            await auth.createUserWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text,
                        );

                        Navigator.pushNamed(context, RegistrationSuccessScreen.routeName);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Registration Success'),
                            backgroundColor: Colors.green,
                          ),
                        );

                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          print('The password provided is too weak.');
                        } else if (e.code == 'email-already-in-use') {
                          print('The account already exists for that email.');
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Text(
                      'Sign Up',
                      style: kButtonText,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
