import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      appBar: AppBar(title: const Text("Staff Management")),

      /// ✅ FAB
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAddStaffSheet(context),
        child: const Icon(Icons.add),
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

                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(12),

                        /// 🔥 IMAGE
                        leading: CircleAvatar(
                          radius: 28,
                          backgroundImage: staff.image.isNotEmpty
                              ? NetworkImage(staff.image)
                              : null,
                          child: staff.image.isEmpty
                              ? const Icon(Icons.person)
                              : null,
                        ),

                        /// 🔥 NAME + DESCRIPTION
                        title: Text(
                          staff.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),

                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 4),

                            Text(
                              staff.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),

                            const SizedBox(height: 6),

                            Text(
  "Services: ${staff.serviceIds.map((id) {
    try {
      return services.firstWhere((s) => s.id == id).name;
    } catch (e) {
      return "Unknown";
    }
  }).join(", ")}",
  style: const TextStyle(fontSize: 12, color: Colors.grey),
),
                          ],
                        ),

                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            context.read<StaffBloc>().add(
                              DeleteStaffEvent(staff.id),
                            );
                          },
                        ),
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
