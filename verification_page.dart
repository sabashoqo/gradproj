import 'package:flutter/material.dart';

class VerificationPage extends StatefulWidget {
  final String email;

  VerificationPage({required this.email});

  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final _codeController = TextEditingController();
  bool _isCodeSent = true;

  void _verifyCode() {
    // Replace this with an API call to verify the code
    final enteredCode = _codeController.text;
    if (enteredCode == "123456") {
      // Replace 123456 with the backend-generated code
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Verification Successful!')),
      );
      Navigator.pop(context); // Navigate back or to a success page
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid Verification Code!')),
      );
    }
  }

  void _resendCode() {
    setState(() {
      _isCodeSent = false;
    });

    // Call the backend API to resend the code
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isCodeSent = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Verification Code Resent')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5DC),
      appBar: AppBar(
        title: Text('Verification'),
        backgroundColor: Colors.lightBlue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text(
              'Verification Code Sent to ${widget.email}',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _codeController,
              decoration: InputDecoration(labelText: 'Enter Verification Code'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _verifyCode,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyan,
              ),
              child: Text('Verify Code'),
            ),
            if (!_isCodeSent)
              CircularProgressIndicator()
            else
              TextButton(
                onPressed: _resendCode,
                child: Text('Resend Code'),
              ),
          ],
        ),
      ),
    );
  }
}
