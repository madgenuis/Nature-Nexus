import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/chatbot.dart';
import 'package:untitled/recycle_material.dart';
import 'package:untitled/upload_scree.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'feedpost.dart';
import 'user_points.dart';
class CustomNavigationExample extends StatefulWidget {
  const CustomNavigationExample({super.key});

  @override
  State<CustomNavigationExample> createState() => _CustomNavigationExampleState();
}

class _CustomNavigationExampleState extends State<CustomNavigationExample> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: (currentPageIndex==2||currentPageIndex==1||currentPageIndex==3)?null:AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Image.asset(
          'images/image3.png',
          fit: BoxFit.contain,
          height: 200,
          width: 190,
        ),
        backgroundColor: Colors.transparent,
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.lightGreen.shade500,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Badge(child: Icon(Icons.add)),
            label: 'Add',
          ),
          NavigationDestination(
            icon: Badge(
              label: Text('2'),
              child: Icon(Icons.messenger_sharp),
            ),
            label: 'Messages',
          ),
          NavigationDestination(icon: Icon(Icons.feed), label: 'Reports'),
          NavigationDestination(icon: Icon(Icons.eco), label: 'Recycle')

        ],
      ),
      body: <Widget>[
        const CustomMyHome(),
        const CustomMyUploadScreen(),
        const CustomIframeScreen(),
        FeedPost(),
        const Recycle()
      ][currentPageIndex],
    );
  }
}
class CustomMyHome extends StatelessWidget {
  const CustomMyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Your existing content here
              Row(
                children: [
                  Expanded(
                    child: FirstRowCardBigger(),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                children: [
                  Expanded(
                    child: CardWidget(
                      headingText: "Reports",
                      subheadingText: "Report problems and request service",
                      iconData: Icons.report,
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: CardWidget(
                      headingText: "Find",
                      subheadingText: "Look-up collection schedules and providers",
                      iconData: Icons.find_in_page,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  Expanded(
                    child: CardWidget(
                      headingText: "Learn",
                      subheadingText: "Zero waste to landfill education resources",
                      iconData: Icons.book,
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: CardWidget(
                      headingText: "Marketplace",
                      subheadingText: "Buy, sell, or donate recyclable materials",
                      iconData: Icons.eco,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Image.asset(
            'images/bottom_main_home.png',
            height: 120,
            width: 120,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}


class FirstRowCardBigger extends StatelessWidget {
  const FirstRowCardBigger({super.key});

  @override
  Widget build(BuildContext context) {
    User? _user = FirebaseAuth.instance.currentUser;
    var userPointsProvider = Provider.of<UserPointsProvider>(context);
    int userPoints = userPointsProvider.userPoints;
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.person),
            title:  Text("Hi, ${_user?.displayName}"),
            subtitle: Text("Your Points: $userPoints"),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("SAVE THE CARBON FOOTPRINTS NOW")
              ],
            ),
          ),
        ],
      ),
    );

  }
}


class CardWidget extends StatelessWidget {
  final String headingText;
  final String subheadingText;
  final IconData iconData;

  const CardWidget({
    Key? key,
    required this.headingText,
    required this.subheadingText,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 160,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          print('Card tapped');
        },
        child: Card(
          color: Colors.lightGreen.shade500,
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(iconData, size: 32, color: Colors.white60,),
                Text(
                  headingText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Center(
                  child: Text(
                    subheadingText,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

  }
}
