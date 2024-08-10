import 'package:flutter/material.dart';

class HomeFragment extends StatefulWidget {
  const HomeFragment({super.key});

  @override
  State<HomeFragment> createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // Card displaying a big number and an icon
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(16),
                leading: Icon(
                  Icons.accessibility_new, // Replace with appropriate icon
                  size: 50,
                  color: Colors.blue,
                ),
                title: Text(
                  '123', // Replace with the big number you need
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  'Patients', // Replace with appropriate label
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(16),
                leading: Icon(
                  Icons.accessibility_new, // Replace with appropriate icon
                  size: 50,
                  color: Colors.blue,
                ),
                title: Text(
                  '123', // Replace with the big number you need
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  'Patients', // Replace with appropriate label
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(16),
                leading: Icon(
                  Icons.accessibility_new, // Replace with appropriate icon
                  size: 50,
                  color: Colors.blue,
                ),
                title: Text(
                  '123', // Replace with the big number you need
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  'Patients', // Replace with appropriate label
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
