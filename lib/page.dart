import 'package:flutter/material.dart';
import 'package:formatable_text/connectors/formatted_text_connector.dart';
import 'package:formatable_text/connectors/text_field_connector.dart';

class Page extends StatelessWidget {

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
              child: FormattedTextConnector(),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFieldConnector(),
            ),
          ],
        ),
      ),
    );
  }
}