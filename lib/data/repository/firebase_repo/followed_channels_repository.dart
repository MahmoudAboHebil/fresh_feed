import '../../../utils/app_exception.dart';
import '../../datasource/firebase_ds/firestore_datasource.dart';

class UserFollowedChannelsRepository {
  final FirestoreDatasource _firestoreDS;

  const UserFollowedChannelsRepository(this._firestoreDS);

  // testing toggleUserChannel() is done
  Future<Map<String, Object>> toggleUserChannel(
      String sourceId, String userUid) async {
    try {
      return await _firestoreDS.toggleUserChannel(sourceId, userUid);
    } catch (e) {
      throw FreshFeedException(
        message: 'Oops! An error occurred about saving data. Please try again.',
        methodInFile: 'toggleUserChannel()/UserFollowedChannelsRepository',
        details: e.toString(),
      );
    }
  }

  // testing getUserFollowingChannels() is done
  Future<List<String>> getUserFollowingChannels(String userUid) async {
    try {
      return await _firestoreDS.getUserFollowingChannels(userUid);
    } catch (e) {
      throw FreshFeedException(
        message: 'Oops! failed to get user following Channels ',
        methodInFile:
            'getUserFollowingChannels()/UserFollowedChannelsRepository',
        details: e.toString(),
      );
    }
  }
}
