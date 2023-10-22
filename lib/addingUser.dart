import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final CollectionReference _users =
      FirebaseFirestore.instance.collection("users");
  final TextEditingController _fnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _site_da_webController = TextEditingController();
  final TextEditingController _lnameController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();
  final TextEditingController _workController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _fnameController.text = documentSnapshot['first_name'];
      _site_da_webController.text = documentSnapshot['site da web'].toString();
      _telephoneController.text = documentSnapshot['telephone'].toString();
      _lnameController.text = documentSnapshot['last_name'];
      _workController.text = documentSnapshot['work'].toString();
      _emailController.text = documentSnapshot['email'].toString();
    }
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                right: 20,
                left: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    "Update your item",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                TextField(
                  controller: _fnameController,
                  decoration: const InputDecoration(
                      labelText: 'First Name', hintText: 'eg.Elon'),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: _lnameController,
                  decoration: const InputDecoration(
                      labelText: 'Last Name', hintText: 'eg.1'),
                ),
                TextField(
                  controller: _site_da_webController,
                  decoration: const InputDecoration(
                      labelText: 'site da work', hintText: 'eg.Elon'),
                ),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                      labelText: 'email', hintText: 'eg.Elon'),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: _telephoneController,
                  decoration: const InputDecoration(
                      labelText: 'Tele', hintText: 'eg.1'),
                ),
                TextField(
                  keyboardType: TextInputType.text,
                  controller: _workController,
                  decoration: const InputDecoration(
                      labelText: 'wORK', hintText: 'eg.10'),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () async {
                      final String first_name = _fnameController.text;
                      final String work = _workController.text;
                      final String site_da_web = _site_da_webController.text;
                      final String email = _emailController.text;
                      final String last_name = _lnameController.text;
                      // final int? sn = int.tryParse(_snController.text);
                      final int? telephone =
                          int.tryParse(_telephoneController.text);
                      if (first_name != null) {
                        await _users.doc(documentSnapshot!.id).update({
                          "email": email,
                          "first_name": first_name,
                          "last_name": last_name,
                          "telephone": telephone,
                          "site da web": site_da_web,
                          "work": work
                        });
                        _fnameController.text = '';
                        _workController.text = '';
                        _emailController.text = '';
                        _telephoneController.text = '';
                        _site_da_webController.text = '';
                        _lnameController.text = '';
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text("Update"))
              ],
            ),
          );
        });
  }

  Future<void> _delete(String productID) async {
    await _users.doc(productID).delete();

    // for snackBar
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("You have successfully deleted a itmes")));
  }

  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 10
                // MediaQuery.of(ctx).viewInsets.bottom + 20
                ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    "Create your item",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                TextField(
                  controller: _fnameController,
                  decoration: const InputDecoration(
                      labelText: 'First Name', hintText: 'eg.Elon'),
                ),
                TextField(
                  controller: _lnameController,
                  decoration: const InputDecoration(
                      labelText: 'Last Name', hintText: 'eg.Elon'),
                ),
                TextField(
                  controller: _site_da_webController,
                  decoration: const InputDecoration(
                      labelText: 'site da work', hintText: 'eg.Elon'),
                ),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                      labelText: 'email', hintText: 'eg.Elon'),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: _telephoneController,
                  decoration: const InputDecoration(
                      labelText: 'Tele', hintText: 'eg.1'),
                ),
                TextField(
                  keyboardType: TextInputType.text,
                  controller: _workController,
                  decoration: const InputDecoration(
                      labelText: 'wORK', hintText: 'eg.10'),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () async {
                      final String first_name = _fnameController.text;
                      final String work = _workController.text;
                      final String site_da_web = _site_da_webController.text;
                      final String email = _emailController.text;
                      final String last_name = _lnameController.text;
                      // final int? sn = int.tryParse(_snController.text);
                      final int? telephone =
                          int.tryParse(_telephoneController.text);

                      await _users.add({
                        "email": email,
                        "first_name": first_name,
                        "last_name": last_name,
                        "telephone": telephone,
                        "site da web": site_da_web,
                        "work": work
                      });
                      _fnameController.text = '';
                      _workController.text = '';
                      _emailController.text = '';
                      _telephoneController.text = '';
                      _site_da_webController.text = '';
                      _lnameController.text = '';

                      Navigator.of(context).pop();
                    },
                    child: const Text("Create"))
              ],
            ),
          );
        });
  }

  void _onSearchChanged(String value) {
    setState(() {
      searchText = value;
    });
  }

  String searchText = '';

  bool isSearchClicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: isSearchClicked
            ? Container(
                height: 40,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 95, 226, 77),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: _onSearchChanged,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(16, 20, 16, 12),
                      hintStyle: TextStyle(color: Colors.black),
                      border: InputBorder.none,
                      hintText: 'Search..'),
                ),
              )
            : const Text('contacts'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isSearchClicked = !isSearchClicked;
                });
              },
              icon: Icon(isSearchClicked ? Icons.close : Icons.search))
        ],
      ),

      body: StreamBuilder(
        stream: _users.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            final List<DocumentSnapshot> Users = streamSnapshot.data!.docs
                .where((doc) => doc['first_name'].toLowerCase().contains(
                      searchText.toLowerCase(),
                    ))
                .toList();
            return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
                  return Card(
                    color: Color.fromARGB(255, 165, 178, 194),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 17,
                        backgroundColor: Color.fromARGB(255, 86, 28, 222),
                        child: Text(
                          documentSnapshot['first_name']
                              .toString()
                              .substring(0, 1),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                      title: Text(
                        documentSnapshot['first_name'],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      subtitle: Text(documentSnapshot['last_name'].toString()),
                      trailing: SizedBox(
                        width: 150,
                        child: Row(
                          children: [
                            ElevatedButton(
                                onPressed: () => _update(documentSnapshot),
                                child: Text("Edit")),
                            // IconButton(
                            //     color: Colors.black,
                            //     onPressed: () => _update(documentSnapshot),
                            //     icon: const Icon(Icons.edit)),
                            SizedBox(
                              width: 5,
                            ),
                            ElevatedButton(
                                onPressed: () => _delete(documentSnapshot.id),
                                child: Text("Delete"))
                            // IconButton(
                            //     color: Colors.black,
                            //     onPressed: () => _delete(documentSnapshot.id),
                            //     icon: const Icon(Icons.delete)),
                            // IconButton(
                            //     color: Colors.black,
                            //     onPressed: () => _update(documentSnapshot),
                            //     icon: const Icon(Icons.edit)),
                            // IconButton(
                            //     color: Colors.black,
                            //     onPressed: () => _delete(documentSnapshot.id),
                            //     icon: const Icon(Icons.delete)),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      // Create new project button
      floatingActionButton: FloatingActionButton(
        onPressed: () => _create(),
        backgroundColor: const Color.fromARGB(255, 88, 136, 190),
        child: const Icon(Icons.add),
      ),
    );
  }
}
