import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:formatable_text/actions/change_text_action.dart';
import 'package:formatable_text/state/app_state.dart';

class TextFieldConnector extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TextFieldViewModel>(
      model: TextFieldViewModel(),
      builder: (BuildContext context, TextFieldViewModel vm) => TextField(
        onChanged: (newText) {
          vm.onChanged(newText);
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
