part of 'user_bloc.dart';

enum UserStatus { initial, loading, success, failure }

class UserState extends Equatable {
  final UserStatus status;
  final List<User>? user;
  final List<User?> favoriteUser;
  final String? failureMessage;

  const UserState({
    required this.status,
    this.user,
    this.favoriteUser = const [],
    this.failureMessage,
  });

  UserState copyWith({
    UserStatus? status,
    List<User>? user,
    List<User?>? favoriteUser,
    String? failureMessage,
  }) {
    return UserState(
      status: status ?? this.status,
      user: user ?? this.user,
      favoriteUser: favoriteUser ?? this.favoriteUser,
      failureMessage: failureMessage ?? this.failureMessage,
    );
  }

  factory UserState.initial() => const UserState(
        status: UserStatus.initial,
      );
  @override
  List<Object?> get props => [
        status,
        user,
        failureMessage,
        favoriteUser,
      ];
}
