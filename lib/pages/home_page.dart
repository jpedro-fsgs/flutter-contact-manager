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

  void showInfo(String mensagem, {IconData? icon, Color? iconColor}) {

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            icon != null ? Icon(icon, color: iconColor) : const SizedBox.shrink(),
            const SizedBox(width: 8) ,
            Expanded(child: Text(mensagem)),
          ],
        ),
      ),
    );
  }

  void addContact(String name, String? number, String? email, String? imagePath) async {
    try {
      await _databaseService.addContact(name, number, email, imagePath);
      setState(() {});
      showInfo('Contato salvo com sucesso!',
          icon: Icons.check_circle, iconColor: Colors.green);
    } on Exception catch (e) {
      debugPrint(e.toString());
      showInfo('Não foi possível cadastrar o contato.',
          icon: Icons.error, iconColor: Colors.red);
    }
  }

  void editContact(
      Contact contact, String name, String? number, String? email, String? imagePath) async {
    try {
      await _databaseService.updateContact(contact.id, name, number, email, imagePath);
      setState(() {});
      showInfo('Contato atualizado com sucesso!',
          icon: Icons.check_circle, iconColor: Colors.green);
    } on Exception catch (e) {
      debugPrint(e.toString());
      showInfo('Não foi possível atualizar o contato.',
          icon: Icons.error, iconColor: Colors.red);
    }
  }

  void removeContact(int id) async {
    try {
      await _databaseService.removeContact(id);
      setState(() {});
      showInfo('Contato removido com sucesso.');
    } on Exception catch (e) {
      debugPrint(e.toString());
      showInfo('Não foi possível remover o contato.',
          icon: Icons.error, iconColor: Colors.red);
    }
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
