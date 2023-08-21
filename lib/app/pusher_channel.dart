import 'dart:developer';

import 'package:attendance/app/constants.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';


class PusherChannelConnect {
  String channelName = 'reservation_branches_260';

  PusherChannelsFlutter pusher;

  PusherChannelConnect(this.pusher);

  void initPusher() async {
    try {
      await pusher.init(
        apiKey: Constants.apiKeyPusher,
        cluster: Constants.clusterPusher,
        onConnectionStateChange: onConnectionStateChange,
        onError: onError,
        onSubscriptionSucceeded: onSubscriptionSucceeded,
        onEvent: onEvent,
        onSubscriptionError: onSubscriptionError,
        onDecryptionFailure: onDecryptionFailure,
        onMemberAdded: onMemberAdded,

        onMemberRemoved: onMemberRemoved,
        //  onSubscriptionCount: onSubscriptionCount,
        // authEndpoint: "<Your Authendpoint Url>",
        // onAuthorizer: onAuthorizer
      );
      await pusher.subscribe(channelName: channelName);

      await pusher.connect();
    } catch (e) {
      log("ERROR: $e");
    }
  }

  void disconnected() async {
    try {
      await pusher.disconnect();
    } catch (e) {
      log("ERROR: $e");
    }
  }

  void reinitializePusher() async {
    try {
      disconnected();
      pusher = PusherChannelsFlutter();
      initPusher();
    } catch (e) {
      log("ERROR: $e");
    }
  }

  subscribeWithChannel() async {
    try {
      if (pusher.getChannel(channelName)?.channelName != channelName) {
        await pusher.subscribe(channelName: channelName);
        log('One::::' + channelName);
      }
      log(channelName);
    } catch (e) {}
  }


  void onConnectionStateChange(dynamic currentState, dynamic previousState) {
    log("Connection: $currentState");
  }

  void onError(String message, int? code, dynamic e) {
    log("onError: $message code: $code exception: $e");
  }

  void onEvent(PusherEvent event) async {
    log("onEvent: $event");

    if (event.data != null && event.data.toString().contains('key')) {
      // var decodedResponse = await json.decode(event.data.toString());

      // Singleton().handleCallApiForListenPusher(key: decodedResponse['key']);
    }
  }

  void onSubscriptionSucceeded(String channelName, dynamic data) {
    log("onSubscriptionSucceeded: $channelName data: $data");
    final me = pusher.getChannel(channelName)?.channelName;
    log("Me: $me");
  }

  void onSubscriptionError(String message, dynamic e) {
    log("onSubscriptionError: $message Exception: $e");
  }

  void onDecryptionFailure(String event, String reason) {
    log("onDecryptionFailure: $event reason: $reason");
  }

  void onMemberAdded(String channelName, PusherMember member) {
    log("onMemberAdded: $channelName user: $member");
  }

  void onMemberRemoved(String channelName, PusherMember member) {
    log("onMemberRemoved: $channelName user: $member");
  }

  void onSubscriptionCount(String channelName, int subscriptionCount) {
    log("onSubscriptionCount: $channelName subscriptionCount: $subscriptionCount");
  }

  dynamic onAuthorizer(String channelName, String socketId, dynamic options) {
    return {"channel_data": '{"user_id": 1}', "shared_secret": "foobar"};
  }
}
