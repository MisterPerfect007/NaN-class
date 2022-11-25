import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nan_class/core/package/internet_connection_checker.dart';
import 'package:nan_class/features/home/data/datasources/user_remote_data_source.dart';
import 'package:nan_class/features/loginAndRegister/domain/entity.dart';

import '../../../../core/failure/failures.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) async {
      if(event is GetUser){
        emit(HomeLoading());
        if (await InternetConnection.hasConnection) {
          final failureOrUser = await getUserRemoteDataSource(event.googleUserId);
          failureOrUser.fold(
            (failure) => emit(HomeFailure(failure.error)), 
            (user) => emit(HomeLoaded(user)));
        }else{
          emit(const HomeFailure(UserErrorType.noInternet));
        }
      }
    });
  }
}
