import 'package:assignment/config/injection_container.dart';
import 'package:assignment/data/model/features/user/presentation/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final _userBloc = getIt<UserBloc>();

  @override
  void initState() {
    _userBloc.add(FavUsersFetched());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        centerTitle: true,
      ),
      body: BlocBuilder<UserBloc, UserState>(
        bloc: _userBloc,
        builder: (context, state) {
          if (state.status == UserStatus.success) {
            final favUser = state.favoriteUser;
            return ListView.builder(
                itemCount: favUser.length,
                itemBuilder: (context, index) {
                  final users = favUser[index];
                  return ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: SizedBox(
                        height: 50,
                        width: 50,
                        child: Image.network(
                          users?.avatar ??
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOSIZ6hZseAPKb42yOVWSqt00bWSi8yusbMQ',
                        ),
                      ),
                    ),
                    title: Text(
                      'Name : ${users?.firstName} ${users?.lastName}',
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text('Email : ${users?.email}'),
                  );
                });
          } else {
            return const Text('No favorite user');
          }
        },
      ),
    );
  }
}
