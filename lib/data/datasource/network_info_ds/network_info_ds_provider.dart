import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_feed/data/data.dart';

final networkInfoDsProvider = Provider((ref) {
  final connectivityPlusService = ConnectivityPlusService();
  final networkInfoDataSource = NetworkInfoDataSource(connectivityPlusService);
  return networkInfoDataSource;
});
