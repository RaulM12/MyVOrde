import 'package:flutter/material.dart';

void main() {
  runApp(const MyVOrderApp());
}

class MyVOrderApp extends StatelessWidget {
  const MyVOrderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyVOrder',
      theme: ThemeData(
        // Usamos un color naranja/rojo típico de apps de comida
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const PantallaInicio(),
    );
  }
}

class PantallaInicio extends StatefulWidget {
  const PantallaInicio({super.key});

  @override
  State<PantallaInicio> createState() => _PantallaInicioState();
}

class _PantallaInicioState extends State<PantallaInicio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Bienvenido a MyVOrder'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(
                Icons.restaurant_menu,
                size: 100,
                color: Colors.deepOrange,
              ),
              const SizedBox(height: 20),
              const Text(
                '¿Listo para ordenar?',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Escanea el código QR de tu mesa para comenzar.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 40),
              // Botón simulado para Escanear QR (Requisito del documento)
              ElevatedButton.icon(
                onPressed: () {
                  // Aquí pondremos la lógica del QR más adelante
                  print("Abriendo cámara para QR...");
                },
                icon: const Icon(Icons.qr_code_scanner),
                label: const Text('Escanear Mesa'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}