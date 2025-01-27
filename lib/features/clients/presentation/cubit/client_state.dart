import 'package:bizflow/features/clients/data/model/client_model.dart';
import 'package:equatable/equatable.dart';

sealed class ClientState extends Equatable {
  const ClientState();

  @override
  List<Object> get props => [];
}

final class ClientInitial extends ClientState {}

final class ClientLoading extends ClientState {}

final class ClientAdded extends ClientState {
  final List<Client> clients;
  const ClientAdded({required this.clients});
}

final class ClientError extends ClientState {
  final String error;
  const ClientError(this.error);
  @override
  List<Object> get props => [error];
}

class ClientDeleted extends ClientState {
  final String message;
  const ClientDeleted(this.message);
}
