import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

class AuthService {
  AuthService._();

  static Future<MapEntry<String, String>> signInWithGoogle(String name) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        await auth.signInWithCredential(credential);
        await auth.currentUser?.updateDisplayName(name);

        return MapEntry(auth.currentUser!.uid, googleSignInAccount.email);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          throw const AuthException(
            'Account exists with different credentials',
          );
        } else if (e.code == 'invalid-credential') {
          throw const AuthException('Invalid Credentials');
        } else {
          throw const AuthException('Error occurred, try again.');
        }
      } catch (_) {
        throw const AuthException('Error occurred, try again.');
      }
    } else {
      throw const AuthException(
        'Login canceled. You can sign in anytime later.',
      );
    }
  }

  static Future<void> signIn({
    required String email,
    required String password,
  }) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  static Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    await auth.createUserWithEmailAndPassword(email: email, password: password);
    auth.currentUser?.updateDisplayName(name);
  }

  static Future<void> signOut() async {
    try {
      await GoogleSignIn().signOut();
      await auth.signOut();
    } catch (_) {
      throw const AuthException('Error occurred, try again.');
    }
  }

  static String get name => auth.currentUser?.displayName ?? 'User';
  static Future<void> updateName(String value) async =>
      await auth.currentUser?.updateDisplayName(name);
  static String? get uid => auth.currentUser?.uid;
  static String? get email => auth.currentUser?.email;

  static bool get isUserSignedIn => auth.currentUser == null ? false : true;
}

class AuthException implements Exception {
  const AuthException(this.error);

  final String error;
}
