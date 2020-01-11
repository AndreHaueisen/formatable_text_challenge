import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:formatable_text/state/app_state.dart';
import 'package:formatable_text/widgets/formattable_text.dart';

class FormattedTextConnector extends StatelessWidget {
  FormattedTextConnector({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, FormattedTextViewModel>(
      model: FormattedTextViewModel(),
      builder: (BuildContext context, FormattedTextViewModel vm) => FormattedText(
        phrase: vm.changeTextEvt.consume(),
      ),
    );
  }
}

class FormattedTextViewModel extends BaseModel<AppState> {
  FormattedTextViewModel();

  Event<String> changeTextEvt;

  FormattedTextViewModel.build({
    @required this.changeTextEvt,
  }) : super(equals: [changeTextEvt]);

  @override
  FormattedTextViewModel fromStore() {
    return FormattedTextViewModel.build(
      changeTextEvt: state.changeTextEvt,
    );
  }
}
