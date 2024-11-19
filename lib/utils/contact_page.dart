import 'package:agenda/models/contact.dart';
import 'package:flutter/material.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key, required this.contact});

  final Contact contact;

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
        title: Text(contact.name),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: const [Icon(Icons.edit)],
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
              contact.email != null ?
              ListTile(
                  tileColor: Theme.of(context).colorScheme.surfaceContainer,
                  leading: Icon(
                    Icons.email,
                    color: primaryColor,
                  ),
                  subtitle: const Text("Email"),
                  subtitleTextStyle: contactInfoSubtitleStyle,
                  title: Text(contact.email ?? ""),
                  titleTextStyle: contactInfoTitleStyle) : const SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }
}
