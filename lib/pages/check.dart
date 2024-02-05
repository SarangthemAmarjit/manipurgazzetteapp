import 'package:flutter/material.dart';


class CheckFocusPage extends StatefulWidget {
  @override
  _CheckFocusPageState createState() => _CheckFocusPageState();
}

class _CheckFocusPageState extends State<CheckFocusPage> {
  FocusNode _focusNode = FocusNode();
  bool isTextFieldFocused = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Focus(
            onFocusChange: (hasFocus) {
              setState(() {
                isTextFieldFocused = hasFocus;
              });
            },
            child: TextField(
              focusNode: _focusNode,
              decoration: InputDecoration(
                labelText: 'Enter text',
              ),
            ),
          ),
          SizedBox(height: 16),
          Text(
            isTextFieldFocused ? 'TextField is focused' : 'TextField is not focused',
            style: TextStyle(
              color: isTextFieldFocused ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Toggle focus programmatically
              if (_focusNode.hasFocus) {
                _focusNode.unfocus();
              } else {
                _focusNode.requestFocus();
              }
            },
            child: Text('Toggle Focus'),
          ),
        ],
      ),
    );
  }
}
