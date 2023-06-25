import 'package:flutter/material.dart';
import 'package:sirius23/models/message.dart';
import 'package:sirius23/presentation/profile_page.dart';
import 'package:sirius23/presentation/widgets/message_widget.dart';

import '../application/di.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<ProfilePage>(
                  builder: (context) => ProfilePage(
                    user: Locator.api.currentUser!,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.person),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder<List<Message>>(
                stream: Locator.api.messages,
                builder: (context, snapshot) => snapshot.hasData
                    ? ListView.builder(
                        itemCount: snapshot.requireData.length,
                        itemBuilder: (context, index) => MessageWidget(
                          message: snapshot.requireData[index],
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        key: const ValueKey('TextForm'),
                        controller: _controller,
                        decoration: const InputDecoration(
                          hintText: 'Leave a message',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter your message to continue';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          Locator.api.post(_controller.text);
                          _controller.clear();
                        }
                      },
                      icon: const Icon(Icons.send),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
