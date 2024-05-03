import 'package:assignment/config/injection_container.dart';
import 'package:assignment/config/shared_prefs.dart';
import 'package:assignment/data/model/features/user/data/models/user.dart';
import 'package:assignment/data/model/features/user/presentation/bloc/user_bloc.dart';
import 'package:assignment/data/model/features/user/presentation/pages/favorite_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final _userBloc = getIt<UserBloc>();

  @override
  void initState() {
    _userBloc.add(GetUserEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => const FavoriteScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.favorite,
              color: Colors.red,
            ),
          )
        ],
        title: const Text('User Details'),
        centerTitle: true,
      ),
      body: BlocBuilder<UserBloc, UserState>(
        bloc: _userBloc,
        builder: (context, state) {
          if (state.status == UserStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.status == UserStatus.failure) {
            return AlertDialog(
              title: Text(state.failureMessage ?? ''),
            );
          } else if (state.status == UserStatus.success) {
            final userDetails = state.user ?? [];
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              child: ListView.builder(
                itemCount: userDetails.length,
                itemBuilder: (context, index) {
                  final user = userDetails[index];

                  return Card(
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: Image.network(user.avatar),
                        ),
                      ),
                      title: Text(
                        'Name : ${user.firstName} ${user.lastName}',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text('Email : ${user.email}'),
                      trailing: IconButton(
                        icon: SharedPrefs.getUsers().contains(user)
                            ? const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              )
                            : const Icon(
                                Icons.favorite_border,
                              ),
                        onPressed: () {
                          _userBloc.add(
                            AddToFavorite(
                              user: User(
                                id: user.id,
                                email: user.email,
                                firstName: user.firstName,
                                lastName: user.lastName,
                                avatar: user.avatar,
                              ),
                              index: index,
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
