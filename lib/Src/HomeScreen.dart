import 'package:flutter/material.dart';
import 'package:fluttertask/Src/StateListPage.dart';
import 'package:fluttertask/Src/SplashScreen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController nameController = TextEditingController();
  String selectedGender = '';
  String name = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("HomeScreen",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio(
                  value: 'Male',
                  groupValue: selectedGender,
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value.toString();
                    });
                  },
                ),
                Text('Male'),
                Radio(
                  value: 'Female',
                  groupValue: selectedGender,
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value.toString();
                    });
                  },
                ),
                Text('Female'),
              ],
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Perform the submit action
                name = nameController.text;
                print('Name: $name, Gender: $selectedGender');

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StateListPage(userName: name)));
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
