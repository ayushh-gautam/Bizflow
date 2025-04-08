part of 'invoice_cubit.dart';

sealed class InvoiceState extends Equatable {
  const InvoiceState();

  @override
  List<Object> get props => [];
}

final class InvoiceInitial extends InvoiceState {}

final class InvoiceLoading extends InvoiceState {}

final class InvoiceLoaded extends InvoiceState {
  final List<Invoice> invoices;
  const InvoiceLoaded({required this.invoices});

  @override
  List<Object> get props => [invoices];
}

final class InvoiceError extends InvoiceState {
  final String error;
  const InvoiceError(this.error);

  @override
  List<Object> get props => [error];
}