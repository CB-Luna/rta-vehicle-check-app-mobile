import 'dart:async';

import 'package:flutter/services.dart';
import 'package:uni_links/uni_links.dart';

abstract class Bloc {
  void dispose();
}

class DeepLinkBloc extends Bloc {
  final StreamController<String> _stateController = StreamController();

  Stream<String?> get state => _stateController.stream;

  Sink<String?> get stateSink => _stateController.sink;

  //Adding the listener into contructor
  DeepLinkBloc() {
    //Checking application start by deep link
    startUri().then(_onRedirected);
    //Checking broadcast stream, if deep link was clicked in opened appication
    uriLinkStream.listen(
      (event) => _onRedirected(event),
      // onError: (err) => print(err),
    );
  }

  void _onRedirected(Uri? uri) {
    // Here can be any uri analysis, checking tokens etc, if it’s necessary
    // Throw deep link URI into the BloC's stream
    if (uri == null) return;
    print(uri.toString());

    //If url has code, app redirects to reset password screen
    //If not, app starts normally
    stateSink.add(uri.queryParameters['code']);
  }

  @override
  void dispose() {
    _stateController.close();
  }

  Future<Uri?> startUri() async {
    try {
      return await getInitialUri();
    } on PlatformException catch (e) {
      print("Failed to Invoke: '${e.message}'.");
      return null;
    } on FormatException catch (_) {
      print("Malformed initial Uri.");
      return null;
    }
  }
}
