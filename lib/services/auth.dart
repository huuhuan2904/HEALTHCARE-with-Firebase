import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/models/doctor.dart';
import 'package:project/models/user.dart';
import 'database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  MyUser? _userFromFirebaseUser(User user) {
    return user != null ? MyUser(uid: user.uid) : null;
  }

  Stream<MyUser?> get user {
    return _auth
        .authStateChanges()
        .map((User? user) => _userFromFirebaseUser(user!));
  }

  //sign in with email & password
  Future signInEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future registerWithEmailAndPassword(
      String email,
      String password,
      String name,
      String gender,
      int phone,
      String address,
      DateTime date,
      String avatar) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      DatabaseService(uid: user!.uid)
          .updateUserData(name, gender, email, address, phone, date, avatar);
      DatabaseService(uid: user.uid).nestedCollections();
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOutAnon() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

//-------------------------DOCTOR------------------------
class AuthServiceDoctor {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  MyDoctor? _doctorFromFirebaseDoctor(User user) {
    return user != null ? MyDoctor(uid: user.uid) : null;
  }

  Stream<MyDoctor?> get doctor {
    return _auth
        .authStateChanges()
        .map((User? user) => _doctorFromFirebaseDoctor(user!));
  }

  Future signInEmailAndPasswordDoctor(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? doctor = result.user;
      return _doctorFromFirebaseDoctor(doctor!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future registerWithEmailAndPasswordDoctor(
      String email,
      String password,
      String name,
      String gender,
      int phone,
      String address,
      DateTime date,
      String avatar) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? doctor = result.user;

      DatabaseServiceDoctor(uid: doctor!.uid).updateDoctorData(
          name, gender, email, address, phone, date, [], '', '', avatar);
      // DatabaseServiceDoctor(uid: doctor.uid).nestedCollections();
      // DatabaseServiceDoctor(uid: doctor.uid).arrayExp();
      return _doctorFromFirebaseDoctor(doctor);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOutAnon() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
