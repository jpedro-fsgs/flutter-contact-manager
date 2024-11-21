import 'package:agenda/models/contact.dart';
import 'package:agenda/pages/edit_contact_page.dart';
import 'package:flutter/material.dart';

class ContactPage extends StatelessWidget {
  const ContactPage(
      {super.key,
      required this.removeContact,
      required this.editContact,
      required this.contact});

  final Contact contact;

  final void Function(int id) removeContact;

  final void Function(Contact, String, String?, String?) editContact;

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

    void onEdit() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditContactPage(
            contact: contact,
            editContact: editContact,
          ),
        ),
      );
    }

    void onRemove() {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Excluir ${contact.name}?"),
            content: Text(
                'Deseja excluir permanentemente o contato "${contact.name}"?'),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancelar")),
              TextButton(
                  onPressed: () {
                    removeContact(contact.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Contato "${contact.name}" excluído!'),
                      ),
                    );
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: const Text("Confirmar"))
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(contact.name),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                minRadius: 56.0,
                child: Text(
                  contact.name[0],
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      fontSize: 56.0),
                ),
              ),
              Text(
                contact.name,
                style: nameTitleStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 16,
              ),
              contact.number != null
                  ? ListTile(
                      tileColor: Theme.of(context).colorScheme.surfaceContainer,
                      leading: Icon(
                        Icons.phone,
                        color: primaryColor,
                      ),
                      subtitle: const Text("Número"),
                      subtitleTextStyle: contactInfoSubtitleStyle,
                      title: Text(contact.number ?? ""),
                      titleTextStyle: contactInfoTitleStyle)
                  : const SizedBox.shrink(),
              const SizedBox(
                height: 5,
              ),
              contact.email != null
                  ? ListTile(
                      tileColor: Theme.of(context).colorScheme.surfaceContainer,
                      leading: Icon(
                        Icons.email,
                        color: primaryColor,
                      ),
                      subtitle: const Text("Email"),
                      subtitleTextStyle: contactInfoSubtitleStyle,
                      title: Text(contact.email ?? ""),
                      titleTextStyle: contactInfoTitleStyle)
                  : const SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }
}
