import 'package:flutter/material.dart';

class AddSite extends StatefulWidget {
  const AddSite({super.key});

  @override
  State<AddSite> createState() => _AddSiteState();
}

class _AddSiteState extends State<AddSite> {
  final GlobalKey<AnimatedListState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Hisab',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.grey,
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MaterialButton(
                splashColor: Colors.blueGrey,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Add Site Details'),
                        content: const Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              decoration:
                                  InputDecoration(labelText: 'Site Name'),
                            ),
                            SizedBox(height: 10),
                            TextField(
                              decoration:
                                  InputDecoration(labelText: 'Location'),
                            ),
                            SizedBox(height: 10),
                            TextField(
                              decoration:
                                  InputDecoration(labelText: 'Description'),
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Close'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Handle your logic here
                            },
                            child: const Text('Save'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Text(
                  'Add Site',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: AddSite()));
