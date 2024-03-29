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
  String gameName = Filters.getGameName();
  List<AbbreviationFilter> checkedConsoles = new List<AbbreviationFilter>();
  final formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return buildFilterDrawer(context);
  }

  buildFilterDrawer(BuildContext context) {
    return new Drawer(
      child: new ListView(
        children: <Widget>[

          Container(
            height: 20,
            child: RaisedButton(
              color: Colors.blueGrey,
              onPressed: () async {

              },
            ),
          ),
          new ListTile(
            title: new Text("Date Range: " ),
            subtitle: Row(
              children: <Widget>[
                buildTappableDate(fromDate),
                Text(" - "),
                buildTappableDate(toDate)
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              width: 100,
              height: 40,
              child: RaisedButton(
                child: Text("Modify"),
                color: Colors.blueGrey,
                onPressed: () {
                  buildDatePickerRangeDialog();
                },
              ),
            ),
          ),
          Container(
            height: 60,
            width: 20,
            child: new Form(
              key: formKey,
              child: TextFormField(
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 4, top: 20),
                      labelText: 'Game name'
                  ),
                  onSaved: (val) => gameName = val,
              ),
            ),
          ),
          ExpansionTile(
            title: Text("Console Filters: "),
            children: <Widget>[
              Container(
                  height: 300,
                  width: 300,
                  child: ListView.builder(
                    itemCount: abbreviationFilterValues.map.keys.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return CheckboxListTile(
                        // key: PageStorageKey<AbbreviationFilter>(),
                          title: new Text(abbreviationFilterValues.reverse[AbbreviationFilter.values[index]]),
                          onChanged: (bool value) {
                            print("Checked");
                            handleCheckState(value, AbbreviationFilter.values[index]);
                            //Navigator.of(context).pop();
                          },
                          value: this.checkedConsoles.contains(AbbreviationFilter.values[index])
                      );
                    },
                  ),
                ),
            ],),
          // new ListTile(
          //   title: new Text("Console Filters: "),
          // ),
          
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  width: 100,
                  height: 40,
                  child: FlatButton(
                    child: Text("Clear"),
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
                    color: Colors.blueGrey,
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

  buildTappableDate(DateTime gameDate) {
    return InkWell(
      child: Text(
          DateUtil.formatDate(gameDate),
        style: TextStyle(
          fontSize: 18,
          color: Colors.lightBlue,
          decoration: TextDecoration.underline
        ),
      ),
      onTap: () {
        buildDatePickerDialog(gameDate);
        print(gameDate);
      },
    );
  }

  buildDatePickerRangeDialog() async {

    final List<DateTime> picked = await DateRagePicker.showDatePicker(
        context: context,
        initialFirstDate: fromDate != null ? fromDate : new DateTime.now(),
        initialLastDate: (new DateTime.now()).add(new Duration(days: 7)),
        firstDate: new DateTime(1980),
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

  buildDatePickerDialog(DateTime gameDate) async {
    final DateTime dateTime = await showDatePicker(
        context: context,
        initialDate: fromDate != null ? fromDate : new DateTime.now(),
        firstDate: new DateTime(1980),
        lastDate: new DateTime(DateTime.now().year + 7)
    );

    if (dateTime != null) {
      setState(() {
        print("chosen: " + dateTime.toString());
        print(gameDate);
        if (gameDate == this.fromDate) {
          fromDate = dateTime;

          Filters.fromDate = dateTime;
        } else {
          toDate = dateTime;
          Filters.toDate = dateTime;
        }
      });
    }
  }

  applyFilters() {
    formKey.currentState.save();

    for (var item in this.checkedConsoles) {
      int platformId = FilterIds.platformIds[item];
      Filters.preparePlatformFilter(platformId);
    }

    Filters.prepareGameNameFilter(gameName);
    widget.gameBloc.dispatch(FetchFilteredList());
    Navigator.of(context).pop();
  }

  clearFilters() {
    Filters.clear();
    widget.gameBloc.dispatch(Fetch());
    Navigator.of(context).pop();

  }

  handleCheckState(bool checked, AbbreviationFilter value) {
    if (checked) {
      this.checkedConsoles.add(value);
    } else {
      this.checkedConsoles.remove(value);
    }
  }

}
