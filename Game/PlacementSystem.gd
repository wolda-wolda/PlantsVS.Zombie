extends Node2D

var plantInstance: Node2D
signal plant_placed

var rayCast: RayCast2D
var inBounds: bool

func _ready() -> void:
	set_process(false)

# Change the node's color accodring to if it 
# can be placed at the current position or not
func _process(_delta: float) -> void:
	if _isInBounds() and !rayCast.is_colliding():
		plantInstance.modulate = Color(0, 1, 0)
	else:
		plantInstance.modulate = Color(1, 0, 0)

func _input(event: InputEvent) -> void:
	_setPlantPosition()
	if event.is_action_pressed("placementSystem_cancel"):
		plantInstance.queue_free()
		queue_free()
	elif event.is_action_pressed("placementSystem_place"):
		emit_signal("plant_placed")
		plantInstance.initialize()
		queue_free()

func start(plant: Plant):
	_createRayCast()
	var plantCreator = PlantCreator.new(plant)
	plantInstance = plantCreator.getPlant()
	plantCreator.queue_free()
	Global.main.get_node("Plants").add_child(plantInstance)
	set_process(true)

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

func _isInBounds() -> bool:
	return plantInstance.position.x < 192 and plantInstance.position.x > 0 and\
	plantInstance.position.y < 80 and plantInstance.position.y > 0

# Update the node's position
func _setPlantPosition() -> void:
	plantInstance.position.x = stepify(get_global_mouse_position().x - 8, 16.0)
	plantInstance.position.y = stepify(get_global_mouse_position().y - 8, 16.0)
	plantInstance.position += Vector2(8, 8)
