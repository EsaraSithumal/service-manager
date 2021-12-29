import 'package:flutter/material.dart';
import './newsfeed.dart';
import './searchbar.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  final name = 'John Doe';

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () => print('Bell icon pressed'),
                icon: const Icon(Icons.notifications)),
            IconButton(
                onPressed: () => print('Profile icon pressed'),
                icon: const Icon(Icons.person))
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: Column(
                    children: [Icon(Icons.account_circle), Text(widget.name)],
                  )),
              const ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('MY Profile'),
              ),
              const ListTile(
                leading: Icon(Icons.supervised_user_circle),
                title: Text('My Services'),
              ),
              const ListTile(
                leading: Icon(Icons.book_online),
                title: Text('My Bookings'),
              ),
              const ListTile(
                leading: Icon(Icons.reviews),
                title: Text('To Be Reviewed'),
              ),
              const ListTile(
                leading: Icon(Icons.logout),
                title: Text('Sign Out'),
              )
            ],
          ),
        ),
        body: Column(
          children: [
            SearchBar(),
            const Expanded(
              child: NewsFeed(),
            ),
            Container(
                width: double.infinity,
                child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                        (Set<MaterialState> states) {
                          return ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(0));
                        },
                      ),
                    ),
                    onPressed: () => print('Add service button pressed'),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Icon(Icons.add),
                          Text('Add New Service')
                        ]))),
          ],
        ));
  }
}
