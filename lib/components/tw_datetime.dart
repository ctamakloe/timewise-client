import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TWTimeField extends StatelessWidget {
  final format = DateFormat.Hm();
  final TextEditingController formController;
  final String labelText;

  TWTimeField({
    Key key,
    @required TextEditingController formController,
    @required String labelText,
  })  : formController = formController,
        labelText = labelText,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      DateTimeField(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(0, 30, 10, 10),
          labelText: labelText,
        ),
        format: format,
        cursorColor: Colors.indigo,
        onShowPicker: (context, currentValue) async {
          final time = await showTimePicker(
              context: context,
              initialTime:
                  TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
              builder: (BuildContext context, Widget child) {
                return Theme(
                  data: ThemeData(
                    primarySwatch: Colors.indigo,
                  ),
                  child: child,
                );
              });
          return DateTimeField.convert(time);
        },
      ),
    ]);
  }
}
