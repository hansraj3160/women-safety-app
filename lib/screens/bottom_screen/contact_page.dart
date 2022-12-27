import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:women_safety_app/utils/constant.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  List<Contact> contacts = [];
  Future<void> askPermissions() async {
    PermissionStatus permissionStatus = await getContactPermissions();
    if (permissionStatus == PermissionStatus.granted) {
      getAllContact();
    } else {
      handInvaliedPermissions(permissionStatus);
    }
  }

  handInvaliedPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      dialogue(context, "Access to the contacts denied by the user");
    } else {
      dialogue(context, "May contact does exist in this device");
    }
  }

  Future<PermissionStatus> getContactPermissions() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  getAllContact() async {
    List<Contact> _contacts = await ContactsService.getContacts();
    setState(() {
      contacts = _contacts;
    });
  }

  @override
  void initState() {
    askPermissions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: contacts.isEmpty
          ? const CircularProgressIndicator()
          : ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (BuildContext context, int index) {
                Contact contact = contacts[index];
                return ListTile(
                  title: Text(contact.displayName!),
                  subtitle: Text(contact.phones!.elementAt(index).value!),
                  leading: contact.avatar != null && contact.avatar!.isNotEmpty
                      ? CircleAvatar(
                          backgroundImage: MemoryImage(contact.avatar!),
                        )
                      : CircleAvatar(
                          backgroundColor: primaryColor,
                          child: Text(contact.initials()),
                        ),
                );
              }),
    );
  }
}
