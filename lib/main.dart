import 'package:flutter/material.dart';

void main() {
  runApp(ContactApp());
}

class ContactApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contact List',
      debugShowCheckedModeBanner: false,
      home: ContactListScreen(),
    );
  }
}

class Contact {
  final String name;
  final String number;

  Contact(this.name, this.number);
}

class ContactListScreen extends StatefulWidget {
  @override
  _ContactListScreenState createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();

  List<Contact> contactList = [];

  void addContact() {
    String name = nameController.text.trim();
    String number = numberController.text.trim();

    if (name.isNotEmpty && number.isNotEmpty) {
      setState(() {
        contactList.add(Contact(name, number));
        nameController.clear();
        numberController.clear();
      });
    }
  }

  void showDeleteConfirmation(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Are you sure for Delete?'),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.cancel, color: Colors.blue),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close dialog
                    },
                  ),
                  SizedBox(width: 20),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.blue),
                    onPressed: () {
                      setState(() {
                        contactList.removeAt(index);
                      });
                      Navigator.of(context).pop(); // Close dialog
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact List'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: numberController,
              decoration: InputDecoration(
                labelText: 'Number',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: addContact,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
              ),
              child: Text('Add'),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: contactList.length,
                itemBuilder: (context, index) {
                  final contact = contactList[index];
                  return GestureDetector(
                    onLongPress: () {
                      showDeleteConfirmation(index);
                    },
                    child: ListTile(
                      leading: Icon(Icons.person),
                      title: Text(
                        contact.name,
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(contact.number),
                      trailing: Icon(Icons.call, color: Colors.blue),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
