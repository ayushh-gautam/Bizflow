// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class Invoice {
  final String fullName;
  final String amount;
  final String projectName;
  final String invoiceId;
  final DateTime issuedDate;
  final DateTime dueDate;

  Invoice({
    required this.fullName,
    required this.amount,
    required this.projectName,
    required this.invoiceId,
    required this.issuedDate,
    required this.dueDate,
  });

  factory Invoice.fromMap(Map<String, dynamic> map) {
    return Invoice(
      fullName: map['fullName'] ?? '',
      amount: map['amount'] ?? '0.00',
      projectName: map['projectName'] ?? '',
      invoiceId: map['invoiceId'] ?? '',
      issuedDate: _parseTimestamp(map['issuedDate']),
      dueDate: _parseTimestamp(map['dueDate']),
    );
  }

  static DateTime _parseTimestamp(dynamic timestamp) {
    if (timestamp == null) return DateTime.now();
    if (timestamp is Timestamp) {
      return timestamp.toDate();
    }
    if (timestamp is DateTime) {
      return timestamp;
    }
    return DateTime.now();
  }

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'amount': amount,
      'projectName': projectName,
      'invoiceId': invoiceId,
      'issuedDate': Timestamp.fromDate(issuedDate),
      'dueDate': Timestamp.fromDate(dueDate),
    };
  }
}
