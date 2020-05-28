import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:time_wise_app/models/trip.dart';

class ServicesInfo extends StatelessWidget {
  const ServicesInfo({
    Key key,
    @required this.trip,
  }) : super(key: key);

  final Trip trip;

  Widget _serviceInfoTile(BuildContext context, String iconName, String info) {
    return GestureDetector(
      onTap: () {
        _showServiceInfo(context, info);
      },
      child: Container(
        child: Image(
          image: AssetImage('assets/images/trips/train/$iconName.png'),
          height: 30.0,
          width: 30.0,
        ),
      ),
    );
  }

  void _showServiceInfo(BuildContext context, String info) {
    showMaterialModalBottomSheet(
        context: context,
        builder: (context, scrollController) {
          return Container(
            padding: EdgeInsets.all(30.0),
            child: Text(info),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        _serviceInfoTile(context, 'wifi', 'How to access WiFi'),
        _serviceInfoTile(context, 'socket', 'Where to find charging points'),
        _serviceInfoTile(context, 'catering',
            'Trolley availability, menu and serving times'),
        _serviceInfoTile(context, 'toilet', 'Toilet information'),
        _serviceInfoTile(context, 'accessibility', 'Accessibility options'),
        _serviceInfoTile(context, 'bike', 'Bike storage'),
      ]),
    );
  }
}
