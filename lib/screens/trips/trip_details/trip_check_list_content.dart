import 'package:flutter/material.dart';
import 'package:time_wise_app/models/trip.dart';

class TripChecklistContent extends StatefulWidget {
  const TripChecklistContent({
    Key key,
    @required this.trip,
  }) : super(key: key);

  final Trip trip;

  @override
  _TripChecklistContentState createState() => _TripChecklistContentState();
}

class _TripChecklistContentState extends State<TripChecklistContent> {
  List<bool> inputs = List<bool>();
  List<String> labels = [
    'Charge laptop',
    'Download Duolingo episode 3 podcast',
    'Buy lunch at station'
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      for (int i = 0; i < 3; i++) {
        inputs.add(false);
      }
    });
  }

  _itemChange(bool val, int index) {
    setState(() {
      inputs[index] = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200.0,
      child: ListView.builder(
          itemCount: inputs.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
//                padding: const EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  CheckboxListTile(
                      checkColor: Colors.indigo,
                      activeColor: Colors.white,
                      value: inputs[index],
                      title: Text(labels[index]),
                      controlAffinity: ListTileControlAffinity.leading,
                      onChanged: (bool val) {
                        _itemChange(val, index);
                      })
                ],
              ),
            );
          }
          ),
    );
  }
}
