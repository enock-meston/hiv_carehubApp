// lib/screens/appointment_details_screen.dart

import 'package:flutter/material.dart';
import 'package:hiv_carehub/model/appointment_model.dart';

class AppointmentDetailsFragment extends StatelessWidget {
  final AppointmentModel appointment;

  AppointmentDetailsFragment({required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Title: ${appointment.title}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 8),
            Text('Date: ${appointment.createdAt.toLocal().toString().split(' ')[0]}', style: TextStyle(fontSize: 16)), SizedBox(height: 8),
            SizedBox(height: 8),

            Row(
              children: [
                Text('Status: ', style: TextStyle(fontSize: 16),),
                SizedBox(width: 8.0,),
                Text(
                   appointment.status == '0' ? 'Pending' : 'Approved',
                  style: TextStyle(
                    fontSize: 16,
                    color: appointment.status == '0' ? Colors.orange : Colors.green,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(appointment.status == '1' ? 'Date of Treatment : ${appointment.appointmentDate}' : '', style: TextStyle(fontSize: 16),),
          ],
        ),
      ),
    );
  }
}