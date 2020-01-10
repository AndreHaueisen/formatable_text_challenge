import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:formatable_text/widgets/formatable_text.dart';

class Page extends StatefulWidget {
  final Event<String> changeTextEvt;
  final VoidCallback onTextChange;

  Page({@required this.changeTextEvt, @required this.onTextChange}) : assert(changeTextEvt != null);

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void didUpdateWidget(Page oldWidget) {
    super.didUpdateWidget(oldWidget);
    String newText = widget.changeTextEvt.consume();
    if (newText != null)
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          if (mounted) _controller.value = _controller.value.copyWith(text: newText);
        },
      );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Spacer(),
            Text('@ is the bold tag\n_ is the italic tag\n~ is the strikethrough tag'),
            Flexible(
              child: FormatableText(
                phrase: _controller.value.text,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _controller,
                onChanged: (_){
                  widget.onTextChange();
                },
                decoration: InputDecoration(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
