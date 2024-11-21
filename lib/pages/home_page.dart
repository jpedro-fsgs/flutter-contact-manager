import 'package:agenda/models/contact.dart';
import 'package:agenda/pages/add_contact_page.dart';
import 'package:agenda/utils/contacts_list.dart';
import 'package:agenda/services/database_service.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final DatabaseService _databaseService = DatabaseService.instance;

  void addContact(String name, String? number, String? email) {
    setState(() {
      _databaseService.addContact(name, number, email);
    });
  }
  
  void editContact(Contact contact, String name, String? number, String? email) {
    setState(() {
      _databaseService.updateContact(contact.id, name, number, email);
      
    });
  }

  void removeContact(int id) {
    setState(() {
      _databaseService.removeContact(id);
    });
  }

  Future<List<Contact>> getContacts() async {
    List<Contact> contacts = await _databaseService.getContacts();
    contacts.sort((a, b) => a.name.compareTo(b.name));
    return contacts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ContactsList(
        getContacts: getContacts,
        editContact: editContact,
        removeContact: removeContact,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddContactPage(
                      addContact: addContact,
                    )),
          );
        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
