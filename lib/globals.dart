import 'package:fetch/fetch.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nano/pods/pods.dart';

abstract class Globals {
  ///
  static final pc = ProviderContainer();
}

final fetch = Fetch(
  base: 'https://fakestoreapi.com',
  handler: FetchResponse.fromHandler,
  enableLogs: true,
  headerBuilder: () {
    final user = Globals.pc.read(userPod);

    return {
      'content-type': 'application/json',
      if (user.isLoggedIn) 'authorization': 'bearer ${user.token}'
    };
  },
);
