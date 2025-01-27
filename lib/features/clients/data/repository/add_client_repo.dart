import 'package:bizflow/features/clients/data/model/client_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ClientRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future addClient(Client client, String userid) async {
    try {
      await _firestore
          .collection('users')
          .doc(userid)
          .collection('clients')
          .doc(client.clientId)
          .set(client.toMap());
    } catch (e) {
      throw Exception(
        'Failed to add client:$e',
      );
    }
  }

  Future<List<Client>> fetchClient(String userid) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(userid)
          .collection('clients')
          .get();
      if (snapshot.docs.isEmpty) return [];
      return snapshot.docs.map((doc) => Client.fromMap(doc.data())).toList();
    } catch (e) {
      throw Exception('Failed to fetch client: $e');
    }
  }

  Future<void> deleteClient(String userid, String clientId) async {
    try {
      await _firestore
          .collection('users')
          .doc(userid)
          .collection('clients')
          .doc(clientId)
          .delete();
    } catch (e) {
      throw Exception('Failed to delete client: $e');
    }
  }
}
