extends Node2D
# Handles the general functions of a plant
# Should be extended by every plant's script


# VARIABLES
var attackInterval: float
var attackRange: float
var hp: int
var maxHP: int
var cost: int

# ENGINE METHODS

# Deactivate the collision and set up the raycast for detecting enemies
func _ready() -> void:
	hp = maxHP
	get_node("HurtBox/CollisionShape2D").disabled = true
	$EnemyDetection.cast_to = Vector2(attackRange, 0)

# METHODS

# Reenable the collision so the plant can be attacked
# and detected by the placement system
func initialize() -> void:
	$AttackTimer.connect("timeout", self, "_on_AttackTimer_timeout")
	get_node("HurtBox/CollisionShape2D").disabled = false
	$AttackTimer.autostart = true
	$AttackTimer.start(attackInterval)

# Do nothing, should be implemented by the script of a specific plant
# which extends this script
func performAction() -> void:
	pass

# Handle taking damage
func takeDamage(amount: int) -> void:
	hp -= amount
	if hp < 1.0:
		queue_free()

# SIGNAL METHODS

# Perform the plant's specific action when the timer reaches zero
func _on_AttackTimer_timeout() -> void:
	performAction()
