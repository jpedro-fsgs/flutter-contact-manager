import 'package:agenda/services/database_service.dart';
import 'package:flutter/material.dart';

class AddContactDialog extends StatefulWidget {
  const AddContactDialog({super.key, required this.databaseService});

  final DatabaseService databaseService;

  @override
  State<AddContactDialog> createState() => _AddContactDialogState();
}

class _AddContactDialogState extends State<AddContactDialog> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _numberController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  void _addContact() async {
    String name = _nameController.text;
    String? number = _numberController.text;
    String? email = _emailController.text;
    if (name == "") return;
    if (number == "") number = null;
    if (email == "") email = null;
    
    widget.databaseService.addContact(name, number, email);

    // setState(() {
    //   // _nameController.clear();
    //   // _numberController.clear();
    //   // _emailController.clear();
    // });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add Contact"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Name",
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: _numberController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Number",
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Email",
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          OutlinedButton(onPressed: _addContact, child: const Icon(Icons.add))
        ],
      ),
    );
  }
}
