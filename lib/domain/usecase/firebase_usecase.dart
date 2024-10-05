import 'package:agendamento_pet/data/repository/firebase_repository.dart';
import 'package:agendamento_pet/domain/model/usuario.dart';
import 'package:injectable/injectable.dart';

abstract class FirebaseUsecase {
  Future<void> registerUser(Usuario usuario);
  Future<void> updatePassword(String newPassword);
  Future<Usuario?> getUserDetails(String userId);
  Future<void> updateUserDetails(Usuario usuario);
}

@Injectable(as: FirebaseUsecase)
class FirebaseUsecaseImpl implements FirebaseUsecase {
  final FirestoreRepository firestoreRepository;

  FirebaseUsecaseImpl(this.firestoreRepository);

  @override
  Future<void> registerUser(Usuario usuario) async {
    try {
      await firestoreRepository.addUser(usuario);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updatePassword(String newPassword) async {
    try {
      await firestoreRepository.changePassword(newPassword);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Usuario?> getUserDetails(String userId) async {
    try {
      return await firestoreRepository.getUserDetails(userId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateUserDetails(Usuario usuario) async {
    try {
      await firestoreRepository.updateUserDetails(usuario);
    } catch (e) {
      rethrow;
    }
  }
}
