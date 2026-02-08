import 'package:flutter/material.dart';

class RegistroScreen extends StatefulWidget {
  const RegistroScreen({super.key});

  @override
  State<RegistroScreen> createState() => _RegistroScreenState();
}

class _RegistroScreenState extends State<RegistroScreen> {
  // Controlador para capturar lo que el usuario escribe
  final TextEditingController _nombreController = TextEditingController();

  @override
  void dispose() {
    // Limpiamos el controlador cuando se cierra la pantalla para ahorrar memoria
    _nombreController.dispose();
    super.dispose();
  }

  void _unirseALaMesa() {
    String nombre = _nombreController.text;
    if (nombre.isNotEmpty) {
      // Aquí más adelante guardaremos el nombre en la base de datos
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('¡Bienvenido, $nombre! Mesa registrada.')),
      );
      // Por ahora, solo mostramos el mensaje de éxito
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, ingresa tu nombre.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Comensal'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '¡Hola!',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Para separar tu cuenta correctamente, necesitamos saber quién eres.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),
            // Campo de texto para el nombre
            TextField(
              controller: _nombreController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Tu Nombre',
                prefixIcon: Icon(Icons.person),
                hintText: 'Ej. Juan Pérez',
              ),
            ),
            const SizedBox(height: 30),
            // Botón para continuar
            SizedBox(
              width: double.infinity, // El botón ocupa todo el ancho
              child: ElevatedButton(
                onPressed: _unirseALaMesa,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  'Unirse a la Orden',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}