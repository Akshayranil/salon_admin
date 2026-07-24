import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salon_admin/core/colors.dart';
import 'package:salon_admin/features/services/presentation/bloc/service_bloc.dart';
import 'package:salon_admin/features/staff/presentation/bloc/staff_bloc.dart';

showAddStaffSheet(BuildContext context) {
  final nameController = TextEditingController();
  final descController = TextEditingController();

  List<String> selectedServices = [];
  String? imagePath;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setModalState) {
          return Container(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
            ),
            child: BlocBuilder<ServiceBloc, ServiceState>(
              builder: (context, state) {
                if (state is ServiceLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is ServiceLoaded) {
                  final services = state.services;

                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: Text(
                            "Add Staff",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        /// 🔥 IMAGE PICKER
                        Center(
                          child: GestureDetector(
                            onTap: () async {
                              
                              final picked = await ImagePicker().pickImage(source: ImageSource.gallery);

                              setModalState(() {
                                imagePath = picked?.path;
                              });
                            },
                            child: CircleAvatar(
                              radius: 45,
                              backgroundColor: Colors.grey[200],
                              backgroundImage: imagePath != null
                                  ? FileImage(File(imagePath!))
                                  : null,
                              child: imagePath == null
                                  ? const Icon(Icons.camera_alt, size: 30)
                                  : null,
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        /// NAME
                        TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            labelText: "Staff Name",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),

                        const SizedBox(height: 15),

                        /// DESCRIPTION
                        TextField(
                          controller: descController,
                          maxLines: 3,
                          decoration: InputDecoration(
                            labelText: "Description",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),

                        const SizedBox(height: 15),

                        const Text(
                          "Select Services",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),

                        const SizedBox(height: 10),

                        SizedBox(
                          height: 180,
                          child: ListView(
                            children: services.map((service) {
                              return CheckboxListTile(
                                title: Text(service.name),
                                value: selectedServices.contains(service.id),
                                onChanged: (val) {
                                  setModalState(() {
                                    val!
                                        ? selectedServices.add(service.id)
                                        : selectedServices.remove(service.id);
                                  });
                                },
                              );
                            }).toList(),
                          ),
                        ),

                        const SizedBox(height: 20),

                        /// SAVE BUTTON
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ConstantColors.primary,
                              foregroundColor: ConstantColors.secondary,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            
                            onPressed: () {
                              context.read<StaffBloc>().add(
                                    AddStaffEvent(
                                      nameController.text,
                                      imagePath ?? "",
                                     
                                      descController.text,
                                       selectedServices,
                                    ),
                                  );

                              Navigator.pop(context);
                            },
                            child: const Text("Save"),
                          ),
                        )
                      ],
                    ),
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