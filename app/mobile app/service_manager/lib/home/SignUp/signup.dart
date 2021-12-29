import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formkey = GlobalKey<FormState>();

  //function to display date picker to get the birthday input from clients
  _showDatePicker(BuildContext context) {
    DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: DateTime(1960, 1, 1),
        maxTime: DateTime(2000, 1, 1), onConfirm: (date) {
      print('confirm $date');
    }, locale: LocaleType.en);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                        //controller: #TODO,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          filled: true,
                          contentPadding: const EdgeInsets.only(
                              top: 0, bottom: 0, left: 10),
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
                        //controller: #TODO,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          filled: true,
                          contentPadding: const EdgeInsets.only(
                              top: 0, bottom: 0, left: 10),
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
                        //controller: #TODO,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          filled: true,
                          contentPadding: const EdgeInsets.only(
                              top: 0, bottom: 0, left: 10),
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
                        onInputChanged: (PhoneNumber number) => {},
                        inputDecoration: InputDecoration(
                          hintText: 'Phone Number',
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Theme.of(context).colorScheme.secondary,
                          contentPadding:
                              EdgeInsets.only(bottom: 0, top: 0, left: 10),
                        ),
                      ),
                    ),
                    //DOB input field
                    Container(
                      width: double.infinity,
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
                        child: const Text('Pick Your Birth Day'),
                      ),
                    ),
                    //password input field
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0, top: 20),
                      child: TextFormField(
                        //controller: #TODO,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          filled: true,
                          contentPadding: const EdgeInsets.only(
                              top: 0, bottom: 0, left: 10),
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
                        //controller: #TODO,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          filled: true,
                          contentPadding: const EdgeInsets.only(
                              top: 0, bottom: 0, left: 10),
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
                        //controller: #TODO,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          filled: true,
                          contentPadding: const EdgeInsets.only(
                              top: 0, bottom: 0, left: 10),
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
                          onPressed: () => {},
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
      ),
    );
  }
}
