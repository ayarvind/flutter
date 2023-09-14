import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moods/home_page.dart';
import '../constant/themes.dart';
import 'package:form_validator/form_validator.dart';

class VerifyOtp extends StatefulWidget {
  final String verificationID;
  const VerifyOtp({Key? key, required this.verificationID}) : super(key: key);
  @override
  _VerifyOtpState createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  ValidationBuilder validate =
      ValidationBuilder().required().minLength(5).maxLength(5);
  bool _isValid = false;
  bool _isVerified = false;
  TextEditingController _otpInput = TextEditingController();

  bool validateOtp(String otp) {
    if (otp.length != 6) {
      setState(() {
        _isValid = false;
      });
      return false;
    } else {
      setState(() {
        _isValid = true;
      });
    }
    return true;
  }

  Future<void> verify(otp) async {
    if (validateOtp(otp)) {
      try {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: widget.verificationID,
          smsCode: otp,
        );

        // Sign in with the credential
        await FirebaseAuth.instance.signInWithCredential(credential);

        // Redirect to the home screen after successful login
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      } catch (e) {
        print('Error verifying OTP: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Enter OTP',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Form(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextFormField(
                    onChanged: (value) => validateOtp(value),
                    maxLines: 1,
                    controller: _otpInput,
                    style: const TextStyle(
                      letterSpacing: 20,
                      fontWeight: FontWeight.bold,
                      fontSize: 21,
                    ),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: '123456',
                      counterText: null,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      border: InputBorder.none,
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () => {verify(_otpInput.text)},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Themes.primaryColor()[400],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                ),
                child: const Text(
                  'Verify',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: TextButton(
                  onPressed: () => {},
                  child: const Text(
                    "Didn't receive OTP?",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
