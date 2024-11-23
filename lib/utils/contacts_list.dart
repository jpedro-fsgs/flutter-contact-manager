import 'dart:io';

import 'package:agenda/models/contact.dart';
import 'package:agenda/pages/contact_page.dart';
import 'package:flutter/material.dart';

class ContactsList extends StatelessWidget {
  const ContactsList(
      {super.key,
      required this.contacts,
      required this.removeContact,
      required this.editContact});

  final void Function(int) removeContact;
  final void Function(Contact, String, String?, String?, String?) editContact;
  final List<Contact> contacts;

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
    return  ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              Contact contact = contacts[index];
              return Card(
                elevation: 2,
                child: ListTile(
                  onTap: () => openContactPage(context, contact),
                  leading: Hero(
                    tag: contact.imagePath ?? "tag-${contact.id}",
                    child: CircleAvatar(
                      foregroundImage: contact.imagePath != null
                          ? FileImage(File(contact.imagePath!))
                          : null,
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      child: Text(contact.name[0]),
                    ),
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
        }
  }
