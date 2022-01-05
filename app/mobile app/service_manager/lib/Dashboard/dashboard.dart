import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:service_manager/main.dart';
import './newsfeed.dart';
import './searchbar.dart';
import './sidemenuheader.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String name = 'John Doe';
  String email = 'johndoe@gamil.com';
  String imageurl =
      'https://avatars0.githubusercontent.com/u/8264639?s=460&v=4';
  int notificationCount = 0;
  int serviceNotificationCount = 0;
  int bookingNotificationCount = 0;
  int reviewNotificationCount = 0;

  final topAdds = {
    {
      'id': 1,
      'sName': 'Full Stack Developer',
      'name': 'Pubudu Bandara',
      'description': 'This is the service description',
      'imageURL': 'https://i.ytimg.com/vi/UoCnsh6x2ls/maxresdefault.jpg',
      'profilePhoto':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTIE1sk3B_RH39yFFqV4S_RUya1lw0tOv8GMg&usqp=CAU',
      'rating': 4.2,
    },
    {
      'id': 2,
      'sName': 'Welder',
      'name': 'Hansa Alahakoon',
      'description': 'This is the service description',
      'imageURL':
          'https://www.goodshomedesign.com/wp-content/uploads/2015/09/amazing-welding-skills.jpg',
      'profilePhoto':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQDO_dqCXeNSO5cLDJ1dN8BtCykL7F60I0Og&usqp=CAU',
      'rating': 3.3,
    },
    {
      'id': 3,
      'sName': 'Chef',
      'name': 'Pubilis Silva',
      'description': 'This is the service description',
      'imageURL':
          'https://cdn.britannica.com/67/154467-131-8E13B7BD/Cajun-dish.jpg',
      'profilePhoto':
          'https://nationaltoday.com/wp-content/uploads/2021/07/shutterstock_1518533924-min.jpg',
      'rating': 5,
    },
    {
      'id': 4,
      'sName': 'Web Developer',
      'name': 'Achintha Harshamal',
      'description': 'This is the service description',
      'imageURL':
          'https://cdn.searchenginejournal.com/wp-content/uploads/2019/12/5-ways-seo-web-design-go-together-5e2945dd5df37.png',
      'profilePhoto':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTU53EcOIyxE7pOZJBvGHJGbDk39EYxvOhbdw&usqp=CAU',
      'rating': 4.0,
    },
  };

  late Future<dynamic> data;

  Future<dynamic> _fetchData() async {
    //read the access token from the secure storage
    final aToken = await secureStorage.read(key: 'accessToken');

    final http.Response response = await http.get(
      Uri.parse(server + 'home/feed'),
      headers: {'x-auth-token': aToken.toString()},
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 500) {
      throw Exception('Server Error');
    } else if (response.statusCode == 401) {
      throw Exception('Token Invalid');
    } else {
      throw Exception('Unkmown error');
    }
  }

  //this method is called before the build method in this widget
  //it is only called only once
  //data need to build the dashboard is fetched by calling _fetchData function
  @override
  void initState() {
    super.initState();
    data = _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    //this futur builder will render the dashboard if data is fetched from server,
    //else there will be a error message
    return FutureBuilder(
      future: data,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _buildDashboard();
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Data Fetching Faild: ${snapshot.error}'),
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

  //this function is for return the dashboard
  Widget _buildDashboard() {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => print('Bell icon pressed'),
            icon: _buildNotificationIcon(),
          ),
          IconButton(
            onPressed: () => print('Profile Icon pressed'),
            icon: const Icon(Icons.person),
          )
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
              child: SideMenuHeader(
                name: name,
                imageURL: imageurl,
                email: email,
              ),
            ),
            const ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('My Profile'),
            ),
            ListTile(
              leading: const Icon(Icons.supervised_user_circle),
              trailing: _buildMenuNotification(serviceNotificationCount),
              title: const Text('My Services'),
            ),
            ListTile(
              leading: const Icon(Icons.book_online),
              trailing: _buildMenuNotification(bookingNotificationCount),
              title: const Text('My Bookings'),
            ),
            ListTile(
              leading: const Icon(Icons.reviews),
              trailing: _buildMenuNotification(reviewNotificationCount),
              title: const Text('To Be Reviewed'),
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
          const SearchBar(),
          Expanded(
            child: NewsFeed(
              advertisments: topAdds,
            ),
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
              onPressed: () {
                Navigator.of(context).pushNamed(
                  '/addservice',
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [Icon(Icons.add), Text('Add New Service')],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationIcon() {
    if (notificationCount > 0) {
      return Stack(
        children: [
          const Icon(Icons.notifications),
          Positioned(
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(6),
              ),
              constraints: const BoxConstraints(
                minWidth: 12,
                minHeight: 12,
              ),
              child: Center(
                child: Text(
                  notificationCount.toString(),
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return const Icon(Icons.notifications);
    }
  }

  Widget _buildMenuNotification(int count) {
    if (count > 0) {
      return Container(
        child: Center(
          child: Text(
            count.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ),
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(6),
        ),
        constraints: const BoxConstraints(
          minWidth: 12,
          minHeight: 12,
          maxWidth: 25,
          maxHeight: 14,
        ),
      );
    } else {
      return Text('');
    }
  }
}
