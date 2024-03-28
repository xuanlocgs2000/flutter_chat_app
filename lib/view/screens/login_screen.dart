import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/view/screens/home_screen.dart';
import 'package:flutter_chat/view/screens/register_screen.dart';
import 'package:flutter_chat/view/widgets/global_widget.dart';
import 'package:flutter_chat/view_model/login_bloc/login_envents.dart';
import 'package:flutter_chat/view_model/login_bloc/login_states.dart';
import 'package:flutter_chat/view_model/login_bloc/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final ButtonStyle style = ElevatedButton.styleFrom(
    textStyle: const TextStyle(fontSize: 20, color: Colors.white),
    backgroundColor: Colors.blue,
  );
  late TextEditingController emailController;
  late TextEditingController passswordController;
  late TextEditingController otpController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isPhone = false;
  bool _obscureText = false;
  LoginBloc loginBloc = LoginBloc(LoginScreenInitialState());
  @override
  void initState() {
    emailController = TextEditingController();
    passswordController = TextEditingController();
    emailController.addListener(() {
      if (emailController.text.contains('@')) {
        setState(() {
          isPhone = true;
        });
      } else {
        setState(() {
          isPhone = false;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passswordController.dispose();
    otpController.dispose();
    super.dispose();
  }

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
      controller: emailController,
      decoration: InputDecoration(
        // labelText: "Email",
        hintText: "Email or phone",
        hintStyle: TextStyle(
          fontSize: 16,
          color: Colors.grey,
        ),

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
    return Visibility(
      visible: isPhone,
      child: TextField(
        style: TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
        obscureText: !_obscureText,
        decoration: InputDecoration(
          labelText: "Password",
          prefixIcon: Icon(
            Icons.lock,
            size: 18,
            color: Colors.grey,
          ),
          suffixIcon: new GestureDetector(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child: new Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
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
    return GlobalWidgets.button(
      buttonText: "Login",
      width: 400,
      btnText: BlocConsumer<LoginBloc, LoginState>(
          bloc: loginBloc,
          builder: (context, state) {
            if (state is LoginScreenLoadingState) {
              return Center(
                child: SizedBox(
                    height: 50, width: 50, child: CircularProgressIndicator()),
              );
            } else {
              return Text(
                "Login",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              );
            }
          },
          listener: (context, state) {
            if (state is LoginScreenLoadedState) {
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (context) {
                return HomeScreen();
              }));
            } else if (state is LoginScreenErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.error,
                    style: TextStyle(),
                  ),
                ),
              );
            } else if (state is PhoneAuthCodeSentSuccess) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("OTP"),
                      content: TextField(
                        controller: otpController,
                        decoration: InputDecoration(hintText: "Enter OTP"),
                      ),
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              loginBloc.add(VerifySentOtp(
                                  state.verificationId, otpController.text));
                              Navigator.pop(context);
                            },
                            child: Text("Submit"))
                      ],
                    );
                  });
            }
          }),
      onTap: () {
        if (formKey.currentState!.validate()) {
          if (emailController.text.contains('+')) {
            loginBloc.add(SendOtpPhoneEvent(emailController.text));
          } else {
            //login by email vs pass
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Please fill all the fields"),
            ),
          );
        }
      },
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
              text: "Sign up new account",
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
                      builder: (context) => RegisterScreen(),
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
