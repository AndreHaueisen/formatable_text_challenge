import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:formatable_text/actions/change_text_action.dart';
import 'package:formatable_text/state/app_state.dart';

class TextFieldConnector extends StatelessWidget {
  final TextEditingController controller;

  TextFieldConnector({Key key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TextFieldViewModel>(
      model: TextFieldViewModel(),
      builder: (BuildContext context, TextFieldViewModel vm) => TextField(
        controller: controller,
        onChanged: (_) {
          vm.onChanged(controller.text);
        },
        decoration: InputDecoration(),
      ),
    );
  }
}

class TextFieldViewModel extends BaseModel<AppState> {
  Function(String) onChanged;

  TextFieldViewModel();

  TextFieldViewModel.build({
    @required this.onChanged,
  });

  @override
  TextFieldViewModel fromStore() {
    return TextFieldViewModel.build(
      onChanged: (newText) => dispatch(ChangeTextAction(newText)),
    );
  }
}
