// ignore_for_file: public_member_api_docs, sort_constructors_first
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
        amount: map['amount'] ?? '',
        projectName: map['projectName'] ?? '',
        invoiceId: map['invoiceId'] ?? '',
        issuedDate: map['issuedDate'] ?? '',
        dueDate: map['dueDate'] ?? '');
  }

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'amount': amount,
      'projectName': projectName,
      'invoiceId': invoiceId,
      'issuedDate': issuedDate,
      'dueDate': dueDate,
    };
  }
}
