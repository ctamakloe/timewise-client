import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
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
        Navigator.pushNamed(context, '/tripDetails', arguments: widget.trip);
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
              flex: 2,
              child: Container(
                height: 40.0,
                width: 40.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.indigo[300],
                ),
                child: Icon(
                  widget.trip.isBusiness()
                      ? LineAwesomeIcons.briefcase
                      : LineAwesomeIcons.theater_masks,
                  size: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.trip.title,
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    if (!widget.trip.purpose.isEmpty) Text(widget.trip.purpose),
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
            (widget.trip.isCompleted())
                ? Expanded(
                    flex: 1,
                    child: Icon(
                      _tripRatingIcon(),
                      size: 30.0,
                    ),
                  )
                : Expanded(
                    flex: 1,
                    child: Container(),
                  )
          ],
        ),
      ),
    );
  }

  IconData _tripRatingIcon() {
    switch (widget.trip.rating) {
      case '1':
        return LineAwesomeIcons.loudly_crying_face;
      case '2':
        return LineAwesomeIcons.frowning_face;
      case '3':
        return LineAwesomeIcons.neutral_face;
      case '4':
        return LineAwesomeIcons.smiling_face;
      case '5':
        return LineAwesomeIcons.grinning_face_with_smiling_eyes;
      default:
        return LineAwesomeIcons.grinning_face_with_smiling_eyes;
    }
  }
}
