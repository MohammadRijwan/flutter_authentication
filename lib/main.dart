import 'package:flutter_authentications/screens/loginSuccessScreen.dart';
import 'package:flutter_authentications/screens/screens.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Authentication Demo App',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        fontFamily: 'RobotoSlab',
      ),
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
        RegistrationScreen.routeName: (context) => RegistrationScreen(),
        RegistrationSuccessScreen.routeName: (context) => RegistrationSuccessScreen(),
        PhoneVerifyScreen.routeName: (context) => PhoneVerifyScreen(),
        PhoneOTPScreen.routeName: (context) => PhoneOTPScreen(),
      },
    );
  }
}
