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

  List<Contact> _contacts = [];
  List<Contact> _filteredContacts = [];

  bool isSearching = false;
  String? search;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  void showInfo(String mensagem, {IconData? icon, Color? iconColor}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            icon != null
                ? Icon(icon, color: iconColor)
                : const SizedBox.shrink(),
            const SizedBox(width: 8),
            Expanded(child: Text(mensagem)),
          ],
        ),
      ),
    );
  }

  void addContact(
      String name, String? number, String? email, String? imagePath) async {
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
    _loadContacts();
  }

  void editContact(Contact contact, String name, String? number, String? email,
      String? imagePath) async {
    try {
      await _databaseService.updateContact(
          contact.id, name, number, email, imagePath);
      setState(() {});
      showInfo('Contato atualizado com sucesso!',
          icon: Icons.check_circle, iconColor: Colors.green);
    } on Exception catch (e) {
      debugPrint(e.toString());
      showInfo('Não foi possível atualizar o contato.',
          icon: Icons.error, iconColor: Colors.red);
    }
    _loadContacts();
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
    _loadContacts();
  }

  Future<void> _loadContacts() async {
    try {
      final contacts = await _databaseService.getContacts();
      contacts.sort((a, b) => a.name.compareTo(b.name));
      setState(() {
        _contacts = contacts;
        _filteredContacts = contacts;
      });
    } on Exception catch (e) {
      debugPrint(e.toString());
      showInfo('Erro ao carregar contatos.',
          icon: Icons.error, iconColor: Colors.red);
    }
    if(_searchController.text.isNotEmpty) _filterContacts(_searchController.text);
  }

  void _filterContacts(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredContacts = _contacts;
      });
      return;
    }
    final filtered = _contacts
        .where((contact) =>
            contact.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    setState(() {
      _filteredContacts = filtered;
    });
  }

  void onSearch() {
    setState(() {
      isSearching = !isSearching;
      if (!isSearching) {
        _searchController.clear();
        _filterContacts("");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: !isSearching
            ? Text(widget.title)
            : TextField(
                controller: _searchController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Pesquisar contatos...',
                  border: InputBorder.none,
                ),
                onChanged: (value) => _filterContacts(value),
              ),
        actions: [
          IconButton(
              onPressed: onSearch,
              icon: !isSearching
                  ? const Icon(Icons.search)
                  : const Icon(Icons.close))
        ],
      ),
      body: _filteredContacts.isNotEmpty
          ? ContactsList(
              contacts: _filteredContacts,
              editContact: editContact,
              removeContact: removeContact,
            )
          : Center(
              child: Text(
              _contacts.isEmpty ? "No contacts added" : "No contacts found",
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
              ),
            )),
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
      ),
    );
  }
}
