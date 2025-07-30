class UserModel {
  late String id;
  late String email;
  late String firstName;
  late String lastName;
  late String mobile;
  String? photo;

  String get fullName {
    return '$firstName $lastName';
  }

  UserModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.mobile,
    this.photo,
  });

  UserModel.fromJson(Map<String, dynamic> jsonData) {
    id = jsonData['_id']?.toString() ?? '';
    email = jsonData['email']?.toString() ?? '';
    firstName = jsonData['firstName']?.toString() ?? '';
    lastName = jsonData['lastName']?.toString() ?? '';
    mobile = jsonData['mobile']?.toString() ?? '';
    photo = jsonData['photo']?.toString();
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'mobile': mobile,
      'photo': photo,
    };
  }
}
