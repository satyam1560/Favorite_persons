import 'package:assignment/config/shared_prefs.dart';
import 'package:assignment/data/model/features/user/data/datasources/user_datasource.dart';
import 'package:assignment/data/model/features/user/data/models/user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserState.initial()) {
    UserDataSource userDataSource = UserDataSource();
    on<UserEvent>((event, emit) async {
      emit(state.copyWith(status: UserStatus.loading));
      try {
        final userData = await userDataSource.getUserDetails();
        debugPrint('Users $userData');
        emit(state.copyWith(status: UserStatus.success, user: userData));
      } catch (error) {
        emit(state.copyWith(
            status: UserStatus.failure, failureMessage: error.toString()));
      }
    });

    on<AddToFavorite>((event, emit) async {
      final favUsers = SharedPrefs.getUsers();
      if (!favUsers.contains(event.user)) {
        await SharedPrefs.addUsers(user: event.user);
      } else {
        await SharedPrefs.removeUsers(user: event.user);
      }

      emit(
        state.copyWith(
          status: UserStatus.success,
          favoriteUser: SharedPrefs.getUsers(),
        ),
      );
    });

    on<FavUsersFetched>(
      (event, emit) {
        emit(
          state.copyWith(
            status: UserStatus.loading,
          ),
        );
        final users = SharedPrefs.getUsers();

        emit(
          state.copyWith(
            status: UserStatus.success,
            favoriteUser: users,
          ),
        );
      },
    );
  }
}
