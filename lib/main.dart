import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBycdqqIYUyLXGUeVF21Zv9NP7iOB4Mcvs",
          appId: "1:507192110981:android:75d8f3452f35054455deec",
          messagingSenderId: "507192110981",
          projectId: "flutter-demo-4bf94"));
  runApp(const MyApplication());
}

Future<bool> signIn(FirebaseAuth auth) async {
  try {
    // final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    // // Obtain the auth details from the request.
    // final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    // // Create a new credential.
    // final GoogleAuthCredential googleCredential = GoogleAuthProvider.credential(
    //   accessToken: googleAuth.accessToken,
    //   idToken: googleAuth.idToken,
    // );
    UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: "uveshmenpur.03@gmail.com", password: "SuperSecretPassword!");
    print('REQUEST --> ${userCredential.user?.displayName}');
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('REQUEST --> No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('REQUEST --> Wrong password provided for that user.');
    }
    print("REQUEST --> ${e.message}");
    print("REQUEST --> ${e.stackTrace}");
    return false;
  }
}

class MyApplication extends StatefulWidget {
  const MyApplication({super.key});

  @override
  State<MyApplication> createState() => _MyApplicationState();
}

class _MyApplicationState extends State<MyApplication> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: const Center(
          child: Text('Firebase'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            bool isSignIn = await signIn(auth);
            print("REQUEST --> $isSignIn");
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.8,
                    height: 100,
                    child: Text(isSignIn
                        ? 'User Sign IN Successfully'
                        : 'User Sign IN Failed'),
                  ),
                ),
              );
            }
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
