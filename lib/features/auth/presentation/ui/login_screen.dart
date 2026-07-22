import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_admin/core/custom_navbar.dart';
import 'package:salon_admin/features/auth/presentation/bloc/auth_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>(); // ✅ works in Stateless

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoggedIn) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => CustomNavigationbar(),
              ),
            );
          }
        },
        builder: (context, state) {
          return Center(
            child: Card(
              elevation: 5,
              child: Container(
                width: 350,
                padding: const EdgeInsets.all(20),

                // 🔥 FORM
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      const Text(
                        "Admin Login",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),

                      const SizedBox(height: 20),

                      // ✅ EMAIL
                      TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          labelText: "Email",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email is required";
                          }
                          if (!value.contains('@')) {
                            return "Enter a valid email";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 15),

                      // ✅ PASSWORD
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: "Password",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password is required";
                          }
                          if (value.length < 4) {
                            return "Password must be at least 4 characters";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          minimumSize: const Size(350, 50),
                        ),
                        onPressed: () {
                          // 🔥 Validate
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                              LoginEvent(
                                emailController.text.trim(),
                                passwordController.text.trim(),
                              ),
                            );
                          }
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),

                      const SizedBox(height: 15),

                      if (state is AuthLoading)
                        const CircularProgressIndicator(),

                      if (state is AuthError)
                        const Text(
                          "Incorrect email or password",
                          style: TextStyle(color: Colors.red),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}