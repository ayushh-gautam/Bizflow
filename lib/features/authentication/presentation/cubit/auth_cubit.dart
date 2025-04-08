import 'package:bizflow/features/authentication/domain/repository/auth_repository.dart';
import 'package:bizflow/features/authentication/presentation/pages/login_page.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;
  AuthCubit(this._authRepository) : super(AuthInitial());

  void signUpAndSendVerification(
      String email, String password, String fullName) async {
    emit(AuthLoading());
    try {
      final user = await _authRepository.signUpAndSendVerification(
          email, password, fullName);
      emit(AuthVerificationSent(user: user));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  void loginIfVerified(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await _authRepository.loginIfVerified(email, password);
      emit(AuthLoggedIn(user: user));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  

void loginWithGoogle() async {
    emit(AuthLoading());
    try {
      final user = await _authRepository.loginWithGoogle();
      if (user != null) {
        emit(AuthLoggedIn(user: user));
      } else {
        emit(AuthError(message: "Google Sign-In failed: No user returned"));
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  void logout(context) async {
    emit(AuthLoading());
    try {
      await _authRepository.logout();
      emit(AuthLoggedOut());
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) =>
              LoginPage())); // Replace with your desired route
    } catch (e) {
      emit(AuthError(message: e.toString())); // Handle errors appropriately
    }
  }

  void checkUserState() {
    final user = _authRepository.currentUser;
    if (user != null && user.emailVerified) {
      emit(AuthLoggedIn(user: user));
    } else {
      emit(AuthLoggedOut());
    }
  }

  void sendPasswordResetEmail(String email) async {
    if (email.isEmpty) {
      emit(AuthError(message: "Email cannot be empty"));
      return;
    }

    emit(AuthLoading());

    try {
      await _authRepository.sendPasswordResetEmail(email);
      emit(PasswordResetEmailSent(
          message: 'Password reset email sent! Check your inbox.')
          
          );
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }
}
