import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'apps.dart';
import 'books.dart';
import 'games.dart';
import 'movies.dart';
import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(title: 'Crasher App'),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedIndex = 0;
  List<Widget> listWidgets = [Home(), Games(), MyApps(), Movies(), Books()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.teal,
      ),
      body: listWidgets[selectedIndex],
      bottomNavigationBar: ConvexAppBar.badge(
        const {3: '21+'},
        items: const [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.games, title: 'Games'),
          TabItem(icon: Icons.apps, title: 'Apps'),
          TabItem(icon: Icons.movie, title: 'Movies'),
          TabItem(icon: Icons.book, title: 'Books'),
        ],
        onTap: onItemTapped,
        activeColor: Colors.amber,
        backgroundColor: Colors.teal,
      ),
    );
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
