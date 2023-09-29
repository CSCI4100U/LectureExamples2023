import 'package:flutter/material.dart';


class CountryFormScreen extends StatefulWidget {
  @override
  _CountryFormScreenState createState() => _CountryFormScreenState();
}

class _CountryFormScreenState extends State<CountryFormScreen> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _selectedDate;
  String? _selectedCountry;
  bool _isChecked = false;

  final List<String> _countries = ['Canada', 'US', 'Mexico'];

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_selectedCountry == 'Canada') {
        // Return to the previous screen and display the selected information.
        Navigator.pop(context, {
          'Date': _selectedDate,
          'Country': _selectedCountry,
          'Checkbox': _isChecked,
        });
      } else {
        // Display a dialog and go back to the form.
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Alert'),
              content: Text('You selected a country other than Canada.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog.
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Country Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Pick a Date:'),
              InkWell(
                onTap: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );

                  if (pickedDate != null) {
                    setState(() {
                      _selectedDate = pickedDate;
                    });
                  }
                },
                child: InputDecorator(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  child: Text(
                    _selectedDate == null
                        ? 'Select a Date'
                        : '${_selectedDate!.toLocal()}'.split(' ')[0],
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text('Select a Country:'),
              DropdownButtonFormField<String>(
                value: _selectedCountry,
                items: _countries.map((country) {
                  return DropdownMenuItem<String>(
                    value: country,
                    child: Text(country),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCountry = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a country.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              CheckboxListTile(
                title: Text('Check this box for some reason'),
                value: _isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    _isChecked = value ?? false;
                  });
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}