import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_admin/features/services/domain/entity/service_entity.dart';
import '../bloc/service_bloc.dart';

class ServiceScreen extends StatelessWidget {
  ServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ServiceBloc>().add(LoadServices());

    return Scaffold(
      appBar: AppBar(title: const Text("Manage Services")),

      /// ✅ FAB
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddServiceSheet(context),
        child: const Icon(Icons.add),
      ),

      /// ✅ LIST
      body: BlocBuilder<ServiceBloc, ServiceState>(
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
    );
  }

  /// 🔥 BOTTOM SHEET FUNCTION
  void _showAddServiceSheet(BuildContext context) {
    final nameController = TextEditingController();
    final priceController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // 🔥 important for keyboard
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Add Service",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 15),

              /// NAME
              TextField(
                controller: nameController,
                decoration:
                    const InputDecoration(labelText: "Service Name"),
              ),

              const SizedBox(height: 10),

              /// PRICE
              TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Price"),
              ),

              const SizedBox(height: 20),

              /// SAVE BUTTON
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

                  Navigator.pop(context); // ✅ CLOSE SHEET
                },
                child: const Text("Save"),
              )
            ],
          ),
        );
      },
    );
  }
}