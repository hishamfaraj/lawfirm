import '/flutter_flow/flutter_flow_util.dart';
import 'document_management_widget.dart' show DocumentManagementWidget;
import 'package:flutter/material.dart';

class DocumentManagementModel
    extends FlutterFlowModel<DocumentManagementWidget> {
  ///  State fields for stateful widgets in this page.

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
