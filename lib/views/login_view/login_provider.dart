import 'package:ev_bul/product/constants/string_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginProvider = StateNotifierProvider<LoginNotifier, bool>((ref) {
  return LoginNotifier();
});

class LoginNotifier extends StateNotifier<bool> {
  LoginNotifier() : super(false);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void toggleFormType() => state = !state;

  Future<String?> signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message ?? StringConstants.loginError;
    }
  }

  Future<String?> signUp() async {
    if (passwordController.text != confirmPasswordController.text) {
      return StringConstants.dontMatch;
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message ?? StringConstants.registerError;
    }
  }
}
