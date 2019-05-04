# Venados FC

## Descripción: 
Este es un proyecto prueba para Da Codes del equipo de futbol Venados.


## Tabla de contenido: 

- Controladores

-- MenuViewController. Es un ViewController aderido a un NavigationController que junto con la libreria SideMenu logra generar el efector de drawer layout que tienen los items Home y Estadísticas y Jugadores. Al dar click sobre los items, el protocolo MenuViewControllerDelegate llama a las funciones de su delegate el cual es ContainerViewController.

-- ContainerViewController: Es un ViewController que tiene como variables de tipo lazy los controladores de HomeViewController (Home), GamesViewController (Estadísticas) y PlayersViewController (Jugadores)

-- HomeViewController: Es un ViewController que tiene una Collection View la cual despliega los juegos extraidos del modelo Game. 

-- GamesViewController: Es un ViewController que tiene una Table View la cual despliega las estadisticas extraidos del modelo Statistic.

-- PlayersViewController: Es un ViewController que tiene una Collection View la cual despliega los diferentes jugadores y coches de Venados F.C. extraidos del modelo Team.

- Modelos

-- Game: Modelo que descarga el calendario de juegos del servidor y lo guarda como un arreglo.

-- Statistic: Modelo que descarga la tabla de posiciones del servidor y la guarda como un arreglo.

-- Team: Es una clase que tiene a los entrenadores, los porteros, los centros, los defensas y los delanteros. Esta clase igual cuenta con una clase que te deja acceder a los diferentes arreglos convenientemente con un index de 0-4.


## Installation:
- Git Clone or Descarga el proyecto.
- Cambia el "Signing" en la configuracion de proyecto.
- $ pod install (Para instalar pod $ sudo gem install cocoapods)
