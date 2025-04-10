import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'create_school_widget.dart' show CreateSchoolWidget;
import 'package:flutter/material.dart';

class CreateSchoolModel extends FlutterFlowModel<CreateSchoolWidget> {
  ///  State fields for stateful widgets in this page.

  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl = '';

  // State field(s) for PlacePicker widget.
  FFPlace placePickerValue = FFPlace();
  // State field(s) for DropDownTipe widget.
  String? dropDownTipeValue;
  FormFieldController<String>? dropDownTipeValueController;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  /// Action blocks.
  Future placePicker(BuildContext context) async {
    FFAppState().placePickerValue = placePickerValue.latLng;
  }
}
