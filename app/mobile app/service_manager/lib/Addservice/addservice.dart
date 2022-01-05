import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';

import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:service_manager/main.dart';

import './addtags.dart';

class AddService extends StatefulWidget {
  const AddService({Key? key}) : super(key: key);

  @override
  _AddServiceState createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  final _formkey = GlobalKey<FormState>();
  bool _showTags = false;
  List<XFile>? _imageFileList;

  final Map<String, bool> _tags = {
    "tag01": false,
    "tag02": false,
    "tag03": false,
    "tag04": false,
    "tag05": false,
    "tag06": false,
    "tag07": false,
    "tag08": false,
    "tag09": false,
    "tag10": false,
    "tag11": false,
    "tag12": false,
    "tag13": false,
    "tag14": false,
  };

  late List<String> selectedTags = [];

  //form controllers
  final _serviceNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _serviceAreaController = TextEditingController();
  late PhoneNumber _officialPhoneNum;

  //clear controllers
  void dispose() {
    super.dispose();
    _serviceNameController.dispose();
    _serviceAreaController.dispose();
    _descriptionController.dispose();
  }

  Future<bool>? isSucceed;

  //handle form submit
  Future<bool> _handleSubmit() async {
    final aToken = await secureStorage.read(key: 'accessToken');

    final List base64Images = [
      ..._imageFileList!.map((image) {
        File imageFile = File(image.path);
        List<int> imageBytes = imageFile.readAsBytesSync();
        return base64Encode(imageBytes);
      }),
    ];

    final http.Response response = await http.post(
      Uri.parse(server + 'services/'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': aToken.toString(),
      },
      body: json.encode(
        {
          'name': _serviceNameController.text,
          'description': _descriptionController.text,
          'officePhoneNum': _officialPhoneNum.toString(),
          'serviceArea': _serviceAreaController.text,
          'tags': selectedTags,
          'images': base64Images,
          'adminId': 1.toString(),
          'categoryId': 2.toString(),
        },
      ),
      encoding: Encoding.getByName("utf-8"),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Add Service Faild');
    }
  }

  @override
  Widget build(BuildContext context) {
    return (isSucceed == null) ? _buildForm() : _buildResult();
  }

  //build the form
  Widget _buildForm() {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Register New Service',
          textAlign: TextAlign.center,
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20, top: 50),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: TextFormField(
                        controller: _serviceNameController,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          filled: true,
                          contentPadding: const EdgeInsets.only(
                              top: 0, bottom: 0, left: 10),
                          fillColor: Theme.of(context).colorScheme.secondary,
                          labelText: 'Service Name',
                          labelStyle: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        maxLength: 20,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        controller: _descriptionController,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          filled: true,
                          contentPadding: const EdgeInsets.only(
                              top: 10, bottom: 10, left: 10),
                          fillColor: Theme.of(context).colorScheme.secondary,
                          labelText: 'Description',
                          labelStyle: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        maxLines: null,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: InternationalPhoneNumberInput(
                        onInputChanged: (PhoneNumber number) {
                          setState(() {
                            _officialPhoneNum = number;
                          });
                        },
                        inputDecoration: InputDecoration(
                          hintText: 'Official Phone Number',
                          border: const OutlineInputBorder(),
                          filled: true,
                          fillColor: Theme.of(context).colorScheme.secondary,
                          contentPadding: const EdgeInsets.only(
                              bottom: 0, top: 0, left: 10),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: TextFormField(
                        controller: _serviceAreaController,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          filled: true,
                          contentPadding: const EdgeInsets.only(
                              top: 0, bottom: 0, left: 10),
                          fillColor: Theme.of(context).colorScheme.secondary,
                          labelText: 'Service Area',
                          labelStyle: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    //if tags are selected display them
                    if (selectedTags.isNotEmpty) _buildChips(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _showTags = true;
                          });
                        },
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.label),
                            Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Text('Add Tags'),
                            ),
                          ],
                        ),
                      ),
                    ),

                    //if images are selected display them
                    if (_imageFileList != null && _imageFileList!.isNotEmpty)
                      _showImages(),
                    ElevatedButton(
                      onPressed: _imgFromGallery,
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.upload),
                          Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Text('Upload Photos'),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isSucceed = _handleSubmit();
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.save),
                            Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Text('Save'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (_showTags)
            AddTags(
              tags: _tags,
              handleSubmit: handleTagSubmit,
              hideTags: hideTags,
            )
        ],
      ),
    );
  }

  Widget _buildChips() {
    return Wrap(
      spacing: 6.0,
      runSpacing: 1.0,
      children: [
        ...selectedTags.map((tag) {
          return Chip(
            deleteIcon: const Icon(Icons.close),
            onDeleted: () {
              setState(() {
                _tags[tag] = false;
              });
              selectedTags.remove(tag);
            },
            label: Text(tag),
          );
        }),
      ],
    );
  }

  //build the result
  Widget _buildResult() {
    return FutureBuilder(
      future: isSucceed,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            body: Container(
              height: double.infinity,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Service Created'),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('back'),
                  ),
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Container(
              height: double.infinity,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Service Creation Failed'),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('back'),
                  ),
                ],
              ),
            ),
          );
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  //create the list of selected tags
  handleTagSubmit() {
    selectedTags.clear();
    _tags.forEach((key, value) {
      if (value == true) {
        selectedTags.add(key);
      }
    });
  }

  //hide the tag selecting widget
  hideTags() {
    setState(() {
      _showTags = false;
    });
  }

  _imgFromGallery() async {
    List<XFile>? images = await ImagePicker().pickMultiImage(imageQuality: 50);

    setState(() {
      _imageFileList = images;
    });
  }

  Widget _showImages() {
    return Wrap(
      children: [
        ..._imageFileList!.map(
          (image) {
            return Padding(
              padding: const EdgeInsets.all(2.0),
              child: Image.file(
                File(image.path),
                width: 100,
                height: 100,
                fit: BoxFit.fill,
              ),
            );
          },
        ),
      ],
    );
  }
}
