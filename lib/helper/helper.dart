import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

String formatDate(Timestamp timestamp){

  String sample = "${timestamp.toDate().toLocal().day}/${timestamp.toDate().toLocal().month}/${timestamp.toDate().toLocal().year}, ${DateFormat('h:mm a').format(timestamp.toDate().toLocal())}"; // Replace 'start' with the actual field name

  return sample;
}