import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../application/di.dart';

class ProfilePage extends StatelessWidget {
  final User user;

  const ProfilePage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text(user.email ?? ''),
          actions: [
            IconButton(
              onPressed: () {
                Locator.firebaseAuth.signOut();
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.logout_rounded),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'User name ${user.displayName}',
                style: const TextStyle(fontSize: 30),
              ),
              Text(
                'User isAnonymous ${user.isAnonymous}',
                style: const TextStyle(fontSize: 30),
              ),
              Text(
                'User emailVerified ${user.emailVerified}',
                style: const TextStyle(fontSize: 30),
              ),
              Text(
                'User photoURL ${user.photoURL}',
                style: const TextStyle(fontSize: 30),
              ),
            ],
          ),
        ),
      );
}
