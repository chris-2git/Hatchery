import 'dart:io';
import 'package:egg_project/api/homeapi.dart';
import 'package:egg_project/fristpages/loginpage.dart'; // Adjust import based on your project structure// Adjust import based on your project structure
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Custom HttpOverrides to bypass SSL certificate validation (for testing only)
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) {
        // Warning: Bypassing certificate validation is insecure and should only be used in development.
        // In production, ensure proper SSL certificates are used.
        return true;
      };
  }
}

void main() {
  // Set custom HTTP overrides to handle self-signed certificates
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        // Add other providers here if needed
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Egg Project', // Set a meaningful app title
        theme: ThemeData(
          primarySwatch: Colors.blue, // Define a default theme
          useMaterial3: true, // Enable Material 3 design
        ),
        home: const Loginpage(),
      ),
    );
  }
}
