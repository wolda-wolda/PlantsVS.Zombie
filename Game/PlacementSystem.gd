extends Node2D
# Handles object placement using the mouse as input
# Moves the objects in 16x16 steps for them to align
# with the grid


# SIGNALS
signal plant_placed

# VARIABLES
var node
var mode: int = Global.mode.PLACE
var rayCast: RayCast2D

# EGNINE METHODS

# Handles placing the object and cancelling the placement
# Updates the balance if the node was placed
# Frees itself at the end
func _input(_event: InputEvent) -> void:
	var inBounds: bool = _isInBounds()
	if inBounds and !rayCast.is_colliding():
		node.modulate = Color(0, 1, 0)
	else:
		node.modulate = Color(1, 0, 0)
	_setNodePosition()
	if Input.is_action_just_pressed("placementSystem_cancel"):
		node.queue_free()
		queue_free()
	elif Input.is_action_just_pressed("placementSystem_place") and inBounds\
	and !rayCast.is_colliding() and mode == Global.mode.PLACE:
		set_process(false)
		node.modulate = Color(1, 1, 1)
		node.initialize()
		rayCast.queue_free()
		emit_signal("plant_placed")
		queue_free()
	elif Input.is_action_just_pressed("placementSystem_place") and rayCast.is_colliding() and mode == Global.mode.REMOVE:
		var collider: Area2D = rayCast.get_collider()
		var plant: Node2D = collider.get_parent()
		plant.queue_free()
		node.queue_free()
		queue_free()

# METHODS

# Start the building process
# Create necessary raycast for recognizing collisions
# with other plants
func start(placingMode: int, newNode: Node2D) -> void:
	node = newNode
	mode = placingMode
	_createRayCast()
	node.add_child(rayCast)
	if mode == Global.mode.REMOVE:
		rayCast.set_collision_mask_bit(3, false)
	_setNodePosition()
	get_node("/root/Main/Plants").add_child(node)

# Create a raycast which is set up for recognizing
# collision with other plants	
func _createRayCast() -> void:
	rayCast = RayCast2D.new()
	rayCast.set_collision_mask_bit(0, false)
	rayCast.set_collision_mask_bit(3, true)
	rayCast.set_collision_mask_bit(4, true)
	rayCast.cast_to = Vector2(1, 0)
	rayCast.enabled = true
	rayCast.collide_with_areas = true
	rayCast.collide_with_bodies = false

# Update the node's position
func _setNodePosition() -> void:
	node.position.x = stepify(get_global_mouse_position().x - 8, 16.0)
	node.position.y = stepify(get_global_mouse_position().y - 8, 16.0)
	node.position += Vector2(8, 8)

# Return the bounds of the playing grid
func _isInBounds() -> bool:
	return node.position.x < 192 and node.position.x > 16 and\
	node.position.y < 80 and node.position.y > 0
