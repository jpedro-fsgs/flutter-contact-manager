import 'package:flutter/material.dart';

class AddContactPage extends StatefulWidget {
  const AddContactPage({super.key, required this.addContact});

  final void Function(String name, String? number, String? email) addContact;
  
  @override
  AddContactPageState createState() => AddContactPageState();
}

class AddContactPageState extends State<AddContactPage> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  String? _phone;
  String? _email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Contato'),
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
                  decoration: const InputDecoration(
                    labelText: 'Telefone',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'O telefone é obrigatório.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _phone = value;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
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
                ElevatedButton.icon(
                  onPressed: () {
                    // Função para salvar o contato
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      widget.addContact(_name, _phone, _email);


                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Contato salvo com sucesso!'),
                        ),
                      );
                      Navigator.pop(context); // Volta para a página anterior
                    }
                  },
                  icon: const Icon(Icons.save),
                  label: const Text('Salvar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
