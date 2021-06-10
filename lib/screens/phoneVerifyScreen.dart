import 'dart:async';

import 'package:flutter_authentications/config/constant.dart';
import 'package:flutter_authentications/screens/screens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PhoneVerifyScreen extends StatefulWidget {
  static const routeName = 'phoneVerify';

  const PhoneVerifyScreen({Key? key}) : super(key: key);

  @override
  _PhoneVerifyScreenState createState() => _PhoneVerifyScreenState();
}

class _PhoneVerifyScreenState extends State<PhoneVerifyScreen> {
  final phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: kColorDeepGray,
      appBar: AppBar(
        backgroundColor: kColorDeepGray,
        iconTheme: IconThemeData(color: kColorDeepGray),
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
                child: SvgPicture.asset(kPhoneLogoImage),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Please enter your phone number',
                style: TextStyle(color: kColorDeepOrange, fontSize: 20.0),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
                child: TextFormField(
                  controller: phoneNumberController,
                  // keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                        borderSide: BorderSide.none),
                    fillColor: kTextFiledColor,
                    filled: true,
                    hintText: '20XXXXXXXX',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your phone number';
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
                        String result = await phoneVerification(
                            phoneNumberController.text, context);
                        print(result);
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Text(
                      'Next',
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

  Future<String> phoneVerification(String phoneNumber, BuildContext context) {
    final completer = Completer<String>();

    phoneNumber = '+856' + phoneNumber;
    print(phoneNumber);

    auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 30),
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
        completer.complete("signedUp");
      },
      verificationFailed: (FirebaseAuthException e) {
        String error = e.code == 'invalid-phone-number'
            ? "Invalid number. Enter again."
            : "Can Not Login Now. Please try again.";
        print(e);
        completer.complete(error);
      },
      codeSent: (String verificationId, int? forceResendingToken) {
        // Go to a page to input sms
        Navigator.pushNamed(
          context,
          PhoneOTPScreen.routeName,
          arguments: PhoneScreenArguments(
            verificationId: verificationId,
          ),
        );

        completer.complete("verified");
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        completer.complete("timeout");
      },
    );

    return completer.future;
  }
}
