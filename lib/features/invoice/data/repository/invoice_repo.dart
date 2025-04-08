import 'package:bizflow/features/invoice/data/model/invoice_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// class InvoiceRepo {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Future<void> addInvoice(Invoice invoice, String userId) async {
//     await _firestore
//         .collection('invoices')
//         .doc(invoice.invoiceId)
//         .set(invoice.toMap());
//   }

//   Future<List<Invoice>> fetchInvoices(String userId) async {
//     final snapshot = await _firestore.collection('invoices').get();
//     return snapshot.docs.map((doc) => Invoice.fromMap(doc.data())).toList();
//   }

//   Future<void> deleteInvoice(String userId, String invoiceId) async {
//     await _firestore.collection('invoices').doc(invoiceId).delete();
//   }

//   Future<void> updateInvoice(Invoice invoice, String userId) async {
//     await _firestore
//         .collection('invoices')
//         .doc(invoice.invoiceId)
//         .update(invoice.toMap());
//   }
// }

class InvoiceRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addInvoice(Invoice invoice, String userId) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('invoices')
          .doc(invoice.invoiceId)
          .set(invoice.toMap());
    } catch (e) {
      throw Exception('Failed to add invoice: $e');
    }
  }

  Future<List<Invoice>> fetchInvoices(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('invoices')
          .get();
      if (snapshot.docs.isEmpty) return [];
      return snapshot.docs.map((doc) => Invoice.fromMap(doc.data())).toList();
    } catch (e) {
      throw Exception('Failed to fetch invoices: $e');
    }
  }
}