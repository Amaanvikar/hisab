import "package:flutter/material.dart";

class SiteDetails extends StatelessWidget {
  const SiteDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Site 1',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.grey,
          centerTitle: true),
      body: Column(children: [
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MaterialButton(
              splashColor: Colors.blueGrey,
              onPressed: () {},
              child: const Text(
                'Add Flat',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            MaterialButton(
              splashColor: Colors.blueGrey,
              onPressed: () {},
              child: const Text(
                'Sell Flat',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            MaterialButton(
              splashColor: Colors.blueGrey,
              onPressed: () {},
              child: const Text(
                'Add Transaction',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            MaterialButton(
              splashColor: Colors.blueGrey,
              onPressed: () {},
              child: const Text(
                'Add Partner',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
