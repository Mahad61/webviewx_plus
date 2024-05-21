import 'dart:js_interop';

import 'facade.dart' as facade;

class DartCallback extends facade.DartCallback<JSAny> {
  DartCallback({
    required super.name,
    required super.callBack,
  });
}
