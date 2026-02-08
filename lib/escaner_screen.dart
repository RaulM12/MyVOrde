import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'registro_screen.dart';

class EscanerScreen extends StatefulWidget {
  const EscanerScreen({super.key});

  @override
  State<EscanerScreen> createState() => _EscanerScreenState();
}

class _EscanerScreenState extends State<EscanerScreen> {
  final MobileScannerController cameraController = MobileScannerController();
  bool _codigoDetectado = false;

  // Función auxiliar para navegar (usada por el escáner real y el botón de prueba)
  void _navegarARegistro(String codigo) {
    if (_codigoDetectado) return; // Si ya detectó uno, no hacer nada

    setState(() {
      _codigoDetectado = true;
    });

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => RegistroScreen(mesaId: codigo),
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
            icon: const Icon(Icons.flash_on, color: Colors.white),
            onPressed: () => cameraController.toggleTorch(),
          ),
        ],
      ),
      body: Stack(
        children: [
          // 1. La Cámara Real
          MobileScanner(
            controller: cameraController,
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              if (barcodes.isNotEmpty) {
                final String codigo = barcodes.first.rawValue ?? "Desconocido";
                debugPrint('QR Real detectado: $codigo');
                _navegarARegistro(codigo);
              }
            },
          ),

          // 2. Un diseño superpuesto para que se vea bonito (opcional)
          Center(
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.deepOrange, width: 4),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ],
      ),

      // 3. BOTÓN TRUCO PARA EL EMULADOR
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Simulamos que leímos la Mesa #5
          _navegarARegistro("Mesa-Simulada-05");
        },
        label: const Text("Simular Escaneo (Debug)"),
        icon: const Icon(Icons.bug_report),
        backgroundColor: Colors.blue,
      ),
    );
  }
}