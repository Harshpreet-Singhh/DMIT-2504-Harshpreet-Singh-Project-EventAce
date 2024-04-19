import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; 
import 'package:shared_preferences/shared_preferences.dart';

class CreateEventScreen extends StatefulWidget {
  @override
  _CreateEventScreenState createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final _formKey = GlobalKey<FormState>();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  String _eventName = '';
  String _eventLocation = '';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  void _saveForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('event_name', _eventName ?? '');
        await prefs.setString('event_location', _eventLocation ?? '');
        await prefs.setString('event_date', DateFormat('yyyy-MM-dd').format(_selectedDate));
        await prefs.setString('event_time', _selectedTime.format(context));

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Event saved!')),
        );

      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save event: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Event'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Event Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter event name';
                }
                return null;
              },
              onSaved: (value) {
                _eventName = value!;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Event Location'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter event location';
                }
                return null;
              },
              onSaved: (value) {
                _eventLocation = value!;
              },
            ),
            ListTile(
              title: Text('Event Date: ${DateFormat('yyyy-MM-dd').format(_selectedDate)}'),
              trailing: Icon(Icons.calendar_today),
              onTap: () => _selectDate(context),
            ),
            ListTile(
              title: Text('Event Time: ${_selectedTime.format(context)}'),
              trailing: Icon(Icons.access_time),
              onTap: () => _selectTime(context),
            ),
            ElevatedButton(
              onPressed: _saveForm,
              child: Text('Save Event'),
            ),
          ],
        ),
      ),
    );
  }
}
