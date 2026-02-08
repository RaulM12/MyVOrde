import 'package:flutter/material.dart';

class CarritoScreen extends StatelessWidget {
  // Recibimos la lista de lo que pidió y el total
  final List<Map<String, dynamic>> listaPedidos;
  final double total;

  const CarritoScreen({
    super.key,
    required this.listaPedidos,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tu Cuenta Individual'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: listaPedidos.isEmpty
          ? const Center(
        child: Text(
          'Aún no has pedido nada.\n¡Regresa al menú para ordenar!',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      )
          : Column(
        children: [
          // 1. Lista de platillos pedidos
          Expanded(
            child: ListView.builder(
              itemCount: listaPedidos.length,
              itemBuilder: (context, index) {
                final item = listaPedidos[index];
                return ListTile(
                  leading: const Icon(Icons.check_circle, color: Colors.green),
                  title: Text(item['nombre']),
                  trailing: Text(
                    '\$${item['precio']}0',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                );
              },
            ),
          ),

          // 2. Sección del Total y Botón de Confirmar
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: const Offset(0, -3),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total a Pagar:',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '\$$total' '0',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Simulamos enviar el pedido
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('¡Pedido enviado a cocina!'),
                          backgroundColor: Colors.green,
                        ),
                      );

                      // Regresamos hasta el inicio (Login/Restaurantes)
                      // Esto simula que terminaste y liberaste la mesa
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text(
                      'CONFIRMAR PEDIDO',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}