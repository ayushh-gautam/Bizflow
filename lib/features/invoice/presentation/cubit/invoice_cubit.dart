import 'package:bizflow/features/invoice/data/repository/invoice_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bizflow/features/invoice/data/model/invoice_model.dart';

// States
part 'invoice_state.dart';

// Cubit
class InvoiceCubit extends Cubit<InvoiceState> {
  final InvoiceRepository invoiceRepository;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<Invoice> invoices = [];

  InvoiceCubit(this.invoiceRepository) : super(InvoiceInitial()) {
    fetchInvoices();
  }

  Future<void> addInvoice(Invoice invoice) async {
    emit(InvoiceLoading());
    try {
      final user = _auth.currentUser;
      if (user == null) {
        emit(InvoiceError('User not signed in'));
        return;
      }
      await invoiceRepository.addInvoice(invoice, user.uid);
      invoices.add(invoice);
      emit(InvoiceLoaded(invoices: invoices));
    } catch (e) {
      emit(InvoiceError(e.toString()));
    }
  }

  Future<void> fetchInvoices() async {
    emit(InvoiceLoading());
    try {
      final user = _auth.currentUser;
      if (user == null) {
        emit(InvoiceError('User not signed in'));
        return;
      }
      invoices = await invoiceRepository.fetchInvoices(user.uid);
      emit(InvoiceLoaded(invoices: invoices));
    } catch (e) {
      emit(InvoiceError(e.toString()));
    }
  }
}