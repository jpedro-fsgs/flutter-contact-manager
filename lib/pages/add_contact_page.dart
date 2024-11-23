import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddContactPage extends StatefulWidget {
  const AddContactPage({super.key, required this.addContact});

  final void Function(
      String name, String? number, String? email, String? imagePath) addContact;

  @override
  AddContactPageState createState() => AddContactPageState();
}

class AddContactPageState extends State<AddContactPage> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  String? _number;
  String? _email;
  String? _imagePath;
  File? _selectedImage;

  void onAdd() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      widget.addContact(
          _name, _number, _email != "" ? _email : null, _imagePath);

      Navigator.pop(context);
    }
  }

  Future<void> _pickImage() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage != null) {
      setState(() {
        _selectedImage = File(returnedImage.path);
        _imagePath = returnedImage.path;
      });
    }
  }

  void _removeImage() {
    setState(() {
      _selectedImage = null;
      _imagePath = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Contato'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 16.0),
                GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      foregroundImage: _selectedImage != null
                          ? FileImage(_selectedImage!)
                          : null,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      radius: 84.0,
                      child: _selectedImage == null
                          ? Icon(
                              Icons.add_photo_alternate_rounded,
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              size: 84.0,
                            )
                          : null,
                    )),
                SizedBox(
                  height: 42.0,
                  child: _selectedImage != null
                      ? TextButton(
                          onPressed: _removeImage,
                          child: Text("Remover imagem",
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.error)))
                      : null,
                ),
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
                    final phoneRegex = RegExp(r"^\+?[0-9\s\-()]{7,24}$");
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
                    onPressed: onAdd,
                    icon: const Icon(Icons.save),
                    label: const Text('Salvar'),
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
