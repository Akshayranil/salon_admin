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
  final controller = TextEditingController();
  List<String> selectedServices = [];

  @override
  void initState() {
    super.initState();

    // Load services when screen opens
    context.read<ServiceBloc>().add(LoadServices());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Staff")),

      body: BlocBuilder<ServiceBloc, ServiceState>(
        builder: (context, state) {

          /// 🔄 LOADING
          if (state is ServiceLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          /// ✅ LOADED
          if (state is ServiceLoaded) {
            final services = state.services;

            return Column(
              children: [
                /// NAME FIELD
                TextField(
                  controller: controller,
                  decoration: const InputDecoration(labelText: "Name"),
                ),

                /// SERVICES LIST
                Expanded(
                  child: ListView(
                    children: services.map((service) {
                      return CheckboxListTile(
                        title: Text(service.name),
                        value: selectedServices.contains(service.id),
                        onChanged: (val) {
                          setState(() {
                            val!
                                ? selectedServices.add(service.id)
                                : selectedServices.remove(service.id);
                          });
                        },
                      );
                    }).toList(),
                  ),
                ),

                /// SAVE BUTTON
                ElevatedButton(
                  onPressed: () {
                    context.read<StaffBloc>().add(
                          AddStaffEvent(controller.text, selectedServices),
                        );

                    Navigator.pop(context);
                  },
                  child: const Text("Save"),
                )
              ],
            );
          }

          /// ❌ FALLBACK
          return const Center(child: Text("No services found"));
        },
      ),
    );
  }
}