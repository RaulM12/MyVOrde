import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'menu_screen.dart'; // Ahora vamos directo al menú

class EscanerScreen extends StatefulWidget {
  // Recibimos el nombre desde el Login
  final String nombreUsuario;

  const EscanerScreen({super.key, required this.nombreUsuario});

  @override
  State<EscanerScreen> createState() => _EscanerScreenState();
}

class _EscanerScreenState extends State<EscanerScreen> {
  final MobileScannerController cameraController = MobileScannerController();
  bool _codigoDetectado = false;

  // Función para ir al Menú
  void _irAlMenu(String codigoMesa) {
    if (_codigoDetectado) return;

    setState(() {
      _codigoDetectado = true;
    });

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MenuScreen(
          nombreUsuario: widget.nombreUsuario, // Pasamos el nombre que traemos del Login
          mesaId: codigoMesa,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escanea el QR'),
        actions: [
          IconButton(
            icon: const Icon(Icons.flash_on),
            onPressed: () => cameraController.toggleTorch(),
          ),
        ],
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: cameraController,
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              if (barcodes.isNotEmpty) {
                final String codigo = barcodes.first.rawValue ?? "Desconocido";
                _irAlMenu(codigo);
              }
            },
          ),
          // Cuadro visual de guía
          Center(
            child: Container(
              width: 250, height: 250,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.deepOrange, width: 4),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ],
      ),
      // Mantenemos el botón de debug para el emulador
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _irAlMenu("Mesa-Simulada-05"),
        label: const Text("Simular (Debug)"),
        icon: const Icon(Icons.bug_report),
      ),
    );
  }
}