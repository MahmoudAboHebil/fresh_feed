import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_feed/data/repository/cloudinary_repo/cloudinary_repo.dart';

import '../../datasource/cloudinary_ds/cloudinary_ds_provider.dart';

final cloudinaryRepoProvider = Provider<CloudinaryRepository>((ref) {
  final datasource = ref.watch(cloudinaryDSProvider);
  return CloudinaryRepository(datasource);
});
