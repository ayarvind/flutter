import 'package:flutter/material.dart';
import 'package:moods/pages/verfiy_otp.dart';
import '../constant/themes.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _phoneNumber = TextEditingController();
  String _message = '';
  bool _isLoading = false;

  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  @override
  void dispose() {
    _phoneNumber.dispose();
    super.dispose();
  }

  void validatePhone(String value) {
    var regExp = RegExp(r'^[6789]\d{9}$');

    if (regExp.hasMatch(value)) {
      setState(() {
        _message = '';
      });
    } else {
      setState(() {
        _message = 'Please enter a valid number';
      });
    }
  }

  Future<void> verifyPhoneNumber(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91${_phoneNumber.text}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Auto-retrieval of SMS code completed (not needed)
        },
        verificationFailed: (FirebaseAuthException e) {
          setState(() {
            _message = 'Verification failed. ${e.message}';
          });
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            _isLoading = false;
          });
          // Redirect to OTP screen with verification ID
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => VerifyOtp(verificationID: verificationId),
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Called when the auto-retrieval of the SMS code has timed out
        },
        timeout: const Duration(seconds: 60),
      );
    } catch (e) {
      print('Error: $e');
    }
  }

  void getLogin() {
    verifyPhoneNumber(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      // resizeToAvoidBottomInset: false, // Set this to false
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Image(
                  image: AssetImage('assets/images/welcome.png'),
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  color: Colors.blue[50],
                  child: Form(
                    key: _form,
                    child: TextFormField(
                      onChanged: (value) => validatePhone(value),
                      controller: _phoneNumber,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Phone number',
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 15,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: Themes.primaryColor()),
                        ),
                        // floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                      cursorColor: Colors.grey,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(_message,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    )),
                (_message != '')
                    ? const SizedBox(height: 10)
                    : const SizedBox.shrink(),
                (!_isLoading)
                    ? InkWell(
                        onTap: getLogin,
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Themes.primaryColor()[400],
                          ),
                          child: const Text(
                            'Continue',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    : Center(
                        child: Text("Please wait..",
                            style: TextStyle(
                              color: Colors.amber[700],
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            )),
                      ),
                const SizedBox(
                  height: 20,
                ),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Don\'t have any account?',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () => {},
                  child: Container(
                    alignment: Alignment.center,
                    height: 20,
                    child: Text(
                      "Sign up now",
                      style: TextStyle(
                          color: Themes.primaryColor(),
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
