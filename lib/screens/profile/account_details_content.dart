import 'package:flutter/material.dart';
import 'package:time_wise_app/components/tw_flatbutton.dart';

class AccountDetailsContent extends StatelessWidget {
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
              SizedBox(height: 20.0,),
              Text('JOHN DOE', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
              SizedBox(height: 30.0),
              Container(
                width: 200.0,
                child: TWFlatButton(
                  inverted: false,
                  context: context,
                  buttonText: 'EDIT ACCOUNT',
                  onPressed: () {
                    Navigator.pushNamed(context, '/accountEdit');
                  }
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
