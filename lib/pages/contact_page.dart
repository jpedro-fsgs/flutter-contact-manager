import 'dart:io';

import 'package:agenda/models/contact.dart';
import 'package:agenda/pages/edit_contact_page.dart';
import 'package:agenda/utils/image_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ContactPage extends StatefulWidget {
  const ContactPage(
      {super.key,
      required this.removeContact,
      required this.editContact,
      required this.contact,
      required this.makeCall,
      required this.sendSMS,
      required this.sendEmail});

  final Contact contact;

  final void Function(int id) removeContact;
  final void Function(Contact, String, String?, String?, String?) editContact;
  final void Function(String) makeCall;
  final void Function(String) sendSMS;
  final void Function(String) sendEmail;

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
        final S = AppLocalizations.of(context)!;
        return AlertDialog(
          title: Text(S.removeConfirmTitle(_contact.name)),
          content: Text(S.removeConfirmContent(_contact.name)),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(S.cancel)),
            TextButton(
                onPressed: () {
                  widget.removeContact(_contact.id);

                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text(S.confirm))
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final S = AppLocalizations.of(context)!;
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
                        child: ListTile(
                          title: Text(S.edit),
                          leading: const Icon(Icons.edit),
                        )),
                    PopupMenuItem(
                        onTap: onRemove,
                        child: ListTile(
                          title: Text(S.delete),
                          leading: const Icon(Icons.delete),
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
                              imagePath: _contact.imagePath!,
                            ),
                          ))
                      : null,
                  child: Hero(
                    tag: _contact.imagePath ?? "tag-${_contact.id}",
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
                        trailing: IconButton(
                            onPressed: () => widget.sendSMS(_contact.number!),
                            icon: const Icon(Icons.message)),
                        onTap: () => widget.makeCall(_contact.number!),
                        subtitle: Text(S.number),
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
                        onTap: () => widget.sendEmail(_contact.email!),
                        subtitle: Text(S.email),
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
