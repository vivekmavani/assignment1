import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../cubit/phone_auth_cubit.dart';

class OtpPage extends StatefulWidget {
  final String phoneNumber;
   const OtpPage({Key? key,required this.phoneNumber}) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  int secondsRemaining = 30;
  bool enableResend = false;
  late Timer timer;
  String get _phoneNumber => widget.phoneNumber;
  final TextEditingController _pinCodeController=TextEditingController();

  @override
  initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        setState(() {
          enableResend = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return   Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        children:[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:const [
              Text(""),
              Text(
                "Verify your phone number",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              Icon(Icons.more_vert)
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            "75 will send and SMS message to verify your phone number. Enter your country code and phone number:",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          _pinCodeWidget(context),
          TextButton(
            child:  const Text('Resend Code'),
            onPressed: enableResend ? _resendCode : null,
          ),
          Text(
            'after $secondsRemaining seconds',
            style: const TextStyle(color: Colors.black, fontSize: 10),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: MaterialButton(
                color: Colors.black,
                onPressed: () =>_submitSmsCode(context),
                child: const Text(
                  "Next",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _pinCodeWidget(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: <Widget>[
          PinCodeTextField(
            controller: _pinCodeController,
            length: 6,
            backgroundColor: Colors.transparent,
            autoDisposeControllers: false,
            onChanged: (pinCode){
              if (kDebugMode) {
                print(pinCode);
              }
            }, appContext: context,
          ),
          const Text("Enter your 6 digit code")
        ],
      ),
    );
  }

  void _submitSmsCode(BuildContext context){
    if (_pinCodeController.text.isNotEmpty){
      BlocProvider.of<PhoneAuthCubit>(context)
          .submitSmsCode(context,smsCode: _pinCodeController.text);
    }
  }
  void _resendCode() {
    //other code here
    BlocProvider.of<PhoneAuthCubit>(context).submitVerifyPhoneNumber(
      phoneNumber: _phoneNumber,
    );
    setState((){
      secondsRemaining = 30;
      enableResend = false;
    });
  }

  @override
  dispose(){
    timer.cancel();
    super.dispose();
  }
}
