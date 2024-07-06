// import 'package:flutter/material.dart';

// class AddFirm extends StatefulWidget {
//   const AddFirm({super.key});

//   @override
//   State<AddFirm> createState() => _AddFirmState();
// }

// class _AddFirmState extends State<AddFirm> {
//   final _firm = [];
//   final GlobalKey<AnimatedListState> _key = GlobalKey();

//   void AddFirm() {
//     _firm.insert(0, "Firm ${_firm.length + 1}");
//     _key.currentState!.insertItem(
//       0,
//       duration: const Duration(seconds: 1),
//     );
//   }

//   void _removeFirm(int index) {
//     _key.currentState!.removeItem(
//       index,
//       (_, animation) {
//         return SizeTransition(
//           sizeFactor: animation,
//           child: const Card(
//             margin: EdgeInsets.all(10),
//             color: Colors.grey,
//             child: ListTile(
//               title: Text(
//                 'Deleted',
//                 style: TextStyle(fontSize: 18),
//               ),
//             ),
//           ),
//         );
//       },
//       duration: const Duration(milliseconds: 300),
//     );
//     _firm.removeAt(index);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Hisab',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: Colors.grey,
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           const SizedBox(height: 10),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               MaterialButton(
//                 splashColor: Colors.blueGrey,
//                 onPressed: AddFirm,
//                 child: const Text(
//                   'Add Firm',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ],
//           ),
//           Expanded(
//             child: AnimatedList(
//                 key: _key,
//                 initialItemCount: 0,
//                 padding: const EdgeInsets.all(10),
//                 itemBuilder: (context, index, animation) {
//                   return SizeTransition(
//                     sizeFactor: animation,
//                     key: UniqueKey(),
//                     child: Card(
//                       margin: const EdgeInsets.all(10),
//                       color: Colors.orangeAccent,
//                       child: ListTile(
//                         title: Text(
//                           _firm[index],
//                           style: const TextStyle(
//                             fontSize: 24,
//                           ),
//                         ),
//                         trailing: IconButton(
//                           icon: const Icon(Icons.delete),
//                           onPressed: () {
//                             _removeFirm(index);
//                           },
//                         ),
//                       ),
//                     ),
//                   );
//                 }),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AddFirm extends StatefulWidget {
  const AddFirm({super.key});

  @override
  State<AddFirm> createState() => _AddFirmState();
}

class _AddFirmState extends State<AddFirm> {
  final List<String> _firms = [];
  final List<TextEditingController> _controllers = [];
  final GlobalKey<AnimatedListState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    _loadFirms();
  }

  Future<void> _loadFirms() async {
    final prefs = await SharedPreferences.getInstance();
    final String? firmsString = prefs.getString('firms');
    if (firmsString != null) {
      final List<String> loadedFirms =
          List<String>.from(json.decode(firmsString));
      setState(() {
        _firms.addAll(loadedFirms);
        _controllers.addAll(loadedFirms
            .map((firm) => TextEditingController(text: firm))
            .toList());
      });
      for (int i = 0; i < loadedFirms.length; i++) {
        _key.currentState?.insertItem(i);
      }
    }
  }

  Future<void> _saveFirms() async {
    final prefs = await SharedPreferences.getInstance();
    final String firmsString = json.encode(_firms);
    await prefs.setString('firms', firmsString);
  }

  void _addFirm() {
    setState(() {
      _firms.insert(0, "Firm ${_firms.length + 1}");
      _controllers.insert(
          0, TextEditingController(text: "Firm ${_firms.length}"));
      _key.currentState?.insertItem(0, duration: const Duration(seconds: 1));
      _saveFirms();
    });
  }

  void _removeFirm(int index) {
    setState(() {
      _key.currentState?.removeItem(
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
      _firms.removeAt(index);
      _controllers.removeAt(index);
      _saveFirms();
    });
  }

  void _onFirmChanged(int index, String newFirm) {
    setState(() {
      _firms[index] = newFirm;
      _saveFirms();
    });
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
                onPressed: _addFirm,
                child: const Text(
                  'Add Firm',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Expanded(
            child: AnimatedList(
              key: _key,
              initialItemCount: _firms.length,
              padding: const EdgeInsets.all(10),
              itemBuilder: (context, index, animation) {
                return SizeTransition(
                  sizeFactor: animation,
                  key: UniqueKey(),
                  child: InkWell(
                    onTap: () {
                      // Handle item click
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Clicked on ${_firms[index]}')),
                      );
                    },
                    child: Card(
                      margin: const EdgeInsets.all(10),
                      color: Colors.orangeAccent,
                      child: ListTile(
                        title: TextField(
                          controller: _controllers[index],
                          onChanged: (value) {
                            _onFirmChanged(index, value);
                          },
                          style: const TextStyle(
                            fontSize: 24,
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            _removeFirm(index);
                          },
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: AddFirm(),
  ));
}
