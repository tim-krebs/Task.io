import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskio/core/errors/errors.dart';
import 'package:taskio/domain/repositories/auth_repository.dart';
import 'package:taskio/injection.dart';

extension FirestorExt on FirebaseFirestore {
  Future<DocumentReference> userDocument() async {
    final userOption = sl<AuthRepository>().getSignedInUser();
    final user = userOption.getOrElse(() => throw NotAuthenticatedError());

    return FirebaseFirestore.instance.collection("users").doc(user.id.value);
  }
}

extension DocumentReferenceExt on DocumentReference {
  CollectionReference<Map<String, dynamic>> get todoCollection =>
      collection("todos");
}
