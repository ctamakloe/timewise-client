import 'package:flutter/material.dart';

class ScreenSectionData {
  final String sectionTitle;
  final SectionAction sectionAction;
  final Widget sectionContent;

  ScreenSectionData({
    this.sectionTitle,
    this.sectionAction,
    this.sectionContent,
  });
}

class SectionAction {
  final String title;
  final String route;
  final Map routeArguments;

  SectionAction(this.title, this.route, this.routeArguments);
}
