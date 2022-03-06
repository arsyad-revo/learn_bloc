import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:learn_bloc/domain/auth/model/login_request.dart';
import 'package:learn_bloc/domain/auth/model/login_response.dart';

class AuthRepository {
  final Dio _dio = Dio();

  Future<Either<String, LoginResponse>> signInUser(
      {required LoginRequest? loginRequest}) async {
    Response? _response;
    try {
      _response = await _dio.post("https://reqres.in/api/login",
          data: loginRequest!.toJson());
      return right(LoginResponse.fromJson(_response.data));
    } on DioError catch (e) {
      String? _errorMessage;
      switch (e.type) {
        case DioErrorType.connectTimeout:
          break;
        case DioErrorType.sendTimeout:
          break;
        case DioErrorType.receiveTimeout:
          break;
        case DioErrorType.response:
          _errorMessage = e.response!.data['error'];
          break;
        case DioErrorType.cancel:
          break;
        case DioErrorType.other:
          break;
      }
      return left(_errorMessage!);
    }
  }
}
