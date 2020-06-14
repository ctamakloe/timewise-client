import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:time_wise_app/models/station.dart';
import 'package:time_wise_app/state_container.dart';

class TWStationAutoCompleteTextField extends StatelessWidget {
  const TWStationAutoCompleteTextField({
    Key key,
    @required TextEditingController formController,
    @required String label,
  })  : formController = formController,
        labelText = label,
        super(key: key);

  final TextEditingController formController;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return AutoCompleteTextField<Station>(
      controller: formController,
      clearOnSubmit: false,
      suggestions: StateContainer.of(context).getAppState().stations, //Station.getStations(),
      style: TextStyle(color: Colors.black, fontSize: 16.0),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(0, 30, 10, 10),
//        hintText: labelText,
//        hintStyle: TextStyle(color: Colors.black),
        labelText: labelText,
      ),
      itemFilter: (item, query) {
        return item.name.toLowerCase().startsWith(query.toLowerCase());
      },
      itemSorter: (a, b) {
        return a.name.compareTo(b.name);
      },
      itemSubmitted: (item) {
        formController.text = '${item.name} (${item.code})';
      },
      itemBuilder: (context, item) {
        return Container(
          height: 50.0,
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                item.name,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                item.code,
              ),
            ],
          ),
        );
      },
    );
  }
}
