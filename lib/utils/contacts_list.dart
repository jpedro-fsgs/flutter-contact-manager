import 'dart:io';

import 'package:agenda/models/contact.dart';
import 'package:agenda/pages/contact_page.dart';
import 'package:flutter/material.dart';

class ContactsList extends StatelessWidget {
  const ContactsList(
      {super.key,
      required this.contacts,
      required this.removeContact,
      required this.editContact,
      required this.makeCall, required this.sendSMS});

  final void Function(int) removeContact;
  final void Function(Contact, String, String?, String?, String?) editContact;
  final void Function(String) makeCall;
  final void Function(String) sendSMS;
  final List<Contact> contacts;

  void openContactPage(BuildContext context, Contact contact) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ContactPage(
          contact: contact,
          removeContact: removeContact,
          editContact: editContact,
          makeCall: makeCall,
          sendSMS: sendSMS,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: contacts.length,
      itemBuilder: (context, index) {
        Contact contact = contacts[index];
        return Card(
          elevation: 2.0, // Sombra para destacar o item.
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0), // Bordas arredondadas.
          ),
          color:
              Theme.of(context).colorScheme.surface, // Fundo baseado no tema.
          child: ListTile(
            onTap: () => openContactPage(context, contact),
            leading: Hero(
              tag: contact.imagePath ?? "tag-${contact.id}",
              child: CircleAvatar(
                foregroundImage: contact.imagePath != null
                    ? FileImage(File(contact.imagePath!))
                    : null,
                backgroundColor:
                    Theme.of(context).colorScheme.secondaryContainer,
                radius: 28.0,
                child: contact.imagePath == null
                    ? Text(
                        contact.name[0],
                        style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      )
                    : null,
              ),
            ),
            title: Text(
              contact.name,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w600,
                fontSize: 19.0,
              ),
            ),
            subtitle: Text(
              contact.number ?? "Sem número",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontSize: 14.0,
              ),
            ),
            trailing: IconButton(
              icon: Icon(
                Icons.phone,
                color: Theme.of(context).colorScheme.secondary,
              ),
              onPressed: () => makeCall(contact.number!),
            ),
            tileColor: Theme.of(context).colorScheme.surface,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          ),
        );
      },
    );
  }
}
