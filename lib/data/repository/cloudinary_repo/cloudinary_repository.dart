import 'dart:io';

import 'package:fresh_feed/data/datasource/datasource.dart';
import 'package:fresh_feed/utils/utlis.dart';

class CloudinaryRepository {
  final CloudinaryDataSource _dataSource;
  const CloudinaryRepository(this._dataSource);

  Future<String> uploadImage(File imageFile, String imageId) async {
    try {
      return await _dataSource.uploadImage(imageFile, imageId);
    } catch (e) {
      throw FreshFeedException(
        message: 'Oops! Something went wrong. Please try again later',
        methodInFile: 'fetchTopHeadlines()/NewsApiRepository',
        details: e.toString(),
      );
    }
  }
}
