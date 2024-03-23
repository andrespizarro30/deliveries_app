import 'package:deliveries_app/controllers/cart_controller.dart';
import 'package:deliveries_app/data/repository/cart_repo.dart';
import 'package:deliveries_app/pages/cart/cart_history_page.dart';
import 'package:deliveries_app/pages/cart/cart_page.dart';
import 'package:deliveries_app/pages/home/main_food_page.dart';
import 'package:deliveries_app/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../utils/dimensions.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/small_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _selectedIndex = 0;

  late PersistentTabController _controller;

  List<Widget> _pages=[
    MainFoodPage(),
    Container(child: Center(child: Text("Next Page"))),
    CartHistoryPage(),
    Container(child: Center(child: Text("Next Next Next Page")))
  ];

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.home),
        title: ("Home"),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: Colors.redAccent,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.archivebox),
        title: ("History"),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: Colors.redAccent,
      ),
      PersistentBottomNavBarItem(
        icon: GetBuilder<CartController>(builder: (controller){
          return Stack(
            children: [
              ApplIcon(
                icon: CupertinoIcons.shopping_cart,
                iconSize: 28,
                iconColor: Colors.redAccent,
                backgroundColor: Colors.transparent,
              ),
              controller.totalItems>=1 ?
              Positioned(
                  right: 0,
                  top: 0,
                  child: ApplIcon(
                    icon: CupertinoIcons.circle,
                    size: 20,
                    iconColor: Colors.transparent,
                    backgroundColor: Colors.red.shade400,
                  )
              ) :
              Container(),
              controller.totalItems>=1 ?
              Positioned(
                right: 3,
                top: 3,
                child: SmallText(
                  text: controller.totalItems.toString(),
                  color: Colors.white,
                  size: 10,
                ),
              ) :
              Container()
            ],
          );
        }),
        title: ("Cart"),
        activeColorPrimary: AppColors.mainColor,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.person),
        title: ("Me"),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: Colors.redAccent,
      ),
    ];
  }

  void onTabNav(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = PersistentTabController(initialIndex: 0);

  }
  /*@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor: Colors.redAccent,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedFontSize: 0.0,
        unselectedFontSize: 0.0,
        currentIndex: _selectedIndex,
        onTap: onTabNav,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.archive),
              label: "History",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: "Cart"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Me"
          ),
        ],
      ),
    );
  }*/
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _pages,
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style1, // Choose the nav bar style with this property.
    );
  }
}
