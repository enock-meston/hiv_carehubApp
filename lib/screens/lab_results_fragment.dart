import 'package:flutter/material.dart';

class LabResultsFragment extends StatefulWidget {
  const LabResultsFragment({super.key});

  @override
  State<LabResultsFragment> createState() => _LabResultsFragmentState();
}

class _LabResultsFragmentState extends State<LabResultsFragment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lab Results'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Patient Name: John Doe',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Patient ID: 123456',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            SizedBox(height: 20),
            Text(
              'Lab Test Results',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  _buildTestResultCard(
                    testName: 'Complete Blood Count (CBC)',
                    result: 'Normal',
                    referenceRange: '4.0 - 5.5 million cells/mcL',
                    comments: 'Everything is normal.',
                  ),
                  // Add more test result cards as needed
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTestResultCard({
    required String testName,
    required String result,
    required String referenceRange,
    required String comments,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              testName,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Result: $result',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 5),
            Text(
              'Reference Range: $referenceRange',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            SizedBox(height: 10),
            Text(
              'Comments:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              comments,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
