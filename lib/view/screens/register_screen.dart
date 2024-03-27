import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/view/screens/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  final ButtonStyle style = ElevatedButton.styleFrom(
    textStyle: const TextStyle(fontSize: 20, color: Colors.white),
    backgroundColor: Colors.blue,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              _buildLogo(),
              SizedBox(height: 10),
              _buildTitle('Hello'),
              _buildTitle('Welcome to the app'),
              SizedBox(height: 35),
              _buildEmailTextField(),
              SizedBox(height: 10),
              // _buildPhoneTextField(),
              // SizedBox(height: 10),
              _buildNameTextField(),
              SizedBox(height: 10),
              _buildPasswordTextField(),
              SizedBox(height: 10),
              _buildForgotPasswordText(),
              SizedBox(height: 20),
              _buildSignInButton(),
              SizedBox(height: 20),
              _buildSignUpText(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      width: 70,
      height: 70,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color.fromARGB(255, 199, 204, 208),
      ),
      child: FlutterLogo(),
    );
  }

  Widget _buildTitle(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildEmailTextField() {
    return TextField(
      style: TextStyle(
        fontSize: 18,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        labelText: "Email",
        prefixIcon: Icon(
          Icons.email,
          size: 18,
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
      ),
    );
  }

  // Widget _buildPhoneTextField() {
  //   return StreamBuilder(
  //     // stream: authBloc.phoneStream,
  //     builder: (context, snapshot) => TextField(
  //       style: TextStyle(
  //         fontSize: 18,
  //         color: Colors.black,
  //       ),
  //       decoration: InputDecoration(
  //         labelText: "Phone number",
  //         prefixIcon: Icon(
  //           Icons.email,
  //           size: 18,
  //           color: Colors.grey,
  //         ),
  //         border: OutlineInputBorder(
  //           borderSide: BorderSide(color: Colors.grey, width: 1),
  //           borderRadius: BorderRadius.all(Radius.circular(5.0)),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildNameTextField() {
    return TextField(
      style: TextStyle(
        fontSize: 18,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        labelText: "Name",
        prefixIcon: Icon(
          Icons.email,
          size: 18,
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
      ),
    );
  }

  Widget _buildPasswordTextField() {
    return TextField(
      style: TextStyle(
        fontSize: 18,
        color: Colors.black,
      ),
      obscureText: true,
      decoration: InputDecoration(
        labelText: "Password",
        prefixIcon: Icon(
          Icons.lock,
          size: 18,
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
      ),
    );
  }

  Widget _buildForgotPasswordText() {
    return Container(
      alignment: Alignment.centerRight,
      child: Text(
        "Forgot password?",
        style: TextStyle(
          fontSize: 15,
          color: Colors.blue,
        ),
      ),
    );
  }

  Widget _buildSignInButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: style,
        onPressed: () {},
        child: const Text('Sign In'),
      ),
    );
  }

  Widget _buildSignUpText(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 40),
      child: RichText(
        text: TextSpan(
          text: "New user? ",
          style: TextStyle(fontSize: 15, color: Colors.grey),
          children: <TextSpan>[
            TextSpan(
              text: "Login your account",
              style: TextStyle(
                fontSize: 15,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  );
                },
            ),
          ],
        ),
      ),
    );
  }
}
