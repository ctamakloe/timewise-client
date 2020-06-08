import 'package:flutter/material.dart';
import 'package:time_wise_app/components/tw_flatbutton.dart';
import 'package:time_wise_app/services/checklist_service.dart';

class AddChecklistScreen extends StatefulWidget {
  @override
  _AddChecklistScreenState createState() => _AddChecklistScreenState();
}

class _AddChecklistScreenState extends State<AddChecklistScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _listItem = ChecklistItem();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      height: 400.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Add new checklist item',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
          Divider(
            thickness: 1.0,
            height: 40.0,
          ),
          Container(
            height: 300.0,
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  TextFormField(),
                  SizedBox(
                    height: 40.0,
                  ),
                  Container(
                    width: 200.0,
                    child: Column(
                      children: [
                        TWFlatButton(
                          inverted: false,
                          context: context,
                          buttonText: 'ADD',
                          onPressed: () {
                            final form = _formKey.currentState;
                            if (form.validate()) {
//                              form.save();
//                              _listItem.save();
                              _showDialog(context);

                              Navigator.pop(context);
                            }
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        TWFlatButton(
                          inverted: true,
                          context: context,
                          buttonText: 'CANCEL',
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _showDialog(BuildContext context) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text('Item added')));
  }
}
