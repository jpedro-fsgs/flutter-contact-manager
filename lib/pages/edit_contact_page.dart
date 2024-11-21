import 'package:agenda/models/contact.dart';
import 'package:flutter/material.dart';

class EditContactPage extends StatefulWidget {
  const EditContactPage({
    super.key,
    required this.contact,
    required this.editContact,
  });

  final Contact contact;
  final void Function(
      Contact contact, String name, String? number, String? email) editContact;

  @override
  EditContactPageState createState() => EditContactPageState();
}

class EditContactPageState extends State<EditContactPage> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String? _number;
  late String? _email;

  @override
  void initState() {
    super.initState();
    _name = widget.contact.name;
    _number = widget.contact.number;
    _email = widget.contact.email;
  }

  void onEdit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      debugPrint(_email);
      widget.editContact(
          widget.contact, _name, _number, _email != "" ? _email : null);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Contato atualizado com sucesso!'),
        ),
      );
      Navigator.pop(
          context,
          Contact(
              id: widget.contact.id,
              name: _name,
              number: _number,
              email: _email != "" ? _email : null));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Contato'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  initialValue: _name,
                  decoration: const InputDecoration(
                    labelText: 'Nome completo',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'O nome é obrigatório.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _name = value!;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: _number,
                  decoration: const InputDecoration(
                    labelText: 'Telefone',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'O telefone é obrigatório.';
                    }
                    final phoneRegex = RegExp(r"^\+?[0-9\s\-()]{7,15}$");
                    if (!phoneRegex.hasMatch(value)) {
                      return 'Insira um telefone válido.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _number = value;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: _email,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      final emailRegex = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                      if (!emailRegex.hasMatch(value)) {
                        return 'Insira um email válido.';
                      }
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _email = value;
                  },
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton.icon(
                    onPressed: onEdit,
                    icon: const Icon(Icons.save),
                    label: const Text('Atualizar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
