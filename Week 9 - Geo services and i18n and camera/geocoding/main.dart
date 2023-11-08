import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

//Homework - combine this with geolocation to make an app that gets the current
//location and displays all the place details

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Address Information App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AddressForm(),
    );
  }
}

class AddressForm extends StatefulWidget {
  @override
  _AddressFormState createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  final _formKey = GlobalKey<FormState>();
  final _addressController = TextEditingController();
  String _addressInformation = '';

  void _getAddressInformation() async {
    final address = _addressController.text;

    if (address.isEmpty) {
      setState(() {
        _addressInformation = "Please enter an address";
      });
      return;
    }

    try {
      List<Location> locations = await locationFromAddress(address);
      List<Placemark> placemarks = await placemarkFromCoordinates(locations.first.latitude, locations.first.longitude);

      Placemark place = placemarks[0];
      setState(() {
        _addressInformation = place.toString();
        // _addressInformation = '''
        // Street: ${place.street}
        // Locality: ${place.locality}
        // Postal Code: ${place.postalCode}
        // Country: ${place.country}
        // ''';
      });
    } on Exception catch (e) {
      setState(() {
        _addressInformation = 'Failed to get address information: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Address Information App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                  hintText: 'Enter an address',
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an address';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _getAddressInformation();
                    }
                  },
                  child: Text('Get Address Information'),
                ),
              ),
              SelectableText(_addressInformation),
            ],
          ),
        ),
      ),
    );
  }
}
