import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final List items = [
    {'id': 1, 'taskName': 'gym', 'status': false},
    {'id': 2, 'taskName': 'coding', 'status': false}
  ];
  final List itemm = [
    {'name': 'task1'},
    {'name': 'task2'},
    {'name': 'task3'},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ReorderableListView(
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (newIndex > oldIndex) newIndex--;
            final item = items.removeAt(oldIndex);
            items.insert(newIndex, item);
          });
        },
        children: [
          for (int i = 0; i < items.length; i++)
            ListTile(
              key: Key(items[i]['id'].toString()),
              title: Text(items[i]['taskName']),
            )
        ],
      ),
    );
  }
}
