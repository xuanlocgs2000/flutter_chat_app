import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/repository/authModel.dart';
import 'package:flutter_chat/view/screens/login_screen.dart';
import 'package:flutter_chat/view_model/login_bloc/login_envents.dart';
import 'package:flutter_chat/view_model/login_bloc/login_states.dart';

class LoginBloc extends Bloc<LoginEvents, LoginState> {
  String LoginResult = '';
  AuthModel authModel = AuthModel();
  UserCredential? userCredential;
  LoginBloc(super.initialState) {
    on<SendOtpPhoneEvent>(((event, emit) async {
      emit(LoginScreenLoadingState());
      try {
        await authModel.loginWithPhone(
            phoneNumber: event.number,
            verificationCompleted: (PhoneAuthCredential credentials) {
              add(OnPhoneAuthVerificationCompletedEvent(credentials));
            },
            verificationFailed: (FirebaseAuthException e) {
              add(OnPhoneAuthErrorEvent(e.toString()));
            },
            codeSent: (String verificationId, int? refreshToken) {
              add(OnPhoneOtpSend(verificationId, refreshToken));
            },
            codeAutoRetrievalTimeout: (String verificationId) {});
      } catch (e) {
        emit(LoginScreenErrorState(e.toString()));
      }
    }));
    on<OnPhoneOtpSend>((event, emit) {
      emit(PhoneAuthCodeSentSuccess(event.verificationId));
    });
    on<VerifySentOtp>((event, emit) {
      try {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: event.verificationId,
            smsCode: event.verificationId);
        add(OnPhoneAuthVerificationCompletedEvent(credential));
      } catch (e) {
        emit(LoginScreenErrorState(e.toString()));
      }
    });
    on<OnPhoneAuthErrorEvent>((event, emit) {
      emit(LoginScreenErrorState(event.error.toString()));
    });
    on<OnPhoneAuthVerificationCompletedEvent>((event, emit) async {
      try {
        await authModel.authentication
            .signInWithCredential(event.credential)
            .then((value) {
          emit(RegisterScreenOtpSuccessState());
          emit(LoginScreenLoadedState());
        });
      } catch (e) {
        emit(LoginScreenErrorState(e.toString()));
      }
    });
    // on<VerifySentOtp>((event, emit){});
  }
}
