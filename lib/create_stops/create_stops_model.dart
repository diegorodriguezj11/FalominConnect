import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'create_stops_widget.dart' show CreateStopsWidget;
import 'package:flutter/material.dart';

class CreateStopsModel extends FlutterFlowModel<CreateStopsWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for DropDownStarting widget.
  String? dropDownStartingValue;
  FormFieldController<String>? dropDownStartingValueController;
  // State field(s) for PlacePickerStops widget.
  FFPlace placePickerStopsValue = FFPlace();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
