import 'package:flutter/foundation.dart';

class Transaction {
  final String _id;
  final String _title;
  final double _value;
  final DateTime _date;

  Transaction({@required id, @required title, @required value, @required date})
      : _id = id,
        _title = title,
        _value = value,
        _date = date;
  
  String get id {
    return _id;
  }
  String get title {
    return _title;
  }
  double get value {
    return _value;
  }
  DateTime get date {
    return _date;
  }
}
