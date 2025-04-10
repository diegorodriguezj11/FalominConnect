import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'ratings_widget.dart' show RatingsWidget;
import 'package:flutter/material.dart';

class RatingsModel extends FlutterFlowModel<RatingsWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for RatingBar widget.
  double? ratingBarValue;
  // State field(s) for Comments widget.
  FocusNode? commentsFocusNode;
  TextEditingController? commentsTextController;
  String? Function(BuildContext, String?)? commentsTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    commentsFocusNode?.dispose();
    commentsTextController?.dispose();
  }
}
