import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class RatingScale extends StatelessWidget {
  final String scaleType;
  final String minText;
  final String maxText;

  RatingScale({this.scaleType, this.minText = '', this.maxText = ''});

  @override
  Widget build(BuildContext context) {
    List<IconData> icons = [];

    if (scaleType == 'emoji') {
      icons = [
        LineAwesomeIcons.loudly_crying_face,
        LineAwesomeIcons.frowning_face,
        LineAwesomeIcons.neutral_face,
        LineAwesomeIcons.smiling_face,
        LineAwesomeIcons.grinning_face_with_smiling_eyes,
      ];
    }
    if (scaleType == 'star') {
      icons = [
        LineAwesomeIcons.star,
        LineAwesomeIcons.star,
        LineAwesomeIcons.star,
        LineAwesomeIcons.star,
        LineAwesomeIcons.star,
      ];
    }
    if (scaleType == 'circle') {
      icons = [
        LineAwesomeIcons.circle,
        LineAwesomeIcons.circle,
        LineAwesomeIcons.circle,
        LineAwesomeIcons.dot_circle,
        LineAwesomeIcons.circle,
      ];
    }
    if (scaleType == 'like') {
      icons = [
        LineAwesomeIcons.thumbs_down,
        LineAwesomeIcons.thumbs_up,
      ];
    }
    return Column(
      children: [
        Container(
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: icons
                      .asMap()
                      .map((index, icon) =>
                          MapEntry(index, RatingIcon(index, icon)))
                      .values
                      .toList(),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (this.minText != '')
              Container(
                  width: 80.0,
                  child: Text(
                    this.minText,
                    textAlign: TextAlign.center,
                  )),
            if (this.maxText != '')
              Container(
                  width: 80.0,
                  child: Text(
                    this.maxText,
                    textAlign: TextAlign.center,
                  )),
          ],
        ),
      ],
    );
  }
}

class RatingIcon extends StatelessWidget {
  final int iconIndex;
  final IconData iconData;

  RatingIcon(this.iconIndex, this.iconData);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Icon(
              this.iconData,
              size: 30.0,
              color: Colors.indigo,
            ),
          ),
        ],
      ),
    );
  }
}
