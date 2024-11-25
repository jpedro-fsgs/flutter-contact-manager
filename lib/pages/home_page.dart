import 'package:agenda/models/contact.dart';
import 'package:agenda/pages/add_contact_page.dart';
import 'package:agenda/utils/contacts_list.dart';
import 'package:agenda/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.onChangeLocale});

  final Function(Locale) onChangeLocale;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

String removeNonNumeric(String input) {
  return input.replaceAll(RegExp(r'[^0-9]'), '');
}

bool validPhoneNumber(String input) {
  final phoneRegex = RegExp(r"^\+?[0-9\s\-()]{1,24}$");
  return phoneRegex.hasMatch(input);
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

  void makeCall(String phoneNumber) async {
    final S = AppLocalizations.of(context)!;
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      showInfo(S.phoneCallError, icon: Icons.error, iconColor: Colors.red);
    }
  }

  void sendSMS(String phoneNumber) async {
    final S = AppLocalizations.of(context)!;
    final Uri smsUri = Uri(scheme: 'sms', path: phoneNumber);
    if (await canLaunchUrl(smsUri)) {
      await launchUrl(smsUri);
    } else {
      showInfo(S.smsError, icon: Icons.error, iconColor: Colors.red);
    }
  }

  void sendEmail(String emailAdress) async {
    final S = AppLocalizations.of(context)!;
    final Uri emailUri = Uri(scheme: 'mailto', path: emailAdress);
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      showInfo(S.emailError, icon: Icons.error, iconColor: Colors.red);
    }
  }

  void addContact(
      String name, String? number, String? email, String? imagePath) async {
    final S = AppLocalizations.of(context)!;
    try {
      await _databaseService.addContact(name, number, email, imagePath);
      setState(() {});
      showInfo(S.addContactSuccess,
          icon: Icons.check_circle, iconColor: Colors.green);
    } on Exception catch (e) {
      debugPrint(e.toString());
      showInfo(S.addContactError, icon: Icons.error, iconColor: Colors.red);
    }
    _loadContacts();
  }

  void editContact(Contact contact, String name, String? number, String? email,
      String? imagePath) async {
    final S = AppLocalizations.of(context)!;
    try {
      await _databaseService.updateContact(
          contact.id, name, number, email, imagePath);
      setState(() {});
      showInfo(S.editContactSuccess,
          icon: Icons.check_circle, iconColor: Colors.green);
    } on Exception catch (e) {
      debugPrint(e.toString());
      showInfo(S.editContactError, icon: Icons.error, iconColor: Colors.red);
    }
    _loadContacts();
  }

  void removeContact(int id) async {
    final S = AppLocalizations.of(context)!;
    try {
      await _databaseService.removeContact(id);
      setState(() {});
      showInfo(S.removeContactSuccess);
    } on Exception catch (e) {
      debugPrint(e.toString());
      showInfo(S.removeContactError, icon: Icons.error, iconColor: Colors.red);
    }
    _loadContacts();
  }

  Future<void> _loadContacts() async {
    // final S = AppLocalizations.of(context)!;
    try {
      final contacts = await _databaseService.getContacts();
      contacts.sort((a, b) => a.name.compareTo(b.name));
      setState(() {
        _contacts = contacts;
        _filteredContacts = contacts;
      });
    } on Exception catch (e) {
      debugPrint(e.toString());
      showInfo("Error loading contacts",
          icon: Icons.error, iconColor: Colors.red);
    }
    if (_searchController.text.isNotEmpty) {
      _filterContacts(_searchController.text);
    }
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
            contact.name.toLowerCase().contains(query.toLowerCase()) ||
            (validPhoneNumber(query) &&
                removeNonNumeric(contact.number!)
                    .contains(removeNonNumeric(query))))
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

  void languagePt() {
    widget.onChangeLocale(const Locale('pt'));
  }

  void languageEn() {
    widget.onChangeLocale(const Locale('en'));
  }

  @override
  Widget build(BuildContext context) {
    final S = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: PopupMenuButton<String>(
          icon: const Icon(Icons.language),
          onSelected: (String value) {
            if (value == 'en') {
              languageEn(); // Troca para inglês
            } else if (value == 'pt') {
              languagePt(); // Troca para português
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            PopupMenuItem<String>(
              value: 'en',
              child: ListTile(
                title: Text(S.english),
                trailing: S.localeName == 'en' ? const Icon(Icons.check) : null,
              ),
            ),
            PopupMenuItem<String>(
              value: 'pt',
              child: ListTile(
                title: Text(S.portuguese),
                trailing: S.localeName == 'pt' ? const Icon(Icons.check) : null,
              ),
            ),
          ],
        ),
        title: !isSearching
            ? Text(S.contactsList)
            : TextField(
                controller: _searchController,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: S.searchContacts,
                  border: InputBorder.none,
                ),
                onChanged: (value) => _filterContacts(value),
              ),
        actions: [
          IconButton(
              onPressed: onSearch,
              icon: !isSearching
                  ? const Icon(Icons.search)
                  : const Icon(Icons.close)),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      body: _filteredContacts.isNotEmpty
          ? ContactsList(
              contacts: _filteredContacts,
              editContact: editContact,
              removeContact: removeContact,
              makeCall: makeCall,
              sendSMS: sendSMS,
              sendEmail: sendEmail,
            )
          : Center(
              child: Text(
              _contacts.isEmpty ? S.noContactsAdded : S.noContactsFound,
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
        tooltip: S.addContact,
        child: const Icon(Icons.add),
      ),
    );
  }
}
