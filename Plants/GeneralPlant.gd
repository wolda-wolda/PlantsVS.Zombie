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
	$AttackTimer.connect("timeout", self, "_on_AttackTimer_timeout")
	hp = maxHP
	get_node("HurtBox/CollisionShape2D").disabled = true
	$EnemyDetection.cast_to = Vector2(attackRange, 0)

# METHODS

# Reenable the collision so the plant can be attacked
# and detected by the placement system
func initialize() -> void:
	get_node("HurtBox/CollisionShape2D").disabled = false
	$AttackTimer.autostart = true
	$AttackTimer.start(attackInterval)

# Do nothing, should be implemented by the script of a specific plant
# which extends this script
func performAction() -> void:
	pass

# Handle taking damage
# Starts effects and readjusts the HP and state
# Free the plant in case the HP falls too low
func takeDamage(amount: int) -> void:
	var onBodyEffect: OnBodyEffect = OnBodyEffect.new(self, Color(1, 1, 1), Color(1.2, 1.2, 1.2), 0.1, 0.1, "setPlantModulate")
	add_child(onBodyEffect)
	onBodyEffect.start()
	hp -= amount
	if hp <= maxHP * 0.33:
		_setState(2)
	elif hp <= maxHP * 0.66:
		_setState(1)
	if hp < 1.0:
		queue_free()

# Set the color of the plant
# Can be used for placement of the plant to indicate
# wheter the plant can be placed or not
func setPlantModulate(newColor: Color) -> void:
	modulate = newColor

# Set the state of the plant in case there are multiple states for
# different HPs, attack stances, etc.
func _setState(state: int) -> void:
	for x in $States.get_children():
		if x.frames == null:
			return
	for x in $States.get_children():
		x.visible = false
	$States.get_child(state).visible = true

# SIGNAL METHODS

# Perform the plant's specific action when the timer reaches zero
func _on_AttackTimer_timeout() -> void:
	performAction()
