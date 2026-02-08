import 'package:flutter/material.dart';
import 'restaurantes_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Variable para saber si estamos en modo Login o Registro
  bool _esLogin = true;

  // Controladores de texto
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();

  // Función para cambiar entre Login y Registro
  void _toggleForm() {
    setState(() {
      _esLogin = !_esLogin;
    });
  }

  // Función para procesar el ingreso
  void _submit() {
    // Aquí iría la lógica real de autenticación con Base de Datos más adelante

    String nombre = _nombreController.text;
    String email = _emailController.text;

    // Validación básica visual
    if (email.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor llena todos los campos')),
      );
      return;
    }

    if (!_esLogin && nombre.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor ingresa tu nombre')),
      );
      return;
    }

    // Si es Login y no escribió nombre, usamos el correo como nombre temporalmente
    if (_esLogin && nombre.isEmpty) {
      nombre = email.split('@')[0];
    }

    // Navegar a la Selección de Restaurante
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => RestaurantesScreen(nombreUsuario: nombre),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo o Icono
              const Icon(Icons.restaurant, size: 80, color: Colors.deepOrange),
              const SizedBox(height: 20),
              Text(
                _esLogin ? 'Bienvenido de nuevo' : 'Crear Cuenta',
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),

              // Campo de Nombre (Solo aparece si es Registro)
              if (!_esLogin)
                TextField(
                  controller: _nombreController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre Completo',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                ),
              if (!_esLogin) const SizedBox(height: 15),

              // Campo de Correo
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Correo Electrónico',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),

              // Campo de Contraseña
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 30),

              // Botón Principal
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: Text(_esLogin ? 'Iniciar Sesión' : 'Registrarse'),
                ),
              ),
              const SizedBox(height: 15),

              // Texto para cambiar de modo
              TextButton(
                onPressed: _toggleForm,
                child: Text(
                  _esLogin
                      ? '¿No tienes cuenta? Regístrate aquí'
                      : '¿Ya tienes cuenta? Inicia sesión',
                  style: TextStyle(color: Colors.deepOrange.shade700),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}