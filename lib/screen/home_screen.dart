import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Obtener datos de la API de carros
  Future<List<dynamic>> fetchCarBrands() async {
    final url = Uri.parse("http://localhost:12347/carros");
    final response = await http.get(url);
    final data = jsonDecode(response.body);
    return data['brands'];
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Marcas de Carros'),
        titleTextStyle: TextStyle(
          color: const Color.fromARGB(255, 255, 255, 255),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),
      body: FutureBuilder(
        future: fetchCarBrands(),
        builder: (context, snapshot) {
          final brands = snapshot.data ?? [];
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                "No hay datos disponibles",
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 20,
                ),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: brands.length,
              itemBuilder: (context, index) {
                return _carCards(context, brands[index]);
              },
            );
          }
        },
      ),
    );
  }
}

Widget _carCards(BuildContext context, dynamic brand) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) => CarDetailsScreen(
                brandName: brand['nombre'],
                logoUrl: brand['logo_url'],
                models: brand['modelos'],
              ),
        ),
      );
    },
    child: Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 125,
        child: Card(
          color: const Color.fromARGB(255, 255, 255, 255),
          elevation: 10.0,
          shadowColor: const Color.fromARGB(255, 42, 45, 255),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: <Widget>[
              // Imagen de la marca
              SizedBox(
                height: 125,
                width: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    brand['logo_url'],
                    fit: BoxFit.cover,
                    width: 100,
                    height: 125,
                  ),
                ),
              ),
              // Información de la marca
              Expanded(
                // Este widget asegura que el texto ocupe el espacio restante
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ), // Ajustamos el espacio entre la imagen y el texto
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        brand['nombre'],
                        style: TextStyle(
                          fontFamily: 'Quicksand',
                          fontSize: 20,
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      Text(
                        brand['origen'],
                        style: TextStyle(
                          fontFamily: 'Quicksand',
                          fontSize: 16,
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
                        overflow:
                            TextOverflow
                                .ellipsis, // Añadimos '...' si el texto no cabe
                        softWrap:
                            true, // Permite que el texto se ajuste a varias líneas si es necesario
                      ),
                      Container(
                        height: 2,
                        width: 100,
                        color: const Color.fromARGB(255, 63, 27, 247),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class CarDetailsScreen extends StatelessWidget {
  final String brandName;
  final String logoUrl;
  final List<dynamic> models;

  const CarDetailsScreen({
    required this.brandName,
    required this.logoUrl,
    required this.models,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(brandName, style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),
      body: ListView.builder(
        itemCount: models.length,
        itemBuilder: (context, index) {
          final model = models[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Card(
              color: Colors.black,
              elevation: 8.0,
              shadowColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    // Imagen del modelo de carro
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        model['imagen_url'] ??
                            'https://via.placeholder.com/150',
                        fit: BoxFit.cover,
                        width: 100,
                        height: 80,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      ),
                    ),
                    SizedBox(width: 15),
                    // Detalles del modelo
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            model['nombre'],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                color: Colors.redAccent,
                                size: 16,
                              ),
                              SizedBox(width: 5),
                              Text(
                                'Año: ${model['año']}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Icon(
                                Icons.car_repair,
                                color: Colors.redAccent,
                                size: 16,
                              ),
                              SizedBox(width: 5),
                              Text(
                                'Tipo: ${model['tipo']}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
