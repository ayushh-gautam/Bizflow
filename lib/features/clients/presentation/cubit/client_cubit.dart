import 'package:bloc/bloc.dart';

import '../../data/model/client_model.dart';

class ClientCubit extends Cubit<List<Client>> {
  ClientCubit() : super([]);

  // Method to add a new client to the state
  void addClient(Client client) {
    emit([...state, client]);
  }
}
