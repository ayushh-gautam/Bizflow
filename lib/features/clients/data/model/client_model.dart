class Client {
  final String clientId;
  final String fullName;
  final String companyName;
  final String email;
  // final List<String> tags;
  final String phoneNumber;
  final String address;

  Client({
    required this.clientId,
    required this.address,
    required this.phoneNumber,
    required this.fullName,
    required this.companyName,
    required this.email,
    // required this.tags,
  });

  factory Client.fromMap(Map<String, dynamic> map) {
    return Client(
      clientId: map['clientId'] ?? '',
      fullName: map['fullName'] ?? '',
      companyName: map['companyName'] ?? '',
      email: map['email'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      address: map['address'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
     ' clientId' : clientId,
      'fullName': fullName,
      'companyName': companyName,
      'email': email,
      'phoneNumber': phoneNumber,
      'address': address,
    };
  }
}
