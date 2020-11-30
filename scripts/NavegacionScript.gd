extends Node2D

# Source: https://www.davidepesce.com/2019/11/19/godot-tutorial-how-to-use-navigation2d-for-pathfinding/

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			var nuevaRuta = $Navegacion.get_simple_path($Jugador.position, event.position)
			$Camino.points = nuevaRuta
			$Jugador.ruta =  nuevaRuta
