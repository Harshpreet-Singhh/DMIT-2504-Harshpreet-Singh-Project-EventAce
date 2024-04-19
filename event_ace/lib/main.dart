import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/create_event_screen.dart'; // Make sure this import is correct

void main() {
  runApp(EventAceApp());
}

class EventAceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event Ace',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
      routes: {
        '/home': (context) => HomeScreen(),
        '/createEvent': (context) => CreateEventScreen(),  // Ensure this route is defined
      },
      onUnknownRoute: (settings) {
        // This can handle any undefined routes
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: Text('Error'),
            ),
            body: Center(
              child: Text('Page not found'),
            ),
          ),
        );
      },
    );
  }
}
