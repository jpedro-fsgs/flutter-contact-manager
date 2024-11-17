import 'package:agenda/models/contact.dart';
import 'package:flutter/material.dart';

class ContactsList extends StatelessWidget {
  const ContactsList({
    super.key,
    required this.contacts,
  });

  final List<Contact> contacts;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (BuildContext context, index) {
          return Container(
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.all(8.0),
            decoration:
                BoxDecoration(color: Theme.of(context).highlightColor),
            child: Text(contacts[index].name),
          );
        });
  }
}
