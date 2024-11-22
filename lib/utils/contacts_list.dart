import 'dart:io';

import 'package:agenda/models/contact.dart';
import 'package:agenda/pages/contact_page.dart';
import 'package:flutter/material.dart';

class ContactsList extends StatelessWidget {
  const ContactsList(
      {super.key,
      required this.getContacts,
      required this.removeContact,
      required this.editContact});

  final Future<List<Contact>> Function() getContacts;
  final void Function(int) removeContact;
  final void Function(Contact, String, String?, String?, String?) editContact;

  void openContactPage(BuildContext context, Contact contact) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ContactPage(
          contact: contact,
          removeContact: removeContact,
          editContact: editContact,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getContacts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outlined,
                    color: Theme.of(context).colorScheme.error,
                    size: 54,
                  ),
                  Text(
                    "Houve um erro",
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.error),
                  )
                ],
              ),
            );
          }
          if (snapshot.data?.isEmpty ?? true) {
            return Center(
                child: Text(
              "No contacts added",
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ));
          }
          return ListView.builder(
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (context, index) {
              Contact contact = snapshot.data![index];
              return Card(
                elevation: 2,
                child: ListTile(
                  onTap: () => openContactPage(context, contact),
                  leading: CircleAvatar(
                    foregroundImage: contact.imagePath != null
                        ? FileImage(File(contact.imagePath!))
                        : null,
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    child: Text(contact.name[0]),
                  ),
                  title: Text(
                    contact.name,
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                  tileColor: Theme.of(context).colorScheme.primaryContainer,
                ),
              );
            },
          );
        });
  }
}
