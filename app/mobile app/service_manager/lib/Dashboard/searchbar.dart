import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
          decoration: BoxDecoration(
              color: Colors.brown[100],
              borderRadius: const BorderRadius.all(Radius.circular(50)),
              border: Border.all(color: Theme.of(context).colorScheme.primary)),
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(top: 2, bottom: 2, left: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search',
                        hintStyle: TextStyle(
                          fontSize: 20,
                        )),
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () => {print('Serch button Tapped')},
                    icon: const Icon(Icons.search)),
              ],
            ),
          )),
    );
  }
}
