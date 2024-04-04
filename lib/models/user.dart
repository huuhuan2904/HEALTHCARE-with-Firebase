class MyUser {
  final String uid;

  MyUser({required this.uid});
}

class UserData {
  final String uid;
  final String name;
  final String gender;
  final String email;
  final String address;
  final int phone_number;
  final DateTime date_of_birth;
  final String user_avatar;

  UserData(
      {required this.uid,
      required this.name,
      required this.gender,
      required this.email,
      required this.address,
      required this.phone_number,
      required this.date_of_birth,
      required this.user_avatar});
}
