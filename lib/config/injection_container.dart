import 'package:assignment/data/model/features/user/data/datasources/user_datasource.dart';
import 'package:assignment/data/model/features/user/presentation/bloc/user_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  getIt.registerFactory(
    () => UserDataSource(),
  );

  getIt.registerLazySingleton<UserBloc>(
    () => UserBloc(),
  );
}
