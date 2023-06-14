import 'package:flutter/material.dart';
import 'package:pavigaras/presentation/cart/cart.dart';
import 'package:pavigaras/presentation/home/home.dart';
import 'package:pavigaras/presentation/profile/profile.dart';
import 'package:pavigaras/presentation/resources/assets_manager.dart';
import 'package:pavigaras/presentation/resources/colors_manager.dart';
import 'package:pavigaras/presentation/resources/font_manager.dart';
import 'package:pavigaras/presentation/resources/strings_manager.dart';
import 'package:pavigaras/presentation/resources/values_manager.dart';
import 'package:pavigaras/presentation/search/search.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _pageIndex = 0;

  final List<Widget> _tabList = [
    const HomeView(),
    const SearchView(),
    const CartView(1),
    const ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _tabList.elementAt(_pageIndex),
          Align(
            alignment: const Alignment(AppSize.s0, AppSize.s1),
            child: Padding(
                padding: const EdgeInsets.only(
                    left: AppPadding.p10,
                    right: AppPadding.p10,
                    bottom: AppPadding.p10),
                child: Container(
                  height: AppSize.s60,
                  decoration: BoxDecoration(boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: ColorManager.lightGrey,
                        blurRadius: AppSize.s5,
                        offset: const Offset(AppSize.s0, AppSize.s0_75)),
                    BoxShadow(
                        color: ColorManager.white,
                        blurRadius: AppSize.s5,
                        offset: const Offset(AppSize.s0, AppSize.s0)),
                    BoxShadow(
                        color: ColorManager.blueGreen,
                        blurRadius: AppSize.s5,
                        offset: const Offset(AppSize.s0, AppSize.s0_75))
                  ]),
                  child: ClipRRect(
                    clipBehavior: Clip.hardEdge,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(AppSize.s10),
                    ),
                    child: BottomNavigationBar(
                      backgroundColor: ColorManager.white,
                      selectedItemColor: ColorManager.darkPrimary,
                      unselectedItemColor: ColorManager.darkGrey,
                      showSelectedLabels: true,
                      showUnselectedLabels: true,
                      type: BottomNavigationBarType.fixed,
                      selectedFontSize: FontSize.f10,
                      unselectedFontSize: FontSize.f10,
                      currentIndex: _pageIndex,
                      onTap: (index) {
                        setState(() {
                          _pageIndex = index;
                        });
                      },
                      items: [
                        BottomNavigationBarItem(
                          icon: Image.asset(
                            ImageAssets.bottomNavigationHomeIcon,
                            fit: BoxFit.cover,
                            width: AppSize.s30,
                            color: ColorManager.darkGrey,
                          ), //color: Colors.orange
                          activeIcon: Image.asset(
                            ImageAssets.bottomNavigationHomeIcon,
                            fit: BoxFit.cover,
                            width: AppSize.s30,
                            color: ColorManager.darkPrimary,
                          ),
                          label: AppStrings.appTitle,
                        ),
                        BottomNavigationBarItem(
                          icon: Image.asset(
                            ImageAssets.bottomNavigationSearchIcon,
                            fit: BoxFit.cover,
                            width: AppSize.s30,
                            color: ColorManager.darkGrey,
                          ),
                          activeIcon: Image.asset(
                            ImageAssets.bottomNavigationSearchIcon,
                            fit: BoxFit.cover,
                            width: AppSize.s30,
                            color: ColorManager.darkPrimary,
                          ),
                          label: AppStrings.search,
                        ),
                        BottomNavigationBarItem(
                          icon: Image.asset(
                            ImageAssets.bottomNavigationCartIcon,
                            fit: BoxFit.cover,
                            width: AppSize.s30,
                            color: ColorManager.darkGrey,
                          ), //color: Colors.orange
                          activeIcon: Image.asset(
                            ImageAssets.bottomNavigationCartIcon,
                            fit: BoxFit.cover,
                            width: AppSize.s30,
                            color: ColorManager.darkPrimary,
                          ),
                          label: AppStrings.cart,
                        ),
                        BottomNavigationBarItem(
                          icon: Image.asset(
                            ImageAssets.bottomNavigationUserIcon,
                            fit: BoxFit.cover,
                            width: AppSize.s30,
                          ), //color: Colors.orange
                          activeIcon: Image.asset(
                            ImageAssets.bottomNavigationUserIcon,
                            fit: BoxFit.cover,
                            width: AppSize.s30,
                          ),
                          label: AppStrings.profile,
                        ),
                      ],
                    ),
                  ),
                )),
          )
        ],
      ),
    );
  }
}
