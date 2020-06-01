import 'package:flutter/material.dart';
import 'package:time_wise_app/components/app_bar_title.dart';
import 'package:time_wise_app/components/screen_section.dart';
import 'package:time_wise_app/components/tw_flatbutton.dart';
import 'package:time_wise_app/components/tw_textfield.dart';
import 'package:time_wise_app/models/screen_section_data.dart';

class AccountEditScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: TimeWiseAppBar(title: 'Account • Edit'),
      ),
      body: ScreenSection(
          sectionTitle: 'EDIT ACCOUNT',
          sectionAction: SectionAction(),
          sectionContent: _buildContent(context)),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TWTextField(labelText: 'First Name', ),
          SizedBox(height: 10.0),
          TWTextField(labelText: 'Surname', ),
          SizedBox(height: 10.0),
          TWTextField(labelText: 'Age', ),
          SizedBox(height: 10.0),
          TWTextField(labelText: 'Gender', ),
          SizedBox(height: 40.0),
          TWFlatButton(
              context: context,
              buttonText: 'SAVE',
              onPressed: () {
                Navigator.pushNamed(context, '/accountEdit');
              }
          )
        ],
      ),
    );
  }
}
