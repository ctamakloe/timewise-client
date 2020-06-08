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
  final String type;
  final Widget screen;

  SectionAction({
    this.title = '',
    this.route = '',
    this.routeArguments,
    this.type = '',
    this.screen,
  });
}
