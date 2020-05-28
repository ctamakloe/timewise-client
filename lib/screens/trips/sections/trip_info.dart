import 'package:flutter/material.dart';
import "package:charcode/html_entity.dart";
import 'package:time_wise_app/models/trip.dart';

class TripInfo extends StatelessWidget {
  const TripInfo({
    Key key,
    @required this.trip,
  }) : super(key: key);

  final Trip trip;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 10.0),
//           origin - destination
          Column(
            children: [
              Text(
                this.trip.origin,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5.0),
                child: Image(
                    height: 12.0,
                    width: 12.0,
                    fit: BoxFit.contain,
                    image: AssetImage('assets/images/arrow-down.png')),
              ),
              Text(
                this.trip.destination,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
          SizedBox(height: 15.0),
//           description
          Text('RTN: ' + this.trip.description),
          SizedBox(height: 15.0),
//        schedule
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Mon, 25 May',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
//                    SizedBox(height: 2.0,),
//                    Text(
//                      'Date',
//                      style: TextStyle(
//                        fontSize: 16.0,
//                      ),
//                    ),
                  ],
                ),
                VerticalDivider(
                  thickness: 2.0,
                  color: Colors.grey.shade100,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      this.trip.schedule,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
//                    SizedBox(height: 2.0,),
//                    Text(
//                      'Time',
//                      style: TextStyle(
//                        fontSize: 16.0,
//                      ),
//                    ),
                  ],
                ),
              ],
            ),
          ),
//        schedule v 2
//          Divider(thickness: 1.0, height: 40.0,),
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image(
                image: AssetImage('assets/images/trips/info/timer.png'),
                height: 25,
                width: 25,
              ),
              Text('Duration'),
              Text(
                '1h 50m',
                style: TextStyle(fontWeight: FontWeight.w500),
              )
            ],
          ),
          Divider(
            thickness: 1.0,
            height: 40.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image(
                image: AssetImage(
                    'assets/images/trips/type/${this.trip.purpose}.png'),
                height: 25,
                width: 25,
              ),
              Text('Trip Purpose'),
              Text(
                this.trip.purpose.capitalize(),
                style: TextStyle(fontWeight: FontWeight.w500),
              )
            ],
          ),
          Divider(
            thickness: 1.0,
            height: 40.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image(
                image: AssetImage('assets/images/trips/train/socket.png'),
                height: 25,
                width: 25,
              ),
              Text('Weather'),
              Text(
                '14 ' + String.fromCharCode($deg) + 'C',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),
//          Divider(
//            thickness: 1.0,
//            height: 40.0,
//          ),
//          SizedBox(height: 10.0),
//          // more info
//          Row(
//            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//            children: [Text('weather info'), Text('events info')],
//          )
        ],
      ),
    );
  }
}
