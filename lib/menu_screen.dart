import 'package:flutter/material.dart';
import 'carrito_screen.dart';

class MenuScreen extends StatefulWidget {
  final String nombreUsuario;
  final String mesaId;
  final String nombreRestaurante;

  const MenuScreen({
    super.key,
    required this.nombreUsuario,
    required this.mesaId,
    required this.nombreRestaurante,
  });

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  // Lista donde guardaremos el menú que se va a mostrar
  List<Map<String, dynamic>> _menuActual = [];

  // Lista del carrito de compras
  final List<Map<String, dynamic>> _pedido = [];

  @override
  void initState() {
    super.initState();
    // Al iniciar la pantalla, cargamos el menú correcto
    _cargarMenuEspecifico();
  }

  void _cargarMenuEspecifico() {
    // Definimos los 3 menús diferentes
    final Map<String, List<Map<String, dynamic>>> basesDeDatos = {
      'La Casa del Taco': [
        {'nombre': 'Tacos al Pastor', 'precio': 15.0, 'icono': Icons.local_fire_department},
        {'nombre': 'Tacos de Asada', 'precio': 18.0, 'icono': Icons.restaurant},
        {'nombre': 'Gringa', 'precio': 45.0, 'icono': Icons.layers},
        {'nombre': 'Refresco', 'precio': 25.0, 'icono': Icons.local_drink},
        {'nombre': 'Agua de Horchata', 'precio': 20.0, 'icono': Icons.water_drop},
      ],
      "Luigi's Pizza": [
        {'nombre': 'Pizza Pepperoni', 'precio': 120.0, 'icono': Icons.local_pizza},
        {'nombre': 'Pizza Hawaiana', 'precio': 130.0, 'icono': Icons.local_pizza},
        {'nombre': 'Espagueti', 'precio': 85.0, 'icono': Icons.dinner_dining},
        {'nombre': 'Vino Tinto', 'precio': 90.0, 'icono': Icons.wine_bar},
        {'nombre': 'Refresco', 'precio': 25.0, 'icono': Icons.local_drink},
      ],
      'Sushi Master': [
        {'nombre': 'California Roll', 'precio': 95.0, 'icono': Icons.rice_bowl},
        {'nombre': 'Filadelfia Roll', 'precio': 105.0, 'icono': Icons.set_meal},
        {'nombre': 'Arroz Gohan', 'precio': 60.0, 'icono': Icons.rice_bowl},
        {'nombre': 'Té Helado', 'precio': 30.0, 'icono': Icons.icecream},
        {'nombre': 'Sake', 'precio': 80.0, 'icono': Icons.local_bar},
      ],
    };

    // Seleccionamos el menú basándonos en el nombre del restaurante.
    // Si por alguna razón el nombre no coincide, mostramos una lista vacía o genérica.
    setState(() {
      _menuActual = basesDeDatos[widget.nombreRestaurante] ?? [];
    });
  }

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
                  // Calculamos el total
                  double total = 0;
                  for (var item in _pedido) {
                    total += item['precio'];
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CarritoScreen(
                        listaPedidos: _pedido,
                        total: total,
                      ),
                    ),
                  );
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
      // Si la lista está vacía (error de nombre), mostramos aviso
      body: _menuActual.isEmpty
          ? const Center(child: Text("Menú no disponible para este restaurante"))
          : ListView.builder(
        itemCount: _menuActual.length,
        itemBuilder: (context, index) {
          final platillo = _menuActual[index];
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