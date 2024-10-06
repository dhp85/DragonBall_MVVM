

# Dragon Ball- MVVM App

Este proyecto es una práctica de desarrollo de una aplicación de Dragon Ball que implementa la arquitectura **MVVM (Model-View-ViewModel)**. La aplicación cuenta con tres pantallas principales: **Login**, **Home** y **Detalle**, y se ha implementado testing para los `ViewModels`.

## 🚀 Características

- **Login:** Pantalla para que el usuario pueda iniciar sesión en la aplicación.
- **Home:** Pantalla que muestra una lista de personajes de Dragon Ball.
- **Detalle:** Pantalla que muestra información detallada de un personaje seleccionado.

## 📱 Pantallas

### 1. **Login**
   - Pantalla inicial para que el usuario introduzca sus credenciales (usuario y contraseña).
   - Verifica los datos de inicio de sesión y navega a la pantalla de **Home** si las credenciales son correctas.

### 2. **Home**
   - Muestra una lista de personajes de Dragon Ball.
   - Cada personaje tiene un nombre y una imagen asociada.
   - Al seleccionar un personaje, se navega a la pantalla de **Detalle**.

### 3. **Detalle**
   - Muestra información detallada sobre un personaje, como su nombre, imagen y descripción.

## 🏗 Arquitectura

El proyecto utiliza la arquitectura **MVVM (Model-View-ViewModel)** para lograr una mejor separación de responsabilidades y facilitar el mantenimiento y testeo de la aplicación.

- **Model:** Contiene los datos y la lógica de negocio, interactuando con las fuentes de datos (APIs o base de datos local).
- **View:** Son las pantallas de la app que presentan la información al usuario.
- **ViewModel:** Se encarga de la lógica de presentación. Recoge los datos del `Model` y los prepara para ser consumidos por la `View`. También maneja las interacciones del usuario que provienen de la `View`.

### Beneficios de MVVM:

- **Separación de responsabilidades:** La lógica de negocio y de presentación está separada de la interfaz de usuario.
- **Facilita las pruebas:** Los `ViewModels` se pueden probar de manera independiente de las `Views` y los `Models`.
- **Reutilización del código:** Los `ViewModels` y `Models` pueden reutilizarse fácilmente en distintas vistas si es necesario.

## 🔍 Testing

Se han implementado pruebas unitarias en los **ViewModels** de la aplicación. Esto permite garantizar que la lógica de presentación se comporta correctamente bajo distintas condiciones. Algunas de las pruebas realizadas incluyen:

- Verificación de la lógica de autenticación en el `LoginViewModel`.
- Pruebas en el `HomeViewModel` para asegurar que los personajes se cargan correctamente.
- Pruebas en el `DetalleViewModel` para asegurar que la información detallada del personaje se muestra correctamente.

Las pruebas se implementaron usando `XCTest`.

## ⚙️ Requisitos

Para ejecutar este proyecto, necesitas:

- **Xcode 16**
- **iOS 18**
- **Swift 5**

## 🛠 Instalación y Ejecución

1. Clona este repositorio:

   ```bash
   git clone https://github.com/tu-usuario/dragonball-app.git

	2.	Abre el archivo DragonBallApp.xcodeproj en Xcode.
	3.	Asegúrate de seleccionar el simulador o dispositivo correcto.
	4.	Compila y ejecuta el proyecto:

Cmd + R


	5.	Para ejecutar las pruebas:

Cmd + U



🗂 Estructura del Proyecto

El proyecto sigue la arquitectura MVVM.



📚 Referencias

	•	Documentación oficial de Swift
	•	Documentación oficial de XCTest

✨ Créditos

Desarrollado por Diego Herreros Parrón para la practica de patrones de diseño en la escuela tech KeepCoding.

