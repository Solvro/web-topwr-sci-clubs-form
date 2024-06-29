import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState.guest() = Guest;

  const factory AuthState.wrong() = Wrong;

  const factory AuthState.logged({
    required User user,
  }) = Logged;
}
