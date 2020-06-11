import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:time_wise_app/components/app_bar_title.dart';
import 'package:time_wise_app/components/screen_section.dart';
import 'package:time_wise_app/models/screen_section_data.dart';
import 'package:time_wise_app/screens/account/account_details_content.dart';
import 'package:time_wise_app/state_container.dart';

class AccountHomeScreen extends StatefulWidget {
  @override
  _AccountHomeScreenState createState() => _AccountHomeScreenState();
}

class _AccountHomeScreenState extends State<AccountHomeScreen> {
  List<ScreenSectionData> sectionsData = <ScreenSectionData>[
    ScreenSectionData(
      sectionTitle: '',
      sectionAction: SectionAction(),
      sectionContent: AccountDetailsContent(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(60.0),
            child: TimeWiseAppBar(title: 'Account',
              actions: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                  child: IconButton(
                    icon: Icon(Icons.exit_to_app, size: 25.0),
                    onPressed: () {
                      StateContainer.of(context).logout();
                      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                    },
                  ),
                ),
              ],
            )),
        body: ListView.builder(
            itemCount: sectionsData.length,
            itemBuilder: (context, index) {
              return ScreenSection(
                sectionTitle: sectionsData[index].sectionTitle,
                sectionAction: sectionsData[index].sectionAction,
                sectionContent: sectionsData[index].sectionContent,
              );
            }));
  }
}
