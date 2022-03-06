import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:learn_bloc/domain/user/model/user_response.dart';
import 'package:learn_bloc/repositories/profile/profile_repository.dart';

part 'profileb_event.dart';
part 'profileb_state.dart';
part 'profileb_bloc.freezed.dart';

class ProfilebBloc extends Bloc<ProfilebEvent, ProfilebState> {
  final ProfileRepository _profileRepository = ProfileRepository();

  ProfilebBloc() : super(const _Initial()) {
    on<_GetAllUser>((event, emit) async {
      emit(const ProfilebState.isLoading());
      final _result = await _profileRepository.getAllUser();
      _result.fold((l) => emit(ProfilebState.isError(l)),
          (r) => emit(ProfilebState.isSuccess(r)));
    });
  }
}
