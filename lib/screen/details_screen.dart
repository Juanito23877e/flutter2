import 'package:flutter/material.dart';

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
      appBar: AppBar(title: Text(brandName), backgroundColor: Colors.blue),
      body: ListView.builder(
        itemCount: models.length,
        itemBuilder: (context, index) {
          final model = models[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            child: Card(
              color: Colors.black,
              elevation: 10.0,
              shadowColor: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Imagen grande en la parte superior
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    child: Image.network(
                      model['imagen_url'] ?? 'https://via.placeholder.com/300',
                      fit: BoxFit.cover,
                      height: 200,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          height: 200,
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 200,
                          alignment: Alignment.center,
                          child: Icon(Icons.error, color: Colors.red),
                        );
                      },
                    ),
                  ),
                  // Información debajo de la imagen
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model['nombre'],
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              color: Colors.lightBlueAccent,
                              size: 18,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Año: ${model['año']}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 6),
                        Row(
                          children: [
                            Icon(
                              Icons.car_repair,
                              color: Colors.blue,
                              size: 18,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Tipo: ${model['tipo']}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
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
          );
        },
      ),
    );
  }
}
