import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/model/invoice_model.dart';

part 'invoice_state.dart';

class InvoiceCubit extends Cubit<List<Invoice>> {
  InvoiceCubit() : super([]);

  void addInvoice(Invoice invoice) {
    emit([...state, invoice]);
  }
}
