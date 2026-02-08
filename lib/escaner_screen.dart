import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'menu_screen.dart';

class EscanerScreen extends StatefulWidget {
  final String nombreUsuario;

  const EscanerScreen({super.key, required this.nombreUsuario});

  @override
  State<EscanerScreen> createState() => _EscanerScreenState();
}

class _EscanerScreenState extends State<EscanerScreen> {
  final MobileScannerController cameraController = MobileScannerController();
  bool _codigoDetectado = false;

  // Función compartida: ya sea por QR o manual, hace lo mismo
  void _irAlMenu(String codigoMesa) {
    if (_codigoDetectado) return; // Evita dobles navegaciones

    // Si el código está vacío (caso manual), no hacemos nada
    if (codigoMesa.trim().isEmpty) return;

    setState(() {
      _codigoDetectado = true;
    });

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MenuScreen(
          nombreUsuario: widget.nombreUsuario,
          mesaId: codigoMesa,
        ),
      ),
    );
  }

  // Función para mostrar la ventana de ingreso manual
  void _mostrarIngresoManual() {
    final TextEditingController manualController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ingresar Código de Mesa'),
        content: TextField(
          controller: manualController,
          decoration: const InputDecoration(
            hintText: 'Ej. MESA-05',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Cerrar ventana
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Cerramos el diálogo primero
              _irAlMenu(manualController.text); // Navegamos al menú
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange),
            child: const Text('Entrar', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escanea o Ingresa Código'),
        actions: [
          IconButton(
            icon: const Icon(Icons.flash_on),
            onPressed: () => cameraController.toggleTorch(),
          ),
        ],
      ),
      body: Stack(
        children: [
          // 1. La Cámara de fondo
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

          // 2. Cuadro visual (Guía)
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

          // 3. Botón para ingreso manual (Parte inferior)
          Positioned(
            bottom: 50,
            left: 20,
            right: 20,
            child: Column(
              children: [
                const Text(
                  "¿Problemas con el código?",
                  style: TextStyle(color: Colors.white, shadows: [
                    Shadow(blurRadius: 10, color: Colors.black, offset: Offset(1, 1))
                  ]),
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: _mostrarIngresoManual,
                  icon: const Icon(Icons.keyboard),
                  label: const Text("Ingresar código manualmente"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      // Mantenemos el botón de debug pequeño en la esquina para ti (el desarrollador)
      floatingActionButton: FloatingActionButton.small(
        onPressed: () => _irAlMenu("Mesa-Simulada-05"),
        child: const Icon(Icons.bug_report),
      ),
    );
  }
}