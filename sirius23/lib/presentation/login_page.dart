import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:sirius23/application/di.dart';
import 'package:sirius23/presentation/messages_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => StreamBuilder<User?>(
        stream: Locator.firebaseAuth.authStateChanges(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            /// Default widget!
            return const SignInScreen(
              providerConfigs: [
                EmailProviderConfiguration(),

                // GoogleProviderConfiguration(
                //   clientId:
                //       '939439499093-7olcihphbek5slk3nuqd7koiufaea04p.apps.googleusercontent.com',
                // ),
              ],
            );
          }
          if (snapshot.requireData != null) {
            return const MessagesPage();
          }
          return const SizedBox.shrink();
        },
      );
}
