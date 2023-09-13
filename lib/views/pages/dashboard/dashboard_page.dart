

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myplanet/theme.dart';
import 'package:myplanet/views/pages/community/community_page.dart';
import 'package:myplanet/views/pages/dashboard/dashboard_controller.dart';
import 'package:myplanet/views/pages/elearning/elearning_page.dart';
import 'package:myplanet/views/pages/home/home_page.dart';
import 'package:myplanet/views/pages/podtret/podtret_page.dart';
import 'package:myplanet/views/pages/profile/profile_page.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({super.key});
  final _buildBody = <Widget>[HomePage(), const ElearningPage(), const PodtretPage(), const CommunityPage(), const ProfilePage()];
  

  @override
  Widget build(BuildContext context) {

    return GetBuilder<DashboardController>(
      init: DashboardController(),
      builder: (controller) {
        return Scaffold(
          body: _buildBody[controller.tabIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: controller.changeTabIndex,
            currentIndex: controller.tabIndex,
            selectedItemColor: blackColor,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            items: [
              _bottomNavigationBarItem(
                imagePath: 'assets/icons/home_icon.png', 
                label: 'Home'
              ),
              _bottomNavigationBarItem(
                imagePath: 'assets/icons/elearning_icon.png', 
                label: 'Elearning'
              ),
              _bottomNavigationBarItem(
                imagePath: 'assets/icons/podtret_icon.png', 
                label: 'Podtret'
              ),
              _bottomNavigationBarItem(
                imagePath: 'assets/icons/community_icon.png', 
                label: 'Community'
              ),
              _bottomNavigationBarItem(
                imagePath: 'assets/icons/home_icon.png', 
                label: 'Profile'
              ),
            ],
          ),
          
        );
      }
    );
  }

  _bottomNavigationBarItem({required String imagePath, required String label}) {
    return BottomNavigationBarItem(
      icon: Center(
        child: ZoomTapAnimation(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                imagePath,
                color: blackColor,
                height: label == 'Community' ? 20 : 25,
                // width: 25,
              ),
              SizedBox(height: label == 'Community' ? 15 : 10,),
            ],
          ),
        ),
      ),
      activeIcon: Center(
        child: ZoomTapAnimation(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                imagePath,
                color: primaryColor,
                height: label == 'Community' ? 25 : 30,
                // width: 25,
              ),
              SizedBox(height: label == 'Community' ? 15 : 10,),
            ],
          ),
        ),
      ),
      label: label,
    );
  }


}