import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dialog.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sixtystrong/core/funcation/snack_bar.dart';
import '../../../../route_name.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/phone_auth_cubit.dart';
import 'otp_page.dart';

class PhoneAuthPage extends StatefulWidget {
  const PhoneAuthPage({Key? key}) : super(key: key);

  @override
  State<PhoneAuthPage> createState() => _PhoneAuthPageState();
}

class _PhoneAuthPageState extends State<PhoneAuthPage> {
  static Country _selectedFilteredDialogCountry =
  CountryPickerUtils.getCountryByPhoneCode("91");
  String _countryCode = _selectedFilteredDialogCountry.phoneCode;
  String _phoneNumber="";

  final TextEditingController _phoneAuthController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<PhoneAuthCubit, PhoneAuthState>(
        listener: (context, phoneAuthState) {
          if (phoneAuthState is PhoneAuthSuccess) {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(RoutesName.home, (route) => false);
          }
          if (phoneAuthState is PhoneAuthFailure){
            showSnackBar(context, phoneAuthState.toString());
          }
        },
        builder: (context, phoneAuthState) {
          if (phoneAuthState is PhoneAuthSmsCodeReceived) {
            return OtpPage(
              phoneNumber: _phoneNumber,
            );
          }
          if (phoneAuthState is PhoneAuthLoading) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (phoneAuthState is PhoneAuthSuccess) {
          //  Navigator.pop(context);
            BlocProvider.of<PhoneAuthCubit>(context).isSignIn(context);
            return Container();
          }
          return _bodyWidget();
        },
      ),
    );
  }

  Widget _bodyWidget() {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
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
            const SizedBox(
              height: 30,
            ),
            ListTile(
              onTap: _openFilteredCountryPickerDialog,
              title: _buildDialogItem(_selectedFilteredDialogCountry),
            ),
            Row(
              children: <Widget>[
                Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                            width: 1.50,
                            color: Colors.black,
                          ))),
                  width: 80,
                  height: 42,
                  alignment: Alignment.center,
                  child: Text(_selectedFilteredDialogCountry.phoneCode),
                ),
                const SizedBox(
                  width: 8.0,
                ),
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: TextField(
                      controller: _phoneAuthController,
                      decoration: const InputDecoration(hintText: "Phone Number"),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: MaterialButton(
                  color: Colors.blue,
                  onPressed: _submitVerifyPhoneNumber,
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
      ),
    );
  }

  void _openFilteredCountryPickerDialog() {
    showDialog(
        context: context,
        builder: (_) => Theme(
          data: Theme.of(context).copyWith(
            primaryColor: Colors.blue,
          ),
          child: CountryPickerDialog(
            titlePadding: const EdgeInsets.all(8.0),
            searchCursorColor: Colors.black,
            searchInputDecoration: const InputDecoration(
              hintText: "Search",
            ),
            isSearchable: true,
            title: const Text("Select your phone code"),
            onValuePicked: (Country country) {
              setState(() {
                _selectedFilteredDialogCountry = country;
                _countryCode = country.phoneCode;
              });
            },
            itemBuilder: _buildDialogItem,
          ),
        ));
  }

  Widget _buildDialogItem(Country country) {
    return Container(
      height: 40,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black, width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          CountryPickerUtils.getDefaultFlagImage(country),
          const SizedBox(
            height: 8.0,
          ),
          Text("+${country.phoneCode}"),
          const SizedBox(
            height: 8.0,
          ),
          Text(country.name),
          const Spacer(),
          const Icon(Icons.arrow_drop_down)
        ],
      ),
    );
  }

  void _submitVerifyPhoneNumber() {
    if (_phoneAuthController.text.isNotEmpty) {
      _phoneNumber="+$_countryCode${_phoneAuthController.text}";
      BlocProvider.of<PhoneAuthCubit>(context).submitVerifyPhoneNumber(
        phoneNumber: _phoneNumber,
      );
    }
  }
}