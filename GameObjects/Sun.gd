extends Node2D
# Collectible currency


# VARIABLES
var sunUIPos: Vector2 = Global.GUI.get_node("VBoxEconomy/Balance").rect_global_position + Vector2(6, 6)

# CONSTANTS
const finalScale: Vector2 = Vector2(0.2, 0.2)

# SIGNAL METHODS

# Start a tween which moves the sun
# Start a tween which Scales the sun down when close to the balance UI
func _on_Button_button_down() -> void:
	$AnimationPlayer.stop()
	var tweenPos: Tween = Tween.new()
	var tweenScale: Tween = Tween.new()
	tweenPos.interpolate_property(self, "global_position", global_position, sunUIPos, 0.5, tweenPos.TRANS_EXPO, tweenPos.EASE_OUT)
	tweenScale.interpolate_property(self, "scale", scale, finalScale, 0.5, tweenPos.TRANS_EXPO, tweenPos.EASE_IN)
	tweenPos.connect("tween_completed", self, "_on_tweenPos_completed")
	add_child(tweenPos)
	add_child(tweenScale)
	tweenPos.start()
	tweenScale.start()

# When the sun has been in the world for too long, it frees itself
# thus despawning
func _on_DespawnTimer_timeout() -> void:
	queue_free()

# When the tween has been completed, add the sun to the balance
# and free the sun instance
func _on_tweenPos_completed(_object: Object, _key: NodePath) -> void:
	Global.balance += 50
	queue_free()
