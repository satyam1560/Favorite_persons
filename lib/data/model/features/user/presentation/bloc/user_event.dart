part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class GetUserEvent extends UserEvent {}

class AddToFavorite extends UserEvent {
  final User user;
  final int index;
  const AddToFavorite({
    required this.user,
    required this.index,
  });
  @override
  List<Object?> get props => [user, index];
}

class FavUsersFetched extends UserEvent {}
