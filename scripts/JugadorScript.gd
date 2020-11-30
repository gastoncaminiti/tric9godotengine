extends KinematicBody2D 

# Source: https://www.davidepesce.com/2019/11/19/godot-tutorial-how-to-use-navigation2d-for-pathfinding/
var velocidad = 100
var ruta : = PoolVector2Array()
var direction = Vector2.DOWN

func _process(delta):
	# Calculate the movement distance for this frame
	var distance_to_walk = velocidad * delta
	# Move the player along the path until he has run out of movement or the path ends.
	while distance_to_walk > 0 and ruta.size() > 0:
		var distance_to_next_point = position.distance_to(ruta[0])
		if distance_to_walk <= distance_to_next_point:
			direction = position.direction_to(ruta[0])
			# The player does not have enough movement left to get to the next point.
			position += direction * distance_to_walk
			definir_animacion(direction)
			#position += position.direction_to(ruta[0]) * distance_to_walk
		else:
			# The player get to the next point
			position = ruta[0]
			ruta.remove(0)
		# Update the distance to walk
		distance_to_walk -= distance_to_next_point

func definir_animacion(direccion):
	var norm_direction = direction.normalized()
	if norm_direction.y >= 0.707:
		$AnimatedSprite.play("CAMINAR5")
	elif norm_direction.y <= -0.707:
		$AnimatedSprite.play("CAMINAR1")
	elif norm_direction.x <= -0.707:
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("CAMINAR4")
	elif norm_direction.x >= 0.707:
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("CAMINAR2")

func _on_Rango_body_entered(body):
	if body != self:
		body.queue_free()
