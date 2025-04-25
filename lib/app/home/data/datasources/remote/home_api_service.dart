import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:ultimate_solution_flutter_task/app/home/data/models/get_bills_request.dart';
import 'package:ultimate_solution_flutter_task/app/home/data/models/get_bills_response.dart';
import 'package:ultimate_solution_flutter_task/app/home/data/models/get_delivery_statuses_request.dart';
import 'package:ultimate_solution_flutter_task/app/home/data/models/get_delivery_statuses_response.dart';

part 'home_api_service.g.dart';

@RestApi(
    baseUrl: "http://mdev.yemensoft.net:8087/OnyxDeliveryService/Service.svc")
abstract class HomeApiService {
  factory HomeApiService(Dio dio, {String baseUrl}) = _HomeApiService;

  @POST("/GetDeliveryBillsItems")
  Future<GetBillsResponse> getBills(@Body() GetBillsRequest request);

  @POST("/GetDeliveryStatusTypes")
  Future<GetDeliveryStatusesResponse> getDeliveryStatuses(
      @Body() GetDeliveryStatusesRequest request);
}
