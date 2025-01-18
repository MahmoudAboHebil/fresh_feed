import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_feed/data/data.dart';

class UserFollowedChannelsNotifier extends Notifier<List<String>?> {
  @override
  List<String>? build() {
    return null;
  }

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

  Future<void> toggleUserFollowedChannelsFromState(
      String sourceId, String userUid, bool add) async {
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
      try {
        await refreshUserFollowedChannels(userUid);
      } catch (e) {
        rethrow;
      }
      rethrow;
    }
  }

  Future<void> loadDataIfStateIsNull(String? userUid) async {
    try {
      if (userUid != null) {
        if (state == null) {
          await refreshUserFollowedChannels(userUid);
        }
      } else {
        state = null;
      }
      print('FollowedChannels state: $state');
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
