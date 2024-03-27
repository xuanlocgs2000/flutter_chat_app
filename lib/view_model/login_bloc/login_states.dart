abstract class LoginState {
  const LoginState();
}

class LoginScreenLoadingState extends LoginState {}

class LoginScreenInitialState extends LoginState {}

class LoginScreenLoadedState extends LoginState {}

class LoginScreenErrorState extends LoginState {
  String error;
  LoginScreenErrorState(this.error);
}

class PhoneAuthCodeSentSuccess extends LoginState {
  final String verificationId;
  PhoneAuthCodeSentSuccess(this.verificationId);
}

class RegisterScreenOtpSuccessState extends LoginState {
  //note
}
