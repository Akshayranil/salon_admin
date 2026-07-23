
import 'package:flutter/material.dart';
import 'package:salon_admin/core/colors.dart';
import 'package:salon_admin/features/bookings/presentation/ui/bookings_screen.dart';
import 'package:salon_admin/features/dashboard/presentation/ui/dashboard_screen.dart';
import 'package:salon_admin/features/profile/presentation/ui/profile_screen.dart';
import 'package:salon_admin/features/services/presentation/ui/service_screen.dart';
import 'package:salon_admin/features/staff/presentation/ui/staff_screen.dart';


class CustomNavigationbar extends StatelessWidget {
  final int? tabindex;
  const CustomNavigationbar({super.key,this.tabindex});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: tabindex??0,
      length: 4,
      child: Scaffold(
        bottomNavigationBar: Container(
          color: ConstantColors.primary,
          height: 70,
          child: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home), text: "Dashboard"),
              
              Tab(icon: Icon(Icons.miscellaneous_services), text: "Services"),
              Tab(icon: Icon(Icons.badge), text: "Staffs"),
              Tab(icon: Icon(Icons.person), text: "Profile"),
            ],
            indicatorColor: Colors.transparent,
            labelColor: ConstantColors.secondary,
            unselectedLabelColor: Colors.white70,
          ),
        ),
        body: TabBarView(
          children: [
            DashboardScreen(),
            
            ServiceScreen(),
            StaffScreen(),
            ProfileScreen(),
          ],
        ),
      ),
    );
  }
}
