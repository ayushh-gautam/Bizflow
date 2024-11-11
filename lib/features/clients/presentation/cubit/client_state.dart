import 'package:equatable/equatable.dart';

sealed class ClientState extends Equatable {
  const ClientState();

  @override
  List<Object> get props => [];
}

final class ClientInitial extends ClientState {}
