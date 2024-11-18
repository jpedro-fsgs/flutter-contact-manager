import 'package:agenda/models/contact.dart';
import 'package:flutter/material.dart';

class ContactsList extends StatelessWidget {
  const ContactsList({super.key, required this.getContacts});

  final Future<List<Contact>> Function() getContacts;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getContacts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            // return const Center(
            //   child: Icon(Icons.error_outline),
            // );
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outlined,
                    color: Colors.red,
                    size: 54,
                  ),
                  Text("Houve um erro")
                ],
              ),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (context, index) {
              Contact contact = snapshot.data![index];
              return ListTile(
                title: Text(
                  contact.name,
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                tileColor: Theme.of(context).colorScheme.primaryContainer,
              );
            },
          );
        });
  }
}
