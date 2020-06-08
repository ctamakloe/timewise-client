import 'package:flutter/material.dart';
import 'package:time_wise_app/components/tw_flatbutton.dart';
import 'package:time_wise_app/state_container.dart';

class AccountDetailsContent extends StatefulWidget {
  @override
  _AccountDetailsContentState createState() => _AccountDetailsContentState();
}

class _AccountDetailsContentState extends State<AccountDetailsContent> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10.0),
      child: Column(children: [
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 150.0,
                height: 150.0,
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/user.png'),
                  backgroundColor: Colors.indigo[300],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
//              Text('JON',
//                  style:
//                  TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
              Text(StateContainer.of(context).getAppState().user.name,
                  style:
                      TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
              SizedBox(height: 5.0),
              Text(StateContainer.of(context).getAppState().user.email,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 30.0),
              Container(
                width: 200.0,
                child: TWFlatButton(
                    inverted: false,
                    context: context,
                    buttonText: 'EDIT ACCOUNT',
                    onPressed: () {
                      Navigator.pushNamed(context, '/accountEdit');
                    }),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
