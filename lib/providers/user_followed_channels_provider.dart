import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_feed/data/data.dart';

class UserFollowedChannelsNotifier extends Notifier<List<String>?> {
  @override
  List<String>? build() {
    return null;
  }

  /*
   Errors seniors:
   1. Error in refreshUserFollowedChannels() or loadDataIfStateIsNull()
      1. the state will be null
      2. the toggleUserFollowedChannelsFromDataBase() it will throw an Error
      3. the toggleUserFollowedChannelsFromState() it will do no thing
  2. Error toggleUserFollowedChannelsFromState()
      1. when leaving the channel page we refresh the state without
         showing the error because the update date will get from the DB
      2. at the source page we refresh the state and showing the error
         because we the old data will get from the DB and nothing will change
         due that the toggleUserFollowedChannelsFromDataBase() will not be called


   3. Error in toggleUserFollowedChannelsFromDataBase()
      1. it will throw an error
      2. at user channel Page && the source page  we will make a logic that
         it will refresh the state if this error happen to get the correct data from database
   */

  // testing refreshUserFollowedChannels() is done
  Future<void> refreshUserFollowedChannels(String userUid) async {
    try {
      final followedRepo = ref.read(userFollowedChannelsRepoProvider);
      final newState = await followedRepo.getUserFollowingChannels(userUid);
      state = newState;
      print('refreshUserFollowedChannels --------------->');
    } catch (e) {
      state = null;
      rethrow;
    }
  }

  // testing toggleUserFollowedChannelsFromDataBase() is done
  Future<Map<String, Object>> toggleUserFollowedChannelsFromDataBase(
      String sourceId, String userUid) async {
    try {
      await loadDataIfStateIsNull(userUid);

      final followedRepo = ref.read(userFollowedChannelsRepoProvider);
      final val = await followedRepo.toggleUserChannel(sourceId, userUid);
      print('toggleUser DataBase $sourceId success====================>');
      return val;
    } catch (e) {
      rethrow;
    }
  }

  // testing  toggleUserFollowedChannelsFromState() is done
  void toggleUserFollowedChannelsFromState(
      String sourceId, String userUid, bool add) {
    try {
      if (state == null) return;
      if (!add) {
        //remove
        final updateState = state!.where((sId) => sId != sourceId).toList();
        state = [...updateState];
      } else {
        //add
        if (!state!.contains(sourceId)) {
          state = [...state!, sourceId];
        }
      }
      print('toggleUser $sourceId State success====================>');
      print(state);
    } catch (e) {
      rethrow;
    }
  }

  // testing loadDataIfStateIsNull() is done
  Future<List<String>?> loadDataIfStateIsNull(String? userUid) async {
    try {
      if (userUid != null) {
        if (state == null) {
          await refreshUserFollowedChannels(userUid);
        }
      } else {
        state = null;
      }
      print('FollowedChannels state: $state');
      return state;
    } catch (e) {
      state = null;
      rethrow;
    }
  }
}

final userFollowedChannelsNotifierProvider =
    NotifierProvider<UserFollowedChannelsNotifier, List<String>?>(() {
  return UserFollowedChannelsNotifier();
});
