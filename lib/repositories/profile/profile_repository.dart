import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:learn_bloc/domain/user/model/user_response.dart';

class ProfileRepository {
  final Dio _dio = Dio();

  Future<Either<String, UserResponse>> getAllUser() async {
    Response? _response;
    try {
      _response = await _dio.get("https://reqres.in/api/users?page=2");
      return right(UserResponse.fromJson(_response.data));
    } on DioError catch (e) {
      String? _errorMessage = '';
      switch (e.type) {
        case DioErrorType.connectTimeout:
          break;
        case DioErrorType.sendTimeout:
          break;
        case DioErrorType.receiveTimeout:
          break;
        case DioErrorType.response:
          break;
        case DioErrorType.cancel:
          break;
        case DioErrorType.other:
          break;
      }
      return left(_errorMessage);
    }
  }
}
