import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share/share.dart';

class Refer extends StatefulWidget {
  const Refer({Key? key}) : super(key: key);

  @override
  State<Refer> createState() => _ReferState();
}

class _ReferState extends State<Refer> {
  List<Contact> contacts = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getContactPermission();
  }

  void getContactPermission() async {
    if (await Permission.contacts.isGranted) {
      fetchContacts();
    } else {
      final permissionStatus = await Permission.contacts.request();
      if (permissionStatus.isGranted) {
        fetchContacts();
      } else {
        print('Contacts permission not granted.');
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  void fetchContacts() async {
    final fetchedContacts = await ContactsService.getContacts();
    setState(() {
      contacts = fetchedContacts.toList();
      isLoading = false;
    });

    // Log the contacts in the terminal
    for (final contact in contacts) {
      print('Name: ${contact.displayName}');
      if (contact.phones!.isNotEmpty) {
        print('Phone: ${contact.phones!.first.value}');
      }
      print('-----------------------');
    }
  }

  var size, height, width;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            iconTheme: const IconThemeData(
              color: Colors.black, // change your color here
            ),
            shadowColor: Colors.white,
            backgroundColor: Colors.white,
            floating: true,
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                onPressed: () {
                  // do something
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.black,
                ),
                onPressed: () {
                  // do something
                },
              ),
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  height: height / 4,
                  width: width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("asset/images/refer4.png"),
                          fit: BoxFit.cover)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Invite Friend to Sling Pay",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          '''Invite friends to Sling Pay Rs201 when your
friend sends their first payment. They get Rs21!''',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.blue,
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "See offer",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Username',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Share.share(
                              'check out my website https://example.com');
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blue,
                          ),
                          child: const Text(
                            'Share',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: contacts.length,
                        itemBuilder: (context, index) {
                          final contact = contacts[index];
                          return ListTile(
                            leading: CircleAvatar(
                              child: Text(
                                contact.initials(),
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              backgroundColor: Colors.amber,
                            ),
                            title: Text(contact.displayName ?? ''),
                            subtitle: contact.phones!.isNotEmpty
                                ? Text(contact.phones!.first.value ?? '')
                                : null,
                            trailing: ElevatedButton(
                              onPressed: () {
                                Share.share(
                                    'check out my website https://example.com');
                                Share.share(
                                    'check out my website https://example.com',
                                    subject: 'Look what I made!');
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blue,
                                onPrimary: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                              child: const Text('Invite'),
                            ),
                          );
                        },
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
