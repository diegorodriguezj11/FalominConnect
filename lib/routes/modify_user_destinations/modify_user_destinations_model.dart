import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'modify_user_destinations_widget.dart' show ModifyUserDestinationsWidget;
import 'package:flutter/material.dart';

class ModifyUserDestinationsModel
    extends FlutterFlowModel<ModifyUserDestinationsWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for ChoiceChipsRoutes widget.
  FormFieldController<List<String>>? choiceChipsRoutesValueController;
  String? get choiceChipsRoutesValue =>
      choiceChipsRoutesValueController?.value?.firstOrNull;
  set choiceChipsRoutesValue(String? val) =>
      choiceChipsRoutesValueController?.value = val != null ? [val] : [];
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController;
  String? get choiceChipsValue =>
      choiceChipsValueController?.value?.firstOrNull;
  set choiceChipsValue(String? val) =>
      choiceChipsValueController?.value = val != null ? [val] : [];
  // State field(s) for DropDownDestinatation widget.
  String? dropDownDestinatationValue;
  FormFieldController<String>? dropDownDestinatationValueController;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
