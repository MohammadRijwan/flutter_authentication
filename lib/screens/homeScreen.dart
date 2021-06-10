import 'package:flutter_authentications/config/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_authentications/screens/screens.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_authentications/services/services.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // FireFlutter
  bool _initialized = false;
  bool _error = false;

  // FlutterFire Initialization
  void initializeFlutterFire() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_error) {
      print("FlutterFire Initialization error");
    }

    if (!_initialized) {
      // Loading Spinner
      return Scaffold(
        body: Center(
          child: SpinKitRotatingCircle(
            color: Colors.purple,
            size: 50.0,
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: kColorDeepGray,
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 300.0,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 0.0),
              child: SvgPicture.asset(kHomeImage),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            'Authentication',
            style: kTitle,
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            "We're not friends \n We're strangers with memories",
            style: kSubTitle,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 40.0,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0.0),
            child: SizedBox(
              width: double.infinity,
              height: 50.0,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: kColorDeepOrange),
                onPressed: () {
                  Navigator.pushNamed(context, LoginScreen.routeName);
                },
                child: Text(
                  'Login',
                  style: kButtonText,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 0.0),
            child: SizedBox(
              width: double.infinity,
              height: 50.0,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: kColorDeepOrange),
                onPressed: () {
                  Navigator.pushNamed(context, RegistrationScreen.routeName);
                },
                child: Text(
                  'Sign Up',
                  style: kButtonText,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '.................... ',
                style: TextStyle(
                  color: kColorLightGray,
                ),
              ),
              Text(
                'Or connect using',
                style: kSubTitle,
              ),
              Text(
                '.................... ',
                style: TextStyle(
                  color: kColorLightGray,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50.0, 20.0, 50.0, 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 36.0,
                  width: 36.0,
                  color: Colors.white,
                  child: TextButton(
                    child: Image.asset(
                      kGoogleIconImage,
                      height: 30.0,
                      width: 30.0,
                    ),
                    onPressed: () async {
                      try {
                        UserCredential userCredential =
                            await AuthenticationService().signInWithGoogle();
                        print('##########');
                        print(userCredential.user);

                        Navigator.pushNamed(
                            context, LoginSuccessScreen.routeName,
                            arguments: LoginScreenArguments(
                                loginMethod: 'Login by Google',
                                email: userCredential.user!.email,
                                displayName: userCredential.user!.displayName,
                                phoneNumber: userCredential.user!.phoneNumber,
                                photoURL: userCredential.user!.photoURL));
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          print('No user found');
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                  ),
                ),
                SignInButton(
                  Buttons.Facebook,
                  mini: true,
                  onPressed: () async {
                    try {
                      UserCredential userCredentialFacebook =
                          await AuthenticationService().signInWithFacebook();
                      print('++++++++');
                      print(userCredentialFacebook);

                      Navigator.pushNamed(context, LoginSuccessScreen.routeName,
                          arguments: LoginScreenArguments(
                            loginMethod: 'Login by Facebook',
                            email: userCredentialFacebook.user!.email,
                            displayName:
                                userCredentialFacebook.user!.displayName,
                            phoneNumber:
                                userCredentialFacebook.user!.phoneNumber,
                            photoURL: userCredentialFacebook.user!.photoURL,
                          ));
                    } catch (e) {
                      print(e);
                    }
                  },
                ),
                SignInButton(
                  Buttons.Apple,
                  mini: true,
                  onPressed: () async {
                    try {
                      UserCredential userCredentialApple =
                          await AuthenticationService().signInWithApple();
                      print('++++++++');
                      print(userCredentialApple);

                      Navigator.pushNamed(context, LoginSuccessScreen.routeName,
                          arguments: LoginScreenArguments(
                            loginMethod: 'Login by Apple',
                            email: userCredentialApple.user!.email,
                            displayName: userCredentialApple.user!.displayName,
                            phoneNumber: userCredentialApple.user!.phoneNumber,
                            photoURL: userCredentialApple.user!.photoURL,
                          ));
                    } catch (e) {
                      print(e);
                    }
                  },
                ),
                SignInButton(
                  Buttons.GitHub,
                  mini: true,
                  onPressed: () async {
                    try {
                      UserCredential userCredentialGithub =
                      await AuthenticationService().signInWithGitHub(context);
                      print('-----------');
                      print(userCredentialGithub);

                      Navigator.pushNamed(context, LoginSuccessScreen.routeName,
                          arguments: LoginScreenArguments(
                            loginMethod: 'Login by Github',
                            email: userCredentialGithub.user!.email,
                            displayName: userCredentialGithub.user!.displayName,
                            phoneNumber: userCredentialGithub.user!.phoneNumber,
                            photoURL: userCredentialGithub.user!.photoURL,
                          ));
                    } catch (e) {
                      print(e);
                    }
                  },
                ),
                Container(
                  height: 36.0,
                  width: 36.0,
                  color: Colors.white,
                  child: TextButton(
                    child: Image.asset(
                      kPhoneIconImage,
                      height: 30.0,
                      width: 30.0,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, PhoneVerifyScreen.routeName);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


