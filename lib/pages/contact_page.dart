import 'dart:io';

import 'package:agenda/models/contact.dart';
import 'package:agenda/pages/edit_contact_page.dart';
import 'package:agenda/utils/image_page.dart';
import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {
  const ContactPage(
      {super.key,
      required this.removeContact,
      required this.editContact,
      required this.contact});

  final Contact contact;

  final void Function(int id) removeContact;

  final void Function(Contact, String, String?, String?, String?) editContact;

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  late Contact _contact;

  @override
  void initState() {
    super.initState();
    _contact = widget.contact;
  }

  void onEdit() async {
    //Envia para a página de edição, e recebe um objeto Contato
    //Caso o Contato não seja nulo, a página é atualizada
    Contact? updatedContact = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditContactPage(
          contact: _contact,
          editContact: widget.editContact,
        ),
      ),
    );
    if (updatedContact != null) {
      setState(() {
        _contact = updatedContact;
      });
    }
  }

  void onRemove() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Excluir ${_contact.name}?"),
          content: Text(
              'Deseja excluir permanentemente o contato "${_contact.name}"?'),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancelar")),
            TextButton(
                onPressed: () {
                  widget.removeContact(_contact.id);

                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text("Confirmar"))
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).colorScheme.primary;

    TextStyle nameTitleStyle = TextStyle(
      color: primaryColor,
      fontSize: 56.0,
    );

    TextStyle contactInfoTitleStyle = TextStyle(
        color: Theme.of(context).colorScheme.secondary, fontSize: 18.0);

    TextStyle contactInfoSubtitleStyle = TextStyle(
        color: Theme.of(context).colorScheme.secondary, fontSize: 16.0);

    return Scaffold(
      appBar: AppBar(
        title: Text(_contact.name),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          PopupMenuButton(
              itemBuilder: (context) => [
                    PopupMenuItem(
                        onTap: onEdit,
                        child: const ListTile(
                          title: Text("Editar"),
                          leading: Icon(Icons.edit),
                        )),
                    PopupMenuItem(
                        onTap: onRemove,
                        child: const ListTile(
                          title: Text("Excluir"),
                          leading: Icon(Icons.delete),
                        )),
                  ]),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: _contact.imagePath != null
                      ? () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ImagePage(
                              title: _contact.name,
                              imageUrl: _contact.imagePath!,
                            ),
                          ))
                      : null,
                  child: Hero(
                    tag: _contact.imagePath ?? _contact.id,
                    child: CircleAvatar(
                      foregroundImage: _contact.imagePath != null
                          ? FileImage(File(_contact.imagePath!))
                          : null,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      radius: 84.0,
                      child: Text(
                        _contact.name[0],
                        style: TextStyle(
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                            fontSize: 84.0),
                      ),
                    ),
                  ),
                ),
                Text(
                  _contact.name,
                  style: nameTitleStyle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 16,
                ),
                _contact.number != null
                    ? ListTile(
                        tileColor:
                            Theme.of(context).colorScheme.surfaceContainer,
                        leading: Icon(
                          Icons.phone,
                          color: primaryColor,
                        ),
                        subtitle: const Text("Número"),
                        subtitleTextStyle: contactInfoSubtitleStyle,
                        title: Text(_contact.number ?? ""),
                        titleTextStyle: contactInfoTitleStyle)
                    : const SizedBox.shrink(),
                const SizedBox(
                  height: 5,
                ),
                _contact.email != null
                    ? ListTile(
                        tileColor:
                            Theme.of(context).colorScheme.surfaceContainer,
                        leading: Icon(
                          Icons.email,
                          color: primaryColor,
                        ),
                        subtitle: const Text("Email"),
                        subtitleTextStyle: contactInfoSubtitleStyle,
                        title: Text(_contact.email ?? ""),
                        titleTextStyle: contactInfoTitleStyle)
                    : const SizedBox.shrink()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
