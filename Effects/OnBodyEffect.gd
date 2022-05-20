extends Node
class_name OnBodyEffect
# Effect for any Node2D
# Makes the node flash for a short period of time

# VARIABLES

var object: Node2D
var initial
var final
var initialTime: float
var finalTime: float
var methodName: String

# ENGINE METHODS

# Set the relevant values as class variables
func _init(object: Node2D, initial, final, initialTime: float, finalTime: float, methodName: String) -> void:
	self.object = object
	self.initial = initial
	self.final = final
	self.initialTime = initialTime
	self.finalTime = finalTime
	self.methodName = methodName

# METHODS

# STARTER METHOD
# Start the first part of the animation
func start() -> void:
	var tweenInitial: Tween = Tween.new()
	tweenInitial.interpolate_method(object, methodName, initial, final, initialTime, Tween.TRANS_EXPO, Tween.EASE_OUT)
	tweenInitial.connect("tween_completed", self, "_on_tweenInitial_completed")
	add_child(tweenInitial)
	tweenInitial.start()

# SIGNAL METHODS

# Start the next part of the animation when the first one
# is completed
func _on_tweenInitial_completed(_object: Object, _key: NodePath) -> void:
	var tweenFinal: Tween = Tween.new()
	tweenFinal.interpolate_method(object, methodName, final, initial, finalTime, Tween.TRANS_EXPO, Tween.EASE_IN)
	tweenFinal.connect("tween_completed", self, "_on_tweenFinal_completed")
	add_child(tweenFinal)
	tweenFinal.start()

# Free the animation tween when the animation is completed
func _on_tweenFinal_completed(_object: Object, _key: NodePath) -> void:
	queue_free()
