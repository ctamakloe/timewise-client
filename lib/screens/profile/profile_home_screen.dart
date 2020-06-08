import 'package:flutter/material.dart';
import 'package:time_wise_app/components/app_bar_title.dart';
import 'package:time_wise_app/components/screen_section.dart';
import 'package:time_wise_app/models/screen_section_data.dart';
import 'package:time_wise_app/screens/profile/account_details_content.dart';
import 'package:time_wise_app/screens/profile/travel_profile_content.dart';
import 'package:time_wise_app/state_container.dart';

class ProfileHomeScreen extends StatefulWidget {
  @override
  _ProfileHomeScreenState createState() => _ProfileHomeScreenState();
}

class _ProfileHomeScreenState extends State<ProfileHomeScreen> {
  List<ScreenSectionData> sectionsData = <ScreenSectionData>[
    ScreenSectionData(
      sectionTitle: 'ACCOUNT',
      sectionAction: SectionAction(),
      sectionContent: AccountDetailsContent(),
    ),
    ScreenSectionData(
      sectionTitle: 'TRAVEL PROFILE',
      sectionAction: SectionAction(),
      sectionContent: TravelProfileContent(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(60.0),
            child: TimeWiseAppBar(title: 'Profile',
              actions: [
                IconButton(
                  icon: Icon(Icons.exit_to_app),
                  onPressed: (){
                    StateContainer.of(context).logout();
                    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                  },
                )
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
