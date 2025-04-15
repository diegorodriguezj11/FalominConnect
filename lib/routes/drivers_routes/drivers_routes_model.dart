import '/flutter_flow/flutter_flow_calendar.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'drivers_routes_widget.dart' show DriversRoutesWidget;
import 'package:flutter/material.dart';

class DriversRoutesModel extends FlutterFlowModel<DriversRoutesWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for DropDownDrivers widget.
  String? dropDownDriversValue;
  FormFieldController<String>? dropDownDriversValueController;
  // State field(s) for DropDownSchool widget.
  String? dropDownSchoolValue;
  FormFieldController<String>? dropDownSchoolValueController;
  // State field(s) for DropDownRoutes widget.
  String? dropDownRoutesValue;
  FormFieldController<String>? dropDownRoutesValueController;
  // State field(s) for Calendar widget.
  DateTimeRange? calendarSelectedDay;

  @override
  void initState(BuildContext context) {
    calendarSelectedDay = DateTimeRange(
      start: DateTime.now().startOfDay,
      end: DateTime.now().endOfDay,
    );
  }

  @override
  void dispose() {}
}
