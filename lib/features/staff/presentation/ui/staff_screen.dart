import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_admin/features/services/presentation/bloc/service_bloc.dart';
import 'package:salon_admin/features/staff/presentation/bloc/staff_bloc.dart';

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
        onPressed: () => _showAddStaffSheet(context),
        child: const Icon(Icons.add),
      ),

      /// ✅ STAFF LIST
      body: BlocBuilder<StaffBloc, StaffState>(
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

                return ListTile(
                  title: Text(staff.name),
                  subtitle: Text("Services: ${staff.serviceIds.length}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      context.read<StaffBloc>().add(
                            DeleteStaffEvent(staff.id),
                          );
                    },
                  ),
                );
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  /// 🔥 BOTTOM SHEET
  void _showAddStaffSheet(BuildContext context) {
    final nameController = TextEditingController();
    List<String> selectedServices = [];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {

            return Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: BlocBuilder<ServiceBloc, ServiceState>(
                builder: (context, state) {

                  if (state is ServiceLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is ServiceLoaded) {
                    final services = state.services;

                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Add Staff",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),

                        const SizedBox(height: 15),

                        /// NAME
                        TextField(
                          controller: nameController,
                          decoration:
                              const InputDecoration(labelText: "Name"),
                        ),

                        const SizedBox(height: 10),

                        /// SERVICES CHECKBOX
                        SizedBox(
                          height: 200,
                          child: ListView(
                            children: services.map((service) {
                              return CheckboxListTile(
                                title: Text(service.name),
                                value: selectedServices.contains(service.id),
                                onChanged: (val) {
                                  setModalState(() {
                                    val!
                                        ? selectedServices.add(service.id)
                                        : selectedServices
                                            .remove(service.id);
                                  });
                                },
                              );
                            }).toList(),
                          ),
                        ),

                        const SizedBox(height: 20),

                        /// SAVE
                        ElevatedButton(
                          onPressed: () {
                            context.read<StaffBloc>().add(
                                  AddStaffEvent(
                                    nameController.text,
                                    selectedServices,
                                  ),
                                );

                            Navigator.pop(context); // ✅ CLOSE SHEET
                          },
                          child: const Text("Save"),
                        )
                      ],
                    );
                  }

                  return const Text("No services found");
                },
              ),
            );
          },
        );
      },
    );
  }
}