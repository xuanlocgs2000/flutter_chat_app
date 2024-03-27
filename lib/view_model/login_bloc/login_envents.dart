import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginEvents {
  const LoginEvents();
}

class SendOtpPhoneEvent extends LoginEvents {
  final String number;
  SendOtpPhoneEvent(this.number);
}

class OnPhoneOtpSend extends LoginEvents {
  final String verificationId;
  final int? token;
  OnPhoneOtpSend(this.verificationId, this.token);
}

class VerifySentOtp extends LoginEvents {
  final String OtpCode;
  final String verificationId;
  VerifySentOtp(this.OtpCode, this.verificationId);
}

class OnPhoneAuthErrorEvent extends LoginEvents {
  final String error;
  OnPhoneAuthErrorEvent(this.error);
}

class OnPhoneAuthVerificationCompletedEvent extends LoginEvents {
  //note
  final AuthCredential credential;
  OnPhoneAuthVerificationCompletedEvent(this.credential);
}
