import 'package:flutter_authentications/config/constant.dart';
import 'package:flutter_authentications/screens/phoneScreenArguments.dart';
import 'package:flutter_authentications/screens/screens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PhoneOTPScreen extends StatefulWidget {
  static const routeName = 'phoneOTP';

  const PhoneOTPScreen({Key? key}) : super(key: key);

  @override
  _PhoneOTPScreenState createState() => _PhoneOTPScreenState();
}

class _PhoneOTPScreenState extends State<PhoneOTPScreen> {
  final SMSCodeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    SMSCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as PhoneScreenArguments;

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
                child: SvgPicture.asset(kOTPLogoImage),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Please enter OTP number',
                style: TextStyle(color: kColorDeepOrange, fontSize: 20.0),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
                child: TextFormField(
                  controller: SMSCodeController,
                  // keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                        borderSide: BorderSide.none),
                    fillColor: kTextFiledColor,
                    filled: true,
                    hintText: 'XXXX',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter OTP number';
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
                        PhoneAuthCredential credential =
                            PhoneAuthProvider.credential(
                                verificationId: args.verificationId!,
                                smsCode: SMSCodeController.text);

                        await auth.signInWithCredential(credential);

                        //
                        Navigator.pushNamed(
                          context,
                          LoginSuccessScreen.routeName,
                          arguments: LoginScreenArguments(
                            loginMethod: 'Login by Phone Number',
                          ),
                        );
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Text(
                      'Verify',
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
