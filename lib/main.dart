import 'package:dmit2504_assignment03/themes/theme.dart';
import 'package:dmit2504_assignment03/views/home.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DMIT2504 Assignment 3',
      theme: buildTheme(),
      home: HomeView(),
    );
  }
}
