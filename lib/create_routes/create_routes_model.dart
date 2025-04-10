import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'create_routes_widget.dart' show CreateRoutesWidget;
import 'package:flutter/material.dart';

class CreateRoutesModel extends FlutterFlowModel<CreateRoutesWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for PlacePickerStops widget.
  FFPlace placePickerStopsValue = FFPlace();
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
