extends Node2D
# Handles the general functions of a zombie
# Should be extended by every zombie's script


# SIGNALS

signal on_death(cost)

# VARIABLES
var maxHp: int
var hp: int
var cost: int
var attackInterval: float
var currentArea: Area2D = null
var movementSpeed: float
var currentMovementSpeed: float
var walkingSpeedScale: float
var eatingSpeedScale: float
var currentAttackInterval: float

# ENGINE METHODS

# Set the current speed scale of the animations
func _ready() -> void:
	maxHp = hp
	currentMovementSpeed = movementSpeed
	currentAttackInterval = attackInterval
	walkingSpeedScale = get_node("Walking").speed_scale
	eatingSpeedScale = get_node("Eating").speed_scale

# Move the zombie
func _process(delta: float) -> void:
	var speed: float = -delta * currentMovementSpeed
	position += Vector2(speed, 0)

# METHODS

# Handles taking damage
# Adds effects on specific events
# Frees itself if the HP falls low
func takeDamage(damage: int) -> void:
	if hp == maxHp / 2:
		var onFallEffect: OnFallEffect = OnFallEffect.new(self, $Walking/WalkingAccessory.position, "setAccessoryPosition", "setAccessoryModulate", "setAccessoryRotation")
		add_child(onFallEffect)
		onFallEffect.start()
	if $SlowTimer.is_stopped():
		var onBodyEffect: OnBodyEffect = OnBodyEffect.new(self, modulate, Color(1.2, 1.2, 1.2), 0.1, 0.1, "setBodyModulate")
		add_child(onBodyEffect)
		onBodyEffect.start()
	hp -= damage
	if hp < 1:
		emit_signal("on_death", cost)
		queue_free()

# Slows the Zombie and adds a slow effect
# Modifies the overall speed scale, thus also the animations
func slow(seconds: float) -> void:
	var onBodyEffect: OnBodyEffect = OnBodyEffect.new(self, modulate, Color(0, 0.75, 1), seconds - 0.5, 0.5, "setBodyModulate")
	add_child(onBodyEffect)
	onBodyEffect.start()
	_setOverallSpeedScale(0.75)
	$SlowTimer.start(seconds)

# Attack an opponent and deal damage
# Stop moving and start the attack animation
# If opponent disappears, stop attacking
func attack() -> void:
	if currentArea != null:
		_setAttacking(true)
		set_process(false)
		currentArea.get_parent().takeDamage(20)
		$AttackTimer.start(currentAttackInterval)

# Toggle between the zombies states, meaning it's sprites
# Attacking and not attacking
func _setAttacking(attacking: bool) -> void:
	if attacking:
		$Walking.visible = false
		$Walking/WalkingAccessory.visible = false
		$Eating.visible = true
		$Eating/EatingAccessory.visible = true
	else:
		$Walking.visible = true
		$Walking/WalkingAccessory.visible = true
		$Eating.visible = false
		$Eating/EatingAccessory.visible = false

# Set the overall speed scale
# The movement and attack speed and animation speed
func _setOverallSpeedScale(multiplier: float) -> void:
	currentMovementSpeed = movementSpeed * multiplier
	currentAttackInterval = attackInterval * multiplier
	$Walking.speed_scale = walkingSpeedScale * multiplier
	$Walking/WalkingAccessory.speed_scale = walkingSpeedScale * multiplier
	$Eating.speed_scale = eatingSpeedScale * multiplier
	$Eating/EatingAccessory.speed_scale = eatingSpeedScale * multiplier

# Set the modulate of the zombie
# Can be used to create damaging or slowing effects
func setBodyModulate(newColor: Color) -> void:
	$Walking.modulate = newColor
	$Eating.modulate = newColor

# Set the modulate of the zombies accessory
# Can be used to create damaging or slowing effects
func setAccessoryModulate(newColor: Color) -> void:
	$Walking/WalkingAccessory.modulate = newColor
	$Eating/EatingAccessory.modulate = newColor

# Set the position of the zombies accessory
# Can be used to create damaging or slowing effects
func setAccessoryPosition(newPosition: Vector2) -> void:
	$Walking/WalkingAccessory.position = newPosition
	$Eating/EatingAccessory.position = newPosition

# Set the rotation of the zombies accessory
# Can be used to create damaging or slowing effects
func setAccessoryRotation(newRotationDegrees: float) -> void:
	$Walking/WalkingAccessory.rotation_degrees = newRotationDegrees
	$Eating/EatingAccessory.rotation_degrees = newRotationDegrees

# Return the accessory's local position
func getAccessoryPosition() -> Vector2:
	return $Walking/WalkingAccessory.position

# Set the zombie's sprites position
func setBodyPosition(newPosition: Vector2) -> void:
	$Walking.position = newPosition
	$Eating.position = newPosition

# SIGNAL METHODS

# When the timer times out, attack
func _on_AttackTimer_timeout() -> void:
	attack()

# Set the opponets area as the current area and attack
func _on_HitBox_area_entered(area: Area2D) -> void:
	currentArea = area
	attack()

# When the zombie exits the opponents area, stop attacking and start moving
func _on_HitBox_area_exited(_area: Area2D) -> void:
	currentArea = null
	_setAttacking(false)
	set_process(true)

# When the zombie isn't slowed anymore, reset the speed scale
func _on_SlowTimer_timeout() -> void:
	_setOverallSpeedScale(1)
