import 'package:flutter/material.dart';

class AddSite extends StatefulWidget {
  const AddSite({super.key});

  @override
  State<AddSite> createState() => _AddSiteState();
}

class _AddSiteState extends State<AddSite> {
  final _site = [];
  final GlobalKey<AnimatedListState> _key = GlobalKey();

  void AddSite() {
    _site.insert(0, "Firm ${_site.length + 1}");
    _key.currentState!.insertItem(
      0,
      duration: const Duration(seconds: 1),
    );
  }

  void _removesite(int index) {
    _key.currentState!.removeItem(
      index,
      (_, animation) {
        return SizeTransition(
          sizeFactor: animation,
          child: const Card(
            margin: EdgeInsets.all(10),
            color: Colors.grey,
            child: ListTile(
              title: Text(
                'Deleted',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        );
      },
      duration: const Duration(milliseconds: 300),
    );
    _site.removeAt(index);
  }

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
                onPressed: AddSite,
                child: const Text(
                  'Add Site',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Expanded(
            child: AnimatedList(
                key: _key,
                initialItemCount: 0,
                padding: const EdgeInsets.all(10),
                itemBuilder: (context, index, animation) {
                  return SizeTransition(
                    sizeFactor: animation,
                    key: UniqueKey(),
                    child: Card(
                      margin: const EdgeInsets.all(10),
                      color: Colors.orangeAccent,
                      child: ListTile(
                        title: Text(
                          _site[index],
                          style: const TextStyle(
                            fontSize: 24,
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            _removesite(index);
                          },
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
