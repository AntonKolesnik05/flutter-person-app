import 'package:flutter/material.dart';

class YoutubeModel extends ChangeNotifier {
  final Set<String> subscribedChannels = {};

  void subscribe(String channelId) {
    subscribedChannels.add(channelId);
    notifyListeners();
  }

  bool isSubscribed(String channelId) {
    return subscribedChannels.contains(channelId);
  }

  int get subscriptionsCount => subscribedChannels.length;
}
