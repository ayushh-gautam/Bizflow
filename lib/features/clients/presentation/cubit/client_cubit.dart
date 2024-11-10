import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';

part 'client_state.dart';

class ClientCubit extends Cubit<List<Client>> {
  ClientCubit() : super([]);

  void addClient(Client client) {
    emit([...state, client]);
  }
}
