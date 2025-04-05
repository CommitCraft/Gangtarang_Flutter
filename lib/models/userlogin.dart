class UserLogin {
  final String username;
  final String password;

  UserLogin({
    required this.username,
    required this.password,
  });

  // Convert the object to a Map for the POST body
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }
}
