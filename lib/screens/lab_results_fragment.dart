import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiv_carehub/controller/result_controller.dart';

class LabResultsFragment extends StatefulWidget {
  const LabResultsFragment({super.key});

  @override
  State<LabResultsFragment> createState() => _LabResultsFragmentState();
}

class _LabResultsFragmentState extends State<LabResultsFragment> {
  final ResultController resultController = Get.put(ResultController());

  @override
  void initState() {
    super.initState();
    resultController.fetchResults();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lab Results'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (resultController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          } else if (resultController.errorMessage.isNotEmpty) {
            return Center(child: Text(resultController.errorMessage.value));
          } else if (resultController.results.isEmpty) {
            return Center(child: Text('No results available.'));
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(
                  'Lab Test Results',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: resultController.results.length,
                    itemBuilder: (context, index) {
                      final result = resultController.results[index];
                      return _buildTestResultCard(
                        testName: 'Lab Test', // Customize if needed
                        result: result.result,
                        referenceRange: result.referenceRange,
                        comments: result.comments,
                      );
                    },
                  ),
                ),
              ],
            );
          }
        }),
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
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
