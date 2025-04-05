class UserRegistration {
  final String username;
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String displayName;

  UserRegistration({
    required this.username,
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.displayName,
  });

  // Convert the object to a Map for the POST body
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password,
      'first_name': firstName,
      'last_name': lastName,
      'display_name': displayName,
    };
  }
}
