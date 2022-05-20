extends Node
class_name OnFallEffect
# Effect for any Node2D
# Makes an objects accessory fall to the ground with a fixed height

#VARIABLES

var object: Node2D
var initial
var methodNamePos: String
var methodNameModulate: String
var methodNameRotate: String

# ENGINE METHODS

# Moves the accessory to the right with the same movement
# speed as the object so that it appears to stand still
func _process(delta: float) -> void:
	object.setAccessoryPosition(object.getAccessoryPosition() + Vector2(object.currentMovementSpeed * delta, 0))

# ENGINE METHODS

# Set the relevant values as class variables
func _init(object: Node2D, initial, methodNamePos: String, methodNameModulate: String, methodNameRotate: String) -> void:
	self.object = object
	self.initial = initial
	self.methodNamePos = methodNamePos
	self.methodNameModulate = methodNameModulate
	self.methodNameRotate = methodNameRotate

# METHODS

# STARTER METHOD
# Starts the first part of the animation
func start() -> void:
	var tweenInitial: Tween = Tween.new()
	tweenInitial.interpolate_method(object, methodNamePos, initial, Vector2(10, -15), 0.3, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	tweenInitial.connect("tween_completed", self, "_on_tweenInitial_completed")
	add_child(tweenInitial)
	tweenInitial.start()
	var tweenRotation: Tween = Tween.new()
	tweenRotation.interpolate_method(object, methodNameRotate, 0, 60, 0.6, Tween.TRANS_CIRC, Tween.EASE_IN_OUT)
	add_child(tweenRotation)
	tweenRotation.start()

# SIGNAL METHODS

# Starts the second part of the animation
func _on_tweenInitial_completed(_object: Object, _key: NodePath) -> void:
	var tweenFinal: Tween = Tween.new()
	tweenFinal.interpolate_method(object, methodNamePos, Vector2(10, -15), Vector2(25, 25), 0.3, Tween.TRANS_CUBIC, Tween.EASE_IN)
	tweenFinal.interpolate_method(object, methodNamePos, Vector2(10, -15), Vector2(25, 25), 0.3, Tween.TRANS_CUBIC, Tween.EASE_IN)
	tweenFinal.connect("tween_completed", self, "_on_tweenFinal_completed")
	add_child(tweenFinal)
	tweenFinal.start()

# Starts the third part of the animation
func _on_tweenFinal_completed(_object: Object, _key: NodePath) -> void:
	var tweenFade: Tween = Tween.new()
	tweenFade.interpolate_method(object, methodNameModulate, object.modulate, Color(1, 1, 1, 0), 0.5, Tween.TRANS_CUBIC, Tween.EASE_IN)
	add_child(tweenFade)
	tweenFade.connect("tween_completed", self, "_on_tweenFade_completed")
	tweenFade.start()

# Free the animation tween when the animation is completed
func _on_tweenFade_completed(_object: Object, _key: NodePath) -> void:
	queue_free()
