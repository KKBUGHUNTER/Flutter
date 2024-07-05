import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      databaseURL:
          "https://xyz-default-rtdb.asia-southeast1.firebasedatabase.app/",  //  Add the RTDB Database URL
      apiKey: "xyz",
      authDomain: "xyz.firebaseapp.com",
      projectId: "xyz",
      storageBucket: "xyz.appspot.com",
      messagingSenderId: "xyz",
      appId: "xyz",
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TaskPage(),
    );
  }
}

class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final DatabaseReference ref = FirebaseDatabase.instance.ref('nameList');

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Manager'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _idController,
              decoration: InputDecoration(labelText: 'ID'),
            ),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Your name'),
            ),
            ElevatedButton(
              onPressed: () =>
                  _addData(_idController.text, _nameController.text),
              child: Text('Add Task'),
            ),
            ElevatedButton(
              onPressed: listenForData,
              child: Text('Listen for Data'),
            ),
            ElevatedButton(
              onPressed: readDataOnce,
              child: Text('Read Data Once'),
            ),
            ElevatedButton(
              onPressed: () => _deleteData(_idController.text),
              child: Text('Delete Task'),
            ),
            ElevatedButton(
              onPressed: () =>
                  _updateData(_idController.text, _nameController.text),
              child: Text('Update Task'),
            ),
          ],
        ),
      ),
    );
  }

  void _addData(String id, String name) {
    ref.child(id).set(name);
    _nameController.clear();
    _idController.clear();
  }

  void listenForData() {
    ref.onValue.listen((event) {
      var snapshot = event.snapshot;
      List<dynamic> data = snapshot.value as List<dynamic>;
      print(data);
    }, onError: (Object error) {
      print('Error listening for data: $error');
    });
  }

  Future<void> readDataOnce() async {
    try {
      DataSnapshot snapshot = await ref.get();
      List<dynamic> data = snapshot.value as List<dynamic>;
      print(data);
    } catch (e) {
      print('Error reading data: $e');
    }
  }

  void _updateData(String id, String name) {
    ref.child(id).set(name);
  }

  void _deleteData(String id) {
    print(id);
    ref.child(id).remove();
  }
}
