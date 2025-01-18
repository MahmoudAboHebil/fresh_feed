import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../datasource/firebase_ds/firestor_ds_provider.dart';
import 'followed_channels_repository.dart';

final userFollowedChannelsRepoProvider = Provider((ref) {
  final _firestoreDS = ref.watch(firestorDSProvider);
  return UserFollowedChannelsRepository(_firestoreDS);
});
