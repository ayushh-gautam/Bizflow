import 'package:bizflow/features/clients/data/repository/add_client_repo.dart';
import 'package:bizflow/features/clients/presentation/cubit/client_state.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../data/model/client_model.dart';

class ClientCubit extends Cubit<ClientState> {
  final ClientRepository clientRepository;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<Client> clients = [];
  ClientCubit(this.clientRepository) : super(ClientInitial()) {
    fetchClients();
  }

  // Method to add a new client to the state
  Future<void> addClient(Client client) async {
    emit(ClientLoading());
    try {
      final user = _auth.currentUser;
      if (user == null) {
        emit(ClientError('User not signed in'));
        return;
      }
      await clientRepository.addClient(client, user.uid);
      clients.add(client);
      emit(ClientAdded(clients: clients));
    } catch (e) {
      emit(ClientError(e.toString()));
    }
  }

// Method to fetch the client
  Future<void> fetchClients() async {
    emit(ClientLoading());
    try {
      final user = _auth.currentUser;
      if (user == null) {
        emit(ClientError('User not signed in'));
        return;
      }
      clients = await clientRepository.fetchClient(user.uid);
      emit(ClientAdded(clients: clients));
    } catch (e) {
      emit(ClientError(e.toString()));
    }
  }

  Future<void> deleteClients(String clientId) async {
  //  print('Deleting client:$clientId');
    emit(ClientLoading());
    try {
      final user = _auth.currentUser;
      if (user == null) {
        emit(ClientError('User not signed in'));
        return;
      }
      await clientRepository.deleteClient(user.uid, clientId);
      clients.removeWhere((client) => client.clientId == clientId);
      emit(ClientDeleted('Client deleted succesfully'));
      await fetchClients();
    } catch (e) {
      emit(ClientError('Filed to delete client:$e'));
    }
  }
}
