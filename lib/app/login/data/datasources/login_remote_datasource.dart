// import 'package:dio/dio.dart';
// import 'package:ultimate_solution_flutter_task/app/login/data/datasources/login_api_client.dart';
// import 'package:ultimate_solution_flutter_task/app/login/data/models/login_request_model.dart';
// import 'package:ultimate_solution_flutter_task/app/login/data/models/login_response_model.dart';
//
// abstract class LoginRemoteDataSource {
//   Future<LoginResponseModel> login({
//     required String deliveryNo,
//     required String password,
//     String languageNo = "2",
//   });
// }
//
// class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
//   final Dio dio;
//   late final LoginApiClient _apiClient;
//
//   LoginRemoteDataSourceImpl({required this.dio}) {
//     _apiClient = LoginApiClient(dio);
//   }
//
//   @override
//   Future<LoginResponseModel> login({
//     required String deliveryNo,
//     required String password,
//     String languageNo = "2",
//   }) async {
//     final request = LoginRequestModel.create(
//       languageNo: languageNo,
//       deliveryNo: deliveryNo,
//       password: password,
//     );
//
//     try {
//       final response = await _apiClient.login(request);
//       return response;
//     } catch (e) {
//       rethrow;
//     }
//   }
// }
