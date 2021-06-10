import 'package:flutter_authentications/config/constant.dart';
import 'package:flutter_authentications/screens/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegistrationSuccessScreen extends StatelessWidget {
  static const routeName = 'registration_success';

  const RegistrationSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorDeepGray,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 70.0, 10.0, 40.0),
            child: SizedBox(
              height: 350.0,
              width: double.infinity,
              child: SvgPicture.asset(kRegistrationSuccessImage),
            ),
          ),
          Text(
            'Registration',
            style: kTitle
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            "Success",
            style: kSubTitle,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50.0, 50.0, 50.0, 0.0),
            child: SizedBox(
              width: double.infinity,
              height: 50.0,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: kColorDeepOrange),
                onPressed: () {
                  Navigator.pushNamed(context, HomeScreen.routeName);
                },
                child: Text(
                  'Return Home',
                  style: TextStyle(
                      fontSize: 20.0,
                      color: kColorDeepGray
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
