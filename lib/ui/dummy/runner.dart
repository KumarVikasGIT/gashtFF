import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Date Range Analysis'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Simulate selecting a date range (adjust as needed)
                startDate = DateTime.now().subtract(Duration(days: 5));
                endDate = DateTime.now();

                // Update the UI based on the selected range
                setState(() {});
              },
              child: const Text('Select Date Range'),
            ),
            const SizedBox(height: 20),
            const Text('Selected Date Range:'),
            Text('Start Date: ${DateFormat('yyyy-MM-dd').format(startDate)}'),
            Text('End Date: ${DateFormat('yyyy-MM-dd').format(endDate)}'),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DateBox(
                  title: 'Daily',
                  isActive: endDate.difference(startDate).inDays <7 ,
                ),
                DateBox(
                  title: 'Weekly',
                  isActive: endDate.difference(startDate).inDays > 7 &&
                      endDate.difference(startDate).inDays <= 30,
                ),
                DateBox(
                  title: 'Monthly',
                  isActive: endDate.difference(startDate).inDays > 30,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DateBox extends StatelessWidget {
  final String title;
  final bool isActive;

  DateBox({required this.title, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isActive ? Colors.green : Colors.grey,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
