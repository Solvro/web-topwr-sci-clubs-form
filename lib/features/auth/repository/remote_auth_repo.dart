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

  Future<void> loginWithQuery(QueryParams? params) async {
    if (params == null) {
      state = const AsyncData(AuthState.guest());
    } else {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: params.email.trim(),
          password: params.token.trim(),
        );
      } on FirebaseAuthException {
        state = const AsyncData(AuthState.wrong());
      }
    }
  }
}
