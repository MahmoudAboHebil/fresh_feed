import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'cloudinary_datasource.dart';

final cloudinaryDSProvider = Provider((ref) {
  return CloudinaryDataSource();
});
