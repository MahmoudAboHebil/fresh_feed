import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_feed/data/data.dart';
import 'package:fresh_feed/data/datasource/network_info_ds/network_info_ds_provider.dart';

final networkInfoRepoProvider = Provider((ref) {
  final _ds = ref.read(networkInfoDsProvider);
  final _rep = NetworkInfoRepository(_ds);
  return _rep;
});
