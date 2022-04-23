import 'package:firebase_auth/firebase_auth.dart';
import 'package:taskio/domain/entities/id.dart';
import 'package:taskio/domain/entities/user.dart';

extension FirebaseUserMapper on User {
  CustomUser toDomain() {
    // Convert User to CustomUser
    return CustomUser(id: UniqueID.fromUniqueString(uid));
  }
}
