import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

//Google Login

  Future<User?> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // User canceled the sign-in
        throw Exception("Google Sign-In canceled by user");
      }
      // auth detail from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      // Sign in to Firebase with the  credential
      final userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      throw Exception("Google Sign-In failed: $e");
    }
  }

// Email signup for new users
  Future<User?> signUpAndSendVerification(
      String email, String password, String fullName) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await credential.user?.updateDisplayName(fullName);
    await credential.user?.reload();
    await credential.user?.sendEmailVerification();
    return credential.user;
  }

// Checks if the email is verified after signup
  Future<User?> loginIfVerified(String email, String password) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (credential.user != null && credential.user!.emailVerified) {
      return credential.user;
    } else {
      throw Exception('Email not verified. Please verify your email first.');
    }
  }

// sends password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

// logs out from the account
  Future<void> logout() async {
    await _firebaseAuth.signOut();

    await _googleSignIn.signOut();
  }

//returns the current logged in user
  User? get currentUser => _firebaseAuth.currentUser;
}
