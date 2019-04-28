import 'package:flutter/material.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:video_game_releases/bloc/bloc.dart';
import 'package:video_game_releases/models/enums.dart';
import 'package:video_game_releases/utils/date_util.dart';
import 'package:video_game_releases/utils/filters.dart';

class FilterWidget extends StatefulWidget {

  final GameBloc gameBloc;

  const FilterWidget({Key key, this.gameBloc}) : super(key: key);

  @override
  _FilterWidgetState createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> with SingleTickerProviderStateMixin {

  DateTime fromDate = Filters.fromDate != null ? Filters.fromDate : new DateTime.now();
  DateTime toDate = Filters.toDate != null ? Filters.toDate : new DateTime(DateTime.now().year + 10);
  List<Abbreviation> checkedConsoles = new List<Abbreviation>();

  @override
  Widget build(BuildContext context) {
    return buildFilterDrawer(context);
  }

  buildFilterDrawer(BuildContext context) {
    return new Drawer(
      child: new ListView(
        children: <Widget>[

          Container(
            height: 50,
            child: RaisedButton(
              color: Colors.blueGrey,
              onPressed: () async {

              },
            ),
          ),
          new ListTile(
            title: new Text("Date range"),
          ),

          new ListTile(
            title: new Text("From: " + DateUtil.formatDate(fromDate)),
          ),
          new ListTile(
            title: new Text("To: " + DateUtil.formatDate(toDate)),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              width: 100,
              height: 40,
              child: RaisedButton(
                child: Text("Modify"),
                color: Colors.blueAccent,
                onPressed: () {
                  buildDatePickerDialog();
                },
              ),
            ),
          ),
          new ListTile(
            title: new Text("Console Filters: "),
          ),
          Container(
            height: 300,
            width: 300,
            child: ListView.builder(
              itemCount: abbreviationValues.map.keys.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return CheckboxListTile(
                  // key: PageStorageKey<Abbreviation>(),
                    title: new Text(Abbreviation.values[index].toString().replaceAll("Abbreviation.", "")),
                    onChanged: (bool value) {
                      print("Checked");
                      handleCheckState(value, Abbreviation.values[index]);
                      //Navigator.of(context).pop();
                    },
                    value: this.checkedConsoles.contains(Abbreviation.values[index])
                );
              },
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  width: 100,
                  height: 40,
                  child: RaisedButton(
                    child: Text("Clear"),
                    color: Colors.blueGrey,
                    onPressed: () {
                      clearFilters();
                    },
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  width: 100,
                  height: 40,
                  child: RaisedButton(
                    child: Text("Apply"),
                    color: Colors.blueAccent,
                    onPressed: () {
                      applyFilters();
                    },
                  ),
                ),
              ),

            ],
          )
        ],
      ),

    );
  }

  buildDatePickerDialog() async {

    final List<DateTime> picked = await DateRagePicker.showDatePicker(
        context: context,
        initialFirstDate: fromDate != null ? fromDate : new DateTime.now(),
        initialLastDate: (new DateTime.now()).add(new Duration(days: 7)),
        firstDate: new DateTime(2000),
        lastDate: new DateTime(DateTime.now().year + 7)
    );
    if (picked != null && picked.length == 2) {
      print(picked);
      setState(() {
        print("second date: " + picked[1].toString());
        fromDate = picked[0];
        toDate = picked[1];

        Filters.fromDate = picked[0];
        Filters.toDate = picked[1];
      });
    }
  }

  applyFilters() {
    for (var item in this.checkedConsoles) {
      int platformId = FilterIds.platformIds[item];
      Filters.preparePlatformFilter(platformId);
    }
    widget.gameBloc.dispatch(FetchFilteredList());
    Navigator.of(context).pop();
  }

  clearFilters() {
    Filters.clear();
    widget.gameBloc.dispatch(Fetch());
    Navigator.of(context).pop();

  }

  handleCheckState(bool checked, Abbreviation value) {
    if (checked) {
      this.checkedConsoles.add(value);
    } else {
      this.checkedConsoles.remove(value);
    }
  }

}
