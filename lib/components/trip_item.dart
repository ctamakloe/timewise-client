import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_wise_app/models/trip.dart';

class TripListItem extends StatefulWidget {
  final Trip trip;

  const TripListItem({Key key, this.trip}) : super(key: key);

  @override
  _TripListItemState createState() => _TripListItemState();
}

class _TripListItemState extends State<TripListItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/tripDetails',
            arguments: widget.trip);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(width: .5, color: Colors.grey),
        )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: Image(
                  height: 30.0,
                  width: 30.0,
                  fit: BoxFit.contain,
                  image: AssetImage(
                      'assets/images/trips/type/${widget.trip.purpose}.png')),
            ),
            Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.trip.description),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      widget.trip.title,
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    DefaultTextStyle.merge(
                        style: TextStyle(color: Colors.grey, fontSize: 14.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(widget.trip.date),
                            Text(widget.trip.schedule),
                          ],
                        )),
                  ],
                )),
            Expanded(
              flex: 1,
              child: Image(
                  height: 20.0,
                  width: 20.0,
                  fit: BoxFit.contain,
                  image: AssetImage('assets/images/trips/scale/5.png')),
            ),
          ],
        ),
      ),
    );
  }
}
