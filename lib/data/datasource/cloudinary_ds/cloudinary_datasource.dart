import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class CloudinaryDataSource {
  final String _cloudName = "dmfes2ffz";
  final String _uploadPreset = "freshFeed";

  Future<String> uploadImage(File imageFile, String imageId) async {
    try {
      final url = "https://api.cloudinary.com/v1_1/$_cloudName/upload";
      final request = http.MultipartRequest("POST", Uri.parse(url))
        ..fields['upload_preset'] = _uploadPreset
        ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.toBytes();
        final responseString = String.fromCharCodes(responseData);
        final jsonData = jsonDecode(responseString);

        final image = jsonData['url'] as String?;
        if (image == null) {
          throw Exception("$response");
        }
        return image;
      } else {
        throw Exception("dd${response.reasonPhrase}");
      }
    } catch (e) {
      print('sssssssssssssssssssss');
      print(e.toString());
      rethrow;
    }
  }
}
/*
class CloudinaryDataSource {
  final String _cloudName = "dmfes2ffz";
  final String _uploadPreset = "fresh_feed_upload";
  final String _apiKey = "944619395678567";
  final String _apiSecret = "kI0FYQ_4uVxqZVNJpEthWn30dF4";

  Future<String> uploadImage(File imageFile, String imageId) async {
    try {
      final String apiUrl =
          "https://api.cloudinary.com/v1_1/$_cloudName/upload";
      print(apiUrl);

      final int timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      final String dataToSign =
          "overwrite=true&public_id=$imageId&timestamp=$timestamp$_apiSecret";
      final String signature = sha1.convert(utf8.encode(dataToSign)).toString();

      final request = http.MultipartRequest("POST", Uri.parse(apiUrl))
        ..fields['api_key'] = _apiKey
        ..fields['timestamp'] = timestamp.toString()
        ..fields['signature'] = signature
        ..fields['public_id'] = imageId
        ..fields['overwrite'] = "true"
        ..fields['upload_preset'] = _uploadPreset
        ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

      final response = await request.send();
      final responseData = await response.stream.bytesToString();
      final jsonData = jsonDecode(responseData);

      if (response.statusCode == 200) {
        final image = jsonData['secure_url'] as String?;
        if (image == null) {
          throw Exception("xxx${response.reasonPhrase}");
        }
        return image;
      } else {
        throw Exception("${response.reasonPhrase}");
      }
    } catch (e) {
      print('sssssssssssssssssssss');
      print(e.toString());
      rethrow;
    }
  }
}

 */
