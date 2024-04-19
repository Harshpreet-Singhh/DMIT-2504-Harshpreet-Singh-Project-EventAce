import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Ace'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min, // To center the content vertically
          children: <Widget>[
            Text('Welcome to Event Ace! Start planning your events.'),
            SizedBox(height: 20), // Provide some spacing between the text and the button
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/createEvent'); // Replace with the actual route to the event creation screen
              },
              child: Text('Add New Event'),
            ),
          ],
        ),
      ),
    );
  }
}
