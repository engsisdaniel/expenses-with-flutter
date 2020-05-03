import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class ChartBar extends StatelessWidget {
  final String _label;
  final double _value;
  final double _percentage;

  ChartBar({@required label, @required value, @required percentage})
      : _label = label,
        _value = value,
        _percentage = percentage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 20,
          child: FittedBox(
            child: Text('${this._value.toStringAsFixed(2)}'),
          ),
        ),
        SizedBox(height: 5),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  color: Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              FractionallySizedBox(
                  heightFactor: this._percentage,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ))
            ],
          ),
        ),
        SizedBox(height: 5),
        Text(this._label)
      ],
    );
  }
}
