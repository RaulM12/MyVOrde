import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  final String nombreUsuario;
  final String mesaId;
  final String nombreRestaurante; // <--- NUEVO CAMPO

  const MenuScreen({
    super.key,
    required this.nombreUsuario,
    required this.mesaId,
    required this.nombreRestaurante, // <--- Requerido
  });

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  // Lista temporal de platillos
  final List<Map<String, dynamic>> _menu = [
    {'nombre': 'Tacos al Pastor', 'precio': 15.0, 'icono': Icons.local_fire_department},
    {'nombre': 'Tacos de Asada', 'precio': 18.0, 'icono': Icons.restaurant},
    {'nombre': 'Gringa', 'precio': 45.0, 'icono': Icons.layers},
    {'nombre': 'Refresco', 'precio': 25.0, 'icono': Icons.local_drink},
    {'nombre': 'Agua de Horchata', 'precio': 20.0, 'icono': Icons.water_drop},
  ];

  final List<Map<String, dynamic>> _pedido = [];

  void _agregarAlPedido(Map<String, dynamic> platillo) {
    setState(() {
      _pedido.add(platillo);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Agregaste ${platillo['nombre']} a tu cuenta'),
        duration: const Duration(milliseconds: 500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Aquí mostramos el nombre del restaurante
            Text(widget.nombreRestaurante, style: const TextStyle(fontSize: 18)),
            Text(
              'Mesa: ${widget.mesaId} - ${widget.nombreUsuario}',
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  // Aquí iremos a la pantalla de confirmar
                },
              ),
              if (_pedido.isNotEmpty)
                Positioned(
                  right: 5,
                  top: 5,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${_pedido.length}',
                      style: const TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                ),
            ],
          )
        ],
      ),
      body: ListView.builder(
        itemCount: _menu.length,
        itemBuilder: (context, index) {
          final platillo = _menu[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.deepOrange.shade100,
                child: Icon(platillo['icono'], color: Colors.deepOrange),
              ),
              title: Text(platillo['nombre'], style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('\$${platillo['precio']}0'),
              trailing: ElevatedButton(
                onPressed: () => _agregarAlPedido(platillo),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange),
                child: const Text('Pedir', style: TextStyle(color: Colors.white)),
              ),
            ),
          );
        },
      ),
    );
  }
}