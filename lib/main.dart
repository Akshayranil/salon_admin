import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_admin/core/dependency_injection.dart';

import 'package:salon_admin/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:salon_admin/features/auth/presentation/ui/splash_screen.dart';
import 'package:salon_admin/features/dashboard/presentation/bloc/booking_bloc.dart';
import 'package:salon_admin/features/services/presentation/bloc/service_bloc.dart';
import 'package:salon_admin/features/staff/presentation/bloc/staff_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiBlocProvider(
    providers: [
        BlocProvider<AuthBloc>(create: (_)=>AuthBloc(Injection.loginUseCase,Injection.logoutUseCase,Injection.checkLoginUseCase)..add(CheckAuthEvent())),
        BlocProvider<ServiceBloc>(create: (_)=>ServiceBloc(Injection.serviceUseCase)),
        BlocProvider<StaffBloc>(create: (_)=>StaffBloc(Injection.staffUseCase)),
        BlocProvider<BookingBloc>(create: (_)=>BookingBloc(Injection.bookingUseCase))
      ],
    child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: SplashScreen(),
    );
  }
}
