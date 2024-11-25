import 'dart:io';

import 'package:agenda/models/contact.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditContactPage extends StatefulWidget {
  const EditContactPage({
    super.key,
    required this.contact,
    required this.editContact,
  });

  final Contact contact;
  final void Function(Contact, String, String?, String?, String?) editContact;

  @override
  EditContactPageState createState() => EditContactPageState();
}

class EditContactPageState extends State<EditContactPage> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String? _number;
  late String? _email;
  late String? _imagePath;

  late File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _name = widget.contact.name;
    _number = widget.contact.number;
    _email = widget.contact.email;
    _imagePath = widget.contact.imagePath;
    _selectedImage = _imagePath != null ? File(_imagePath!) : null;
  }

  void onEdit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      widget.editContact(widget.contact, _name, _number,
          _email != "" ? _email : null, _imagePath != "" ? _imagePath : null);

      Navigator.pop(
          context,
          Contact(
              id: widget.contact.id,
              name: _name.trim(),
              number: _number,
              email: _email != "" ? _email : null,
              imagePath: _imagePath != "" ? _imagePath : null));
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
    final S = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(S.editContact),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
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
                          child: Text(S.removeImage,
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.error)))
                      : null,
                ),
                TextFormField(
                  initialValue: _name,
                  decoration: InputDecoration(
                    labelText: S.fullName,
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return S.fullNameRequired;
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
                  decoration: InputDecoration(
                    labelText: S.phone,
                    border: const OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return S.phoneRequired;
                    }
                    final phoneRegex = RegExp(r"^\+?[0-9\s\-()]{7,24}$");
                    if (!phoneRegex.hasMatch(value)) {
                      return S.phoneValidate;
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
                  decoration: InputDecoration(
                    labelText: S.email,
                    border: const OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      final emailRegex = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                      if (!emailRegex.hasMatch(value)) {
                        return S.emailValidate;
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
                    label: Text(S.update),
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
