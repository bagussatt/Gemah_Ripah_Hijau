import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

enum PickupStatus {
  InProcess,
  Collected,
}

class DetailPickups extends StatefulWidget {
  final int pickupId;

  DetailPickups({required this.pickupId});

  @override
  _DetailPickupsState createState() => _DetailPickupsState();
}

class _DetailPickupsState extends State<DetailPickups> {
  String? status;
  String? catatan;
  String? waktu;
  String? lokasi;
  TextEditingController catatanController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchPickupDetail();
  }

  Future<void> _fetchPickupDetail() async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:3000/pickups/${widget.pickupId}'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final pickup = json.decode(response.body);
      setState(() {
        status = pickup['status'];
        catatan = pickup['catatan'];
        waktu = pickup['waktu'];
        lokasi = pickup['lokasi'];
        catatanController.text = catatan!;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch pickup details')),
      );
    }
  }

  Future<void> _updatePickupStatus(PickupStatus newStatus) async {
    final response = await http.put(
      Uri.parse('http://10.0.2.2:3000/pickups/update/${widget.pickupId}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'status': newStatus.toString().split('.').last,
        'catatan': catatanController.text,
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Pickup status updated successfully')),
      );
      setState(() {
        status = newStatus.toString().split('.').last;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update pickup status')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pickup Detail'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Status',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            DropdownButton<String>(
              value: status,
              onChanged: (newValue) {
                setState(() {
                  status = newValue;
                });
              },
              items: <String>['In Process', 'Collected']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 16.0),
            Text(
              'Catatan',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            TextFormField(
              controller: catatanController,
              decoration: InputDecoration(
                hintText: 'Enter notes',
                border: OutlineInputBorder(),
              ),
              maxLines: null,
              onChanged: (value) {
                setState(() {
                  catatan = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            if (waktu != null && lokasi != null) ...[
              Text(
                'Waktu',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(waktu!),
              SizedBox(height: 16.0),
              Text(
                'Lokasi',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text('$lokasi'),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () =>
                        _updatePickupStatus(PickupStatus.InProcess),
                    child: Text('Tolak Penjemputan'),
                  ),
                  ElevatedButton(
                    onPressed: () =>
                        _updatePickupStatus(PickupStatus.Collected),
                    child: Text('Setujui Penjemputan'),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
