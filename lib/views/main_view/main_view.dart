import 'package:flutter/material.dart';
import 'package:i_charm/views/views.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  late int _selectedPageIndex;
  late List<Widget> _pages;
  PageController? _pageController;

  @override
  void initState() {
    super.initState();
    _selectedPageIndex = 0;
    _pageController = PageController(initialPage: _selectedPageIndex);
    _pages = [
      const HomeView(),
      const ShopView(),
      const ProfileView(),
    ];
  }

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  void _onSelectedMenu(int index) {
    setState(() {
      _selectedPageIndex = index;
      _pageController!.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _pages,
        physics: const NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: _onSelectedMenu,
        items: const [
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.home),
            icon: Icon(Icons.home),
            label: 'หน้าหลัก',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.shopping_cart),
            icon: Icon(Icons.shopping_cart),
            label: 'ซื้อสินค้า',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.person),
            icon: Icon(Icons.person),
            label: 'โปรไฟล์',
          )
        ],
      ),
    );
  }
}
