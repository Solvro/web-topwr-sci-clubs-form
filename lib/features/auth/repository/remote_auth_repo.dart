import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../navigation/utils/parse_query.dart';
import '../models/auth_state.dart';

part 'remote_auth_repo.g.dart';

@riverpod
class RemoteAuthRepo extends _$RemoteAuthRepo {
  @override
  Stream<AuthState> build() {
    return FirebaseAuth.instance.authStateChanges().map(
          (user) => user != null
              ? AuthState.logged(user: user)
              : const AuthState.guest(),
        );
  }

  Future<void> loginWithQuery(QueryParams params) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: params.email.trim(),
        password: params.token.trim(),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' ||
          e.code == 'wrong-password' ||
          e.code == "invalid-credential") {
        state = const AsyncData(AuthState.wrong());
      }
    }
  }
}
