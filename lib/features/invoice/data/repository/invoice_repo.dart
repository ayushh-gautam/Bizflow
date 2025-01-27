import 'package:bizflow/features/invoice/data/model/invoice_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InvoiceRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Future createInvoice(Invoice invoice) async {
    try {
      await _firestore
          .collection('invoice')
          .doc()
          .collection('invoices')
          .add(invoice.toMap());
    } catch (e) {
      throw Exception(
        'Failed to add client:$e',
      );
    }
  }
}
