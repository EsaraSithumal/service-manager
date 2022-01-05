import 'package:flutter/material.dart';

class AddTags extends StatefulWidget {
  final Map<String, bool> tags;
  final VoidCallback handleSubmit;
  final VoidCallback hideTags;

  const AddTags({
    required this.tags,
    required this.handleSubmit,
    required this.hideTags,
    Key? key,
  }) : super(key: key);

  @override
  State<AddTags> createState() => _AddTagsState();
}

class _AddTagsState extends State<AddTags> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(150, 0, 0, 0),
      margin: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
      ),
      elevation: 0,
      child: Stack(
        children: [
          Positioned.fill(
            child: Align(
              alignment: Alignment.topCenter,
              child: IconButton(
                iconSize: 30,
                onPressed: widget.hideTags,
                icon: Icon(Icons.close),
                color: Colors.white,
              ),
            ),
          ),
          Card(
            elevation: 10,
            margin: const EdgeInsets.all(50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    ...widget.tags.keys.map(
                      (String key) {
                        return CheckboxListTile(
                          title: Text(key),
                          value: widget.tags[key],
                          onChanged: (bool? value) {
                            setState(() {
                              widget.tags[key] = value!;
                            });
                          },
                        );
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: TextButton(
                              child: Text('Cancle'),
                              onPressed: widget.hideTags,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: TextButton(
                              child: Text('Done'),
                              onPressed: () {
                                widget.handleSubmit();
                                widget.hideTags();
                              },
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
