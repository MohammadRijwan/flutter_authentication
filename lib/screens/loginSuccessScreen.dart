import 'package:flutter_authentications/config/constant.dart';
import 'package:flutter_authentications/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginSuccessScreen extends StatelessWidget {
  static const routeName = 'login_success';

  const LoginSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as LoginScreenArguments;

    return Scaffold(
      backgroundColor: kColorDeepGray,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 70.0, 10.0, 20.0),
            child: SizedBox(
              height: 200.0,
              width: double.infinity,
              child: SvgPicture.asset(kLoginSuccessImage),
            ),
          ),
          Text(
            'Login',
            style: kTitle
          ),
          Text(
            args.loginMethod! + " Success",
            style: kSubTitle,
          ),
          SizedBox(
            height: 20.0,
          ),
          args.photoURL != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(999.0),
                  child: Image.network(
                    args.photoURL.toString(),
                  ),
                )
              : Container(),
          args.displayName != null
              ? Text(
                  args.displayName.toString(),
                  style: TextStyle(
                    color: kColorLightGray,
                    fontSize: 20.0,
                  ),
                )
              : Container(),
          args.email != null
              ? Text(
                  args.email.toString(),
                  style: TextStyle(
                    color: kColorLightGray,
                    fontSize: 20.0,
                  ),
                )
              : Container(),
          args.phoneNumber != null
              ? Text(
                  args.phoneNumber.toString(),
                  style: TextStyle(
                    color: kColorLightGray,
                    fontSize: 20.0,
                  ),
                )
              : Container(),
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
                  style: kButtonText,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
