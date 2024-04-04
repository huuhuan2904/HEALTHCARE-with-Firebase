class MyDoctor {
  final String uid;

  MyDoctor({required this.uid});
}

class DoctorData {
  final String name;
  final String gender;
  final String email;
  final String address;
  final int phoneNumber;
  final DateTime dateOfBirth;
  final List doctorExp;
  final String expNum;
  final String specialty;
  final String doctorAvatar;

  DoctorData(
      {required this.name,
      required this.gender,
      required this.email,
      required this.address,
      required this.phoneNumber,
      required this.dateOfBirth,
      required this.doctorExp,
      required this.expNum,
      required this.specialty,
      required this.doctorAvatar});
}
