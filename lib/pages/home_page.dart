import 'package:agenda/models/contact.dart';
import 'package:agenda/utils/contacts_list.dart';
import 'package:agenda/utils/add_contact_dialog.dart';
import 'package:agenda/services/database_service.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final DatabaseService _databaseService = DatabaseService.instance;

  void addContact(String name, String? number, String? email){
    setState(() {
      _databaseService.addContact(name, number, email);
    });
  }

  Future<List<Contact>> getContacts() async{
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
      body: ContactsList(getContacts: getContacts,),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) => AddContactDialog(
                    addContact: addContact,
                  ));
        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
