import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:ultimate_solution_flutter_task/app/login/data/models/login_request_model.dart';
import 'package:ultimate_solution_flutter_task/app/login/data/models/login_response_model.dart';

part 'login_api_client.g.dart';

@RestApi()
abstract class LoginApiClient {
  factory LoginApiClient(Dio dio, {String baseUrl}) = _LoginApiClient;

  @POST('/OnyxDeliveryService/Service.svc/CheckDeliveryLogin')
  Future<LoginResponseModel> login(@Body() LoginRequestModel loginRequest);
}
