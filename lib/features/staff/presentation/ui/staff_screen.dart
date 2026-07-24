import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_admin/core/colors.dart';
import 'package:salon_admin/features/services/presentation/bloc/service_bloc.dart';
import 'package:salon_admin/features/staff/presentation/bloc/staff_bloc.dart';
import 'package:salon_admin/features/staff/presentation/widgets/staff_modal.dart';

class StaffScreen extends StatefulWidget {
  const StaffScreen({super.key});

  @override
  State<StaffScreen> createState() => _StaffScreenState();
}

class _StaffScreenState extends State<StaffScreen> {
  @override
  void initState() {
    super.initState();

    /// Load both
    context.read<ServiceBloc>().add(LoadServices());
    context.read<StaffBloc>().add(LoadStaffEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Staff Management",style: TextStyle(color:ConstantColors.secondary),),centerTitle: true,backgroundColor: ConstantColors.primary,),

      /// ✅ FAB
      floatingActionButton: FloatingActionButton(
        backgroundColor: ConstantColors.primary,
        onPressed: () => showAddStaffSheet(context),
        child: const Icon(Icons.add,color: ConstantColors.secondary),
      ),

      /// ✅ STAFF LIST
      body: BlocBuilder<ServiceBloc, ServiceState>(
        builder: (context, serviceState) {
          if (serviceState is! ServiceLoaded) {
            return const Center(child: CircularProgressIndicator());
          }
          final services = serviceState.services;
          return BlocBuilder<StaffBloc, StaffState>(
            builder: (context, state) {
              if (state is StaffLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              
              if (state is StaffLoaded) {
                if (state.staffList.isEmpty) {
                  return const Center(child: Text("No staff added"));
                }

                return ListView.builder(
                  itemCount: state.staffList.length,
                  itemBuilder: (context, index) {
                    final staff = state.staffList[index];

                    return Container(
  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  padding: const EdgeInsets.all(14),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.shade300,
        blurRadius: 6,
        offset: const Offset(0, 3),
      ),
    ],
  ),
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      /// 🔹 PROFILE IMAGE
      CircleAvatar(
        radius: 44,
        backgroundColor: Colors.grey[200],
        backgroundImage: staff.image.isNotEmpty
            ? NetworkImage(staff.image)
            : null,
        child: staff.image.isEmpty
            ? const Icon(Icons.person, size: 26)
            : null,
      ),

      const SizedBox(width: 20),

      /// 🔹 DETAILS SECTION
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// NAME + DELETE BUTTON ROW
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    staff.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    context.read<StaffBloc>().add(
                      DeleteStaffEvent(staff.id),
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 3),

            /// DESCRIPTION
            Text(
              staff.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 8),

            /// 🔥 SERVICES AS CHIPS (same logic, better UI)
            Wrap(
              spacing: 6,
              runSpacing: 4,
              children: staff.serviceIds.map((id) {
                String serviceName;

                try {
                  serviceName =
                      services.firstWhere((s) => s.id == id).name;
                } catch (e) {
                  serviceName = "Unknown";
                }

                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    serviceName,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.blue,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    ],
  ),
);
                  },
                );
              }

              return const SizedBox();
            },
          );
        },
      ),
    );
  }

  /// 🔥 BOTTOM SHEET
}
