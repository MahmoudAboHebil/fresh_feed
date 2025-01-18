import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_feed/providers/providers.dart';
import 'package:fresh_feed/utils/utlis.dart';

//ToDo: flashing image when toggle
//ToDo: validate the source images
//ToDo: testing on failure cases (done)
//ToDo: reTesting articlesView && userBookmarks

class FollowedChannelsPage extends ConsumerStatefulWidget {
  const FollowedChannelsPage({required this.userUid, super.key});
  final String userUid;

  @override
  ConsumerState<FollowedChannelsPage> createState() =>
      _FollowedChannelsPageState();
}

class _FollowedChannelsPageState extends ConsumerState<FollowedChannelsPage> {
  List<Map<String, Object>> modifiedStateList = [];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        await ref
            .read(userFollowedChannelsNotifierProvider.notifier)
            .loadDataIfStateIsNull(widget.userUid);
      } catch (e) {
        print(e);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final userFollowedChannelsProv =
        ref.read(userFollowedChannelsNotifierProvider.notifier);
    final userFollowedChannelsState =
        ref.watch(userFollowedChannelsNotifierProvider);

    ref.listen(userListenerProvider, (prev, now) async {
      print(
          'userListenerProvider (FollowedChannelsPage) about user followed-channels=====>');
      try {
        await userFollowedChannelsProv.loadDataIfStateIsNull(now?.uid);
      } catch (e) {
        print(e);
      }
    });

    String? getSourceLogo(String sourceId) {
      final sourceMap = sourceLogos.firstWhere(
        (sourceMap) => sourceMap["id"] == sourceId,
        orElse: () => {},
      );

      return sourceMap.containsKey('logo') ? sourceMap['logo'] : null;
    }

    void updateTheStateBeforeLeaving() {
      for (int i = 0; i < modifiedStateList.length; i++) {
        final itemMap = modifiedStateList[i];
        final sourceId = itemMap['sourceId'] as String?;
        final isAdded = itemMap['isAdded'] as bool?;
        print('ddddddddd $sourceId  :  $isAdded');

        if (sourceId != null && isAdded != null) {
          userFollowedChannelsProv.toggleUserFollowedChannelsFromState(
              sourceId, widget.userUid, isAdded);
        }
      }
    }

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (wasPopped, result) async {
        try {
          print('Leaving...............');
          updateTheStateBeforeLeaving();
        } catch (e) {
          AppAlerts.displaySnackBar(e.toString(), context);
          await userFollowedChannelsProv
              .refreshUserFollowedChannels(widget.userUid);
        }
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 60, bottom: 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('The Followed Channels'),
                const SizedBox(height: 20),
                Text(userFollowedChannelsState.toString()),
                const SizedBox(height: 20),
                MaterialButton(
                  color: Colors.orange,
                  child: const Text('Add Sources'),
                  onPressed: () async {
                    try {
                      for (int i = 0; i < 3; i++) {
                        await userFollowedChannelsProv
                            .toggleUserFollowedChannelsFromDataBase(
                          sourceLogos[i]['id'],
                          widget.userUid,
                        );
                        userFollowedChannelsProv
                            .toggleUserFollowedChannelsFromState(
                                sourceLogos[i]['id'], widget.userUid, true);
                      }
                    } catch (e) {
                      print(e.toString());
                      AppAlerts.displaySnackBar(e.toString(), context);
                    }
                    // auth_repo.cancelTimer();
                  },
                ),
                MaterialButton(
                  color: Colors.red,
                  child: const Text('go Back'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final String? sourceId = userFollowedChannelsState != null
                        ? userFollowedChannelsState[index]
                        : null;
                    final String? sourceLogo =
                        sourceId != null ? getSourceLogo(sourceId) : null;

                    if (sourceId != null && sourceLogo != null) {
                      Widget imageWidget;
                      if (sourceLogo.contains('base64,')) {
                        imageWidget = Base64Image(imageBase64: sourceLogo);
                      } else {
                        imageWidget = Image.network(
                          sourceLogo,
                          width: 100,
                          height: 100,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        (loadingProgress.expectedTotalBytes ??
                                            1)
                                    : null,
                              ),
                            );
                          },
                          errorBuilder: (BuildContext context, Object error,
                              StackTrace? stackTrace) {
                            return const Icon(Icons.error, size: 50);
                          },
                        );
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          imageWidget,
                          const SizedBox(
                            height: 10,
                          ),
                          ToggleButton(
                            key: ValueKey(sourceId),
                            onFailure: () async {
                              await userFollowedChannelsProv
                                  .refreshUserFollowedChannels(widget.userUid);
                            },
                            callback: (isExists) async {
                              try {
                                var item;
                                var indexInModified;

                                for (int i = 0;
                                    i < modifiedStateList.length;
                                    i++) {
                                  if (modifiedStateList[i]['sourceId'] ==
                                      sourceId) {
                                    item = modifiedStateList[i];
                                    indexInModified = i;
                                    break;
                                  }
                                }

                                setState(() {
                                  if (item == null) {
                                    modifiedStateList.add({
                                      'sourceId': sourceId,
                                      'isAdded': isExists,
                                    });
                                  } else {
                                    modifiedStateList[indexInModified] = {
                                      'sourceId': sourceId,
                                      'isAdded': isExists,
                                    };
                                  }
                                });
                                print(modifiedStateList.toString());
                                // await userFollowedChannelsProv
                                //     .toggleUserFollowedChannelsFromState(
                                //         sourceId, widget.userUid, isExists);

                                await userFollowedChannelsProv
                                    .toggleUserFollowedChannelsFromDataBase(
                                  sourceId,
                                  widget.userUid,
                                );
                              } catch (e) {
                                setState(() {
                                  modifiedStateList.clear();
                                });
                                rethrow;
                              }
                            },
                          ),
                        ],
                      );
                    }

                    return const SizedBox();
                  },
                  separatorBuilder: (context, index) => Container(
                    margin: const EdgeInsets.all(15),
                    height: 2,
                    color: Colors.grey,
                  ),
                  itemCount: userFollowedChannelsState?.length ?? 0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Base64Image extends StatelessWidget {
  final String imageBase64;

  const Base64Image({required this.imageBase64, super.key});
  @override
  Widget build(BuildContext context) {
    // The base64 string
    final splitString = imageBase64.split('base64,');
    final String? base64String =
        splitString.length == 2 ? splitString[1] : null;

    return base64String != null
        ? Image.memory(
            base64Decode(base64String),
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          )
        : const SizedBox();
  }
}

class ToggleButton extends StatefulWidget {
  const ToggleButton(
      {required this.callback, required this.onFailure, super.key});
  final Future<void> Function(bool) callback;
  final Future<void> Function() onFailure;

  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  bool isExists = true;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return !loading
        ? MaterialButton(
            color: Colors.black38,
            child: isExists
                ? const Icon(
                    Icons.check,
                    color: Colors.green,
                  )
                : const Icon(
                    Icons.close,
                    color: Colors.red,
                  ),
            onPressed: () async {
              try {
                setState(() {
                  loading = true;
                  isExists = !isExists;
                });
                await widget.callback(isExists);
                setState(() {
                  loading = false;
                });
              } catch (e) {
                AppAlerts.displaySnackBar(e.toString(), context);
                setState(() {
                  isExists = !isExists;
                });
                try {
                  await widget.onFailure();
                } catch (e) {
                  print(e);
                }

                setState(() {
                  loading = false;
                });
              }
            },
          )
        : const CircularProgressIndicator();
  }
}
