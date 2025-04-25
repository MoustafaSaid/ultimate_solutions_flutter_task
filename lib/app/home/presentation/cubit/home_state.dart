import 'package:equatable/equatable.dart';
import 'package:ultimate_solution_flutter_task/app/home/domain/entities/bill_entity.dart';
import 'package:ultimate_solution_flutter_task/app/home/domain/entities/delivery_status_entity.dart';

enum HomeStatus { initial, loading, loadingMore, success, error, empty }

class HomeState extends Equatable {
  final HomeStatus status;
  final List<BillEntity> bills;
  final List<DeliveryStatusEntity> deliveryStatuses;
  final String errorMessage;
  final bool hasReachedMax;

  const HomeState({
    this.status = HomeStatus.initial,
    this.bills = const [],
    this.deliveryStatuses = const [],
    this.errorMessage = '',
    this.hasReachedMax = false,
  });

  HomeState copyWith({
    HomeStatus? status,
    List<BillEntity>? bills,
    List<DeliveryStatusEntity>? deliveryStatuses,
    String? errorMessage,
    bool? hasReachedMax,
  }) {
    return HomeState(
      status: status ?? this.status,
      bills: bills ?? this.bills,
      deliveryStatuses: deliveryStatuses ?? this.deliveryStatuses,
      errorMessage: errorMessage ?? this.errorMessage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  bool get isInitial => status == HomeStatus.initial;
  bool get isLoading => status == HomeStatus.loading;
  bool get isLoadingMore => status == HomeStatus.loadingMore;
  bool get isSuccess => status == HomeStatus.success;
  bool get isError => status == HomeStatus.error;
  bool get isEmpty => status == HomeStatus.empty;

  @override
  List<Object?> get props => [
        status,
        bills,
        deliveryStatuses,
        errorMessage,
        hasReachedMax,
      ];
}
