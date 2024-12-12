import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../domain/model/sales.dart';
import '../../../../../domain/repository/admin_repository.dart';

part 'admin_get_analytics_state.dart';

@Injectable()
class AdminGetAnalyticsCubit extends Cubit<AdminGetAnalyticsState> {
  final AdminRepository _adminRepository;
  AdminGetAnalyticsCubit(this._adminRepository)
      : super(AdminGetAnalyticsLoadingS());

  Future<void> adminGetAnalytics() async {
    try {
      Map<String, dynamic> earnings = {};
      List<ColumnSeries<Sales, String>> seriesData;

      emit(AdminGetAnalyticsLoadingS());

      final either = await _adminRepository.adminGetAnalytics();
      either.fold((l) {

      },(r) {
        earnings = r;
      },);

      seriesData = [
        ColumnSeries<Sales, String>(
          dataSource: earnings['sales'],
          xValueMapper: (Sales data, _) => data.label,
          yValueMapper: (Sales data, _) => data.earning,
          pointColorMapper: (Sales data, _) => data.pointColor,
          dataLabelSettings: const DataLabelSettings(isVisible: true),
        )
      ];

      emit(AdminGetAnalyticsSuccessS(
          sales: earnings['sales'],
          totalEarnings: earnings['totalEarnings'],
          seriesData: seriesData));
    } catch (e) {
      emit(AdminGetAnalyticsErrorS(errorString: e.toString()));
    }
  }
}
