extends Node2D

var plantInstance: Node2D

func _ready() -> void:
	set_process(false)

func _process(delta: float) -> void:
	plantInstance.position = get_global_mouse_position()
	
func start(plant: Plant):
	var plantCreator = PlantCreator.new(plant)
	plantInstance = plantCreator.getPlant()
	print(plantInstance)
	plantCreator.queue_free()
	Global.main.get_node("Plants").add_child(plantInstance)
	set_process(true)

func _input(event: InputEvent) -> void:
	if (event.is_action_pressed("placementSystem_cancel")):
		print("Rechts-Klick")
		plantInstance.queue_free()
		queue_free()
	elif event is InputEventMouseButton:
		print("Links-Klick")

