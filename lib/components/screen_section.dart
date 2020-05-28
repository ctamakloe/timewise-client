import 'package:flutter/material.dart';
import 'package:time_wise_app/models/screen_section_data.dart';

class ScreenSection extends StatefulWidget {
  final String sectionTitle;
  final SectionAction sectionAction;
  final Widget sectionContent;

  ScreenSection({
    Key key,
    this.sectionTitle,
    this.sectionAction,
    this.sectionContent,
  }) : super(key: key);

  @override
  _ScreenSectionState createState() => _ScreenSectionState();
}

class _ScreenSectionState extends State<ScreenSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      height: 600,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // header
          _buildSectionHeader(),
          // content
          widget.sectionContent,
        ],
      ),
    );
  }

  _buildSectionHeader() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.sectionTitle,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          widget.sectionAction != null
              ? InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, widget.sectionAction.route,
                        arguments: widget.sectionAction.routeArguments);
                  },
                  child: Text(
                    widget.sectionAction.title,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : ''
        ],
      ),
    );
  }
}
