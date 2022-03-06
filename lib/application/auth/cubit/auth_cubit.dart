import 'package:bloc/bloc.dart';
import 'package:learn_bloc/domain/auth/model/login_request.dart';
import 'package:learn_bloc/domain/auth/model/login_response.dart';
import 'package:learn_bloc/repositories/auth/auth_repository.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final AuthRepository _authRepository = AuthRepository();

  void loginUser(LoginRequest loginRequest) async {
    emit(AuthLoading());
    try {
      final _data =
          await _authRepository.signInUser(loginRequest: loginRequest);

      _data.fold((l) => emit(AuthError(l)), (r) => emit(AuthSuccess(r)));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
