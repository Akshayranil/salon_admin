// features/services/presentation/pages/service_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_admin/features/services/domain/entity/service_entity.dart';

import '../bloc/service_bloc.dart';

class ServiceScreen extends StatelessWidget {
  ServiceScreen({super.key});

  final nameController = TextEditingController();
  final priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    context.read<ServiceBloc>().add(LoadServices());

    return Scaffold(
      appBar: AppBar(title: const Text("Manage Services")),
      body: Column(
        children: [
          /// ADD FORM
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: "Service Name"),
                ),
                TextField(
                  controller: priceController,
                  decoration: const InputDecoration(labelText: "Price"),
                  keyboardType: TextInputType.number,
                ),
                ElevatedButton(
                  onPressed: () {
                    final service = ServiceEntity(
                      id: '',
                      name: nameController.text,
                      price: double.parse(priceController.text),
                      duration: 30,
                      isActive: true,
                    );

                    context.read<ServiceBloc>().add(
                          AddServiceEvent(service),
                        );
                  },
                  child: const Text("Add Service"),
                )
              ],
            ),
          ),

          /// LIST
          Expanded(
            child: BlocBuilder<ServiceBloc, ServiceState>(
              builder: (context, state) {
                if (state is ServiceLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is ServiceLoaded) {
                  return ListView.builder(
                    itemCount: state.services.length,
                    itemBuilder: (context, index) {
                      final service = state.services[index];

                      return ListTile(
                        title: Text(service.name),
                        subtitle: Text("₹${service.price}"),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            context.read<ServiceBloc>().add(
                                  DeleteServiceEvent(service.id),
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
          )
        ],
      ),
    );
  }
}