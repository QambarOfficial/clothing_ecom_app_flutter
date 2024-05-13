import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../screens/home.dart';
import '../screens/search.dart';
import '../screens/explore.dart';
import '../screens/settings.dart';
import '../screens/mail.dart';
import '../screens/profile.dart';
import '../screens/cart.dart';
import '../utils/constants.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  final List<Widget> _screens = [
    const Home(),
    const Search(),
    const Explore(),
    const Settings(),
    const MailScreen(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _buildAppBarTitle(),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(
              Icons.person_outline,
              size: 35,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: _buildAppBarActions(),
      ),
      drawer: const ProfileDrawer(),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: _screens,
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildAppBarTitle() {
    return _selectedIndex == 1
        ? const Text("Search",
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black))
        : const Text("FASHAN by qambar",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black));
  }

  // Widget _buildProfileButton() {
  //   return IconButton(
  //     icon: const Icon(LineIcons.user, color: Colors.black, size: 30),
  //     onPressed: () => Navigator.push(
  //         context, MaterialPageRoute(builder: (context) => const Profile())),
  //   );
  // }

  List<Widget> _buildAppBarActions() {
    return [
      IconButton(
        icon: Icon(
            _selectedIndex == 1 ? LineIcons.searchMinus : LineIcons.search,
            color: Colors.black,
            size: 30),
        onPressed: () => _pageController.jumpToPage(1),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 10),
        child: IconButton(
          icon:
              const Icon(LineIcons.shoppingBag, color: Colors.black, size: 30),
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Cart())),
        ),
      ),
    ];
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
        BottomNavigationBarItem(icon: Icon(Icons.explore), label: "Explore"),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
        BottomNavigationBarItem(icon: Icon(Icons.mail), label: "Mail"),
      ],
      currentIndex: _selectedIndex,
      onTap: (index) {
        _pageController.jumpToPage(index);
      },
      type: BottomNavigationBarType.fixed,
      selectedItemColor: primaryColor,
    );
  }
}
