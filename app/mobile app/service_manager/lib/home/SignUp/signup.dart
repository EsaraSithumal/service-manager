import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:service_manager/main.dart';

import './signupresult.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formkey = GlobalKey<FormState>();
  Future<bool>? isSucceed;

  //form controllers
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _pwController = TextEditingController();
  final _cpwController = TextEditingController();
  final _addressController = TextEditingController();

  //clear cotrollers when the widget is creating
  @override
  void dispose() {
    super.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _pwController.dispose();
    _cpwController.dispose();
    _addressController.dispose();
  }

  DateTime _dateOfBirth = DateTime(2000, 1, 1);
  late PhoneNumber _phoneNum;

  String _DOB = 'YYYY-MM-DD';

  //function to display date picker to get the birthday input from clients
  _showDatePicker(BuildContext context) {
    DatePicker.showDatePicker(context,
        showTitleActions: true,
        currentTime: _dateOfBirth,
        minTime: DateTime(1960, 1, 1),
        maxTime: DateTime(2000, 1, 1), onConfirm: (date) {
      var fdate = DateTime.parse(date.toString());
      setState(() {
        _dateOfBirth = date;
        _DOB = "${fdate.year}-${fdate.month}-${fdate.day}";
      });
    }, locale: LocaleType.en);
  }

  Future<bool> _handleSubmit() async {
    final response = await http.post(
      Uri.parse(server + 'auth/signup'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(
        <String, dynamic>{
          'first_name': _firstNameController.text,
          'last_name': _lastNameController.text,
          'email': _emailController.text,
          'phone_number': _phoneNum.toString(),
          'date_of_birth': _DOB,
          'password': _pwController.text,
          'address': _addressController.text,
        },
      ),
      encoding: Encoding.getByName("utf-8"),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Failed to create user.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //if isSucceed is null the signup form will rendered
      //else the response will rendered
      body: (isSucceed == null)
          ? buildForm()
          : SignUpResult(
              isSucceed: isSucceed,
            ),
    );
  }

  //form for the registration
  SingleChildScrollView buildForm() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 50.0, left: 20, right: 20),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => print('signup with google pressed'),
                child: const Text('Signup with google'),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: Text('or'),
            ),
            Form(
              key: _formkey,
              child: Column(
                children: [
                  //first name input field
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: TextFormField(
                      controller: _firstNameController,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        filled: true,
                        contentPadding:
                            const EdgeInsets.only(top: 0, bottom: 0, left: 10),
                        fillColor: Theme.of(context).colorScheme.secondary,
                        labelText: 'First Name',
                        labelStyle: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                  //last name input field
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: TextFormField(
                      controller: _lastNameController,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        filled: true,
                        contentPadding:
                            const EdgeInsets.only(top: 0, bottom: 0, left: 10),
                        fillColor: Theme.of(context).colorScheme.secondary,
                        labelText: 'Last Name',
                        labelStyle: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                  //email input field
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        filled: true,
                        contentPadding:
                            const EdgeInsets.only(top: 0, bottom: 0, left: 10),
                        fillColor: Theme.of(context).colorScheme.secondary,
                        labelText: 'Email',
                        labelStyle: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                  //Phone Number input field
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: InternationalPhoneNumberInput(
                      onInputChanged: (PhoneNumber number) {
                        setState(() {
                          _phoneNum = number;
                        });
                      },
                      inputDecoration: InputDecoration(
                        hintText: 'Phone Number',
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.secondary,
                        contentPadding:
                            const EdgeInsets.only(bottom: 0, top: 0, left: 10),
                      ),
                    ),
                  ),
                  //DOB input field
                  Row(
                    children: [
                      const Text(
                        'Date Of Birth : ',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 15, bottom: 15, left: 10, right: 10),
                          child: Text(
                            _DOB,
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  return Theme.of(context)
                                      .colorScheme
                                      .secondaryVariant;
                                },
                              ),
                            ),
                            onPressed: () => _showDatePicker(context),
                            child: const Text('Pick Your DOB'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  //password input field
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0, top: 20),
                    child: TextFormField(
                      controller: _pwController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        filled: true,
                        contentPadding:
                            const EdgeInsets.only(top: 0, bottom: 0, left: 10),
                        fillColor: Theme.of(context).colorScheme.secondary,
                        labelText: 'Password',
                        labelStyle: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                  //confirm password input field
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: TextFormField(
                      controller: _cpwController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        filled: true,
                        contentPadding:
                            const EdgeInsets.only(top: 0, bottom: 0, left: 10),
                        fillColor: Theme.of(context).colorScheme.secondary,
                        labelText: 'Confirm Password',
                        labelStyle: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                  //address input field
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: TextFormField(
                      controller: _addressController,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        filled: true,
                        contentPadding:
                            const EdgeInsets.only(top: 0, bottom: 0, left: 10),
                        fillColor: Theme.of(context).colorScheme.secondary,
                        labelText: 'Address',
                        labelStyle: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 20),
                      child: ElevatedButton(
                        onPressed: () => {
                          setState(
                            () => {
                              //update the state of the future
                              isSucceed = _handleSubmit(),
                            },
                          ),
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.app_registration),
                            Text('Sign Up'),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
