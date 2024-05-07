import 'package:bloc/bloc.dart';
import 'package:blocapp/data/datasources/items_remote_datasource.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitialState()) {
    on<LoginChecking>((event, emit) async {
      emit(LoginCheckingState());
      ItemsRemoteDataSourceImp data = ItemsRemoteDataSourceImp();
      final resp = await data.checklogin(event.user, event.pass);

      if (resp.statusCode == 200) {
        emit(LoginSuccessState());
      } else {
        emit(LoginErrorState(error: ''));
      }
    });
    on<LoginSuccess>((event, emit) => emit(LoginSuccessState()));
  }
}
