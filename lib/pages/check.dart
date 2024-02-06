import 'package:flutter/material.dart';

class MyForm extends StatefulWidget {
  const MyForm({super.key});

  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  String? _emailErrorText;

  void _validateEmail(String value) {
    if (value.isEmpty) {
      setState(() {
        _emailErrorText = 'Email is required';
      });
    } else if (!isEmailValid(value)) {
      setState(() {
        _emailErrorText = 'Enter a valid email address';
      });
    } else {
      setState(() {
        _emailErrorText = null;
      });
    }
  }

  bool isEmailValid(String email) {
    // Basic email validation using regex
    // You can implement more complex validation if needed
    return RegExp(r'^[\w-\.]+@[a-zA-Z]+\.[a-zA-Z]{2,}$').hasMatch(email);
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Form is valid, proceed with your logic here
      // For this example, we will simply print the email
      print('Email: ${_emailController.text}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TextField Validation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _emailErrorText != null
                  ? Text(
                      _emailErrorText!,
                      style: const TextStyle(color: Colors.red),
                    )
                  : const SizedBox(),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                onChanged: _validateEmail,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _validateEmail(_emailController.text);
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
