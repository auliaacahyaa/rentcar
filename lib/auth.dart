// import 'package:firebase_auth/firebase_auth.dart';

// class Auth {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   Future<void> regis(String email, String password) async {
//     final user = await _auth.createUserWithEmailAndPassword(
//       email: email,
//       password: password,
//     );
//   }

//   Future<void> login(String email, String password) async {
//     final user = await _auth.signInWithEmailAndPassword(
//       email: email,
//       password: password,
//     );
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> register(String name, String email, String password) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;

      // Save the user's name in the Firebase user profile
      await user?.updateDisplayName(name);

      // You can also save the user's name to other places like a database
      // For example: saveNameLocally(name);
    } catch (error) {
      print('Error during registration: $error');
      // Handle error, e.g., display an error message to the user
      rethrow; // Rethrow the error to be caught in the UI
    }
  }

  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (error) {
      print('Error during login: $error');
      // Handle error, e.g., display an error message to the user
      rethrow; // Rethrow the error to be caught in the UI
    }
  }
}