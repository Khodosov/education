import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sirius23/presentation/profile_page.dart';

import '../application/di.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<ProfilePage>(
                  builder: (context) => ProfilePage(
                    user: Locator.firebaseAuth.currentUser!,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.person),
          ),
        ),
        body: StreamBuilder(
          builder: (_, __) => const Placeholder(),
        ),
      );
}
