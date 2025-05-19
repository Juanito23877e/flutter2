import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CarBrandsScreen(),
    );
  }
}

class CarBrandsScreen extends StatelessWidget {
  const CarBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Marcas de Autos',
            style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
          ),
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          bottom: TabBar(
            indicatorColor: const Color.fromARGB(255, 0, 0, 0),
            labelColor: const Color.fromARGB(255, 0, 0, 0),
            unselectedLabelColor: const Color.fromARGB(255, 45, 45, 45),
            tabs: [
              Tab(icon: Icon(Icons.car_repair), text: 'Marcas'),
              Tab(icon: Icon(Icons.list), text: 'Modelos'),
              Tab(icon: Icon(Icons.info), text: 'Información'),
            ],
          ),
          shape: Border(
            bottom: BorderSide(
              color: const Color.fromARGB(255, 255, 255, 255),
              width: 2,
              style: BorderStyle.solid,
            ),
          ),
        ),
        body: TabBarView(
          children: [
            HomeScreen(), // Pantalla de marcas
            Container(
              color: const Color.fromARGB(255, 255, 255, 255),
              child: Center(
                child: Text(
                  ' modelos de autos proxima version',
                  style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                ),
              ),
            ),
            Container(
              color: Colors.black,
              child: Center(
                child: Text(
                  ' marcas de autos proxima version',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
