import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nan_class/core/package/internet_connection_checker.dart';
import 'package:nan_class/features/home/data/datasources/user_remote_data_source.dart';
import 'package:nan_class/features/loginAndRegister/domain/entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/failure/failures.dart';
import '../../../../core/package/local_storage/keys.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) async {
      //
      final prefs = await SharedPreferences.getInstance();
      //
      if (event is GetUser) {
        emit(HomeLoading());
        if (await InternetConnection.hasConnection) {
          final failureOrUser = await getUserRemoteDataSource();
          failureOrUser.fold((failure) => emit(HomeFailure(failure.error)),
              (user) async {
            emit(HomeLoaded(user));
            //save user speciality to the local storage
            if (user.speciality != null && user.speciality?.name != null) {
              await prefs.setString(userSpecialityKEY, user.speciality!.name!);
            }
          });
        } else {
          emit(const HomeFailure(UserErrorType.noInternet));
        }
      }

      if (event is SetUserLoadedState) {
        emit(HomeLoaded(event.user));
      }
    });

    /* void emitLoaded(User user, Emitter<HomeState> emit){
      emit(HomeLoaded(user));
    } */
  }
}
