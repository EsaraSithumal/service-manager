import 'package:flutter/material.dart';
import './newsfeed.dart';
import './searchbar.dart';
import './sidemenuheader.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final name = 'John Doe';
  final email = 'johndoe@gamil.com';
  final imageurl = 'https://avatars0.githubusercontent.com/u/8264639?s=460&v=4';

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
      'name': 'John Cena',
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
              child: SideMenuHeader(
                name: name,
                imageURL: imageurl,
                email: email,
              ),
            ),
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
              onPressed: () => print('Add service button pressed'),
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
}
