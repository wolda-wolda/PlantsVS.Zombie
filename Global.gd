extends Node

# SIGNALS

signal balance_changed

# NODEPATHS

onready var main: Node2D = get_node("/root/Main")
onready var UI: CanvasLayer = main.get_node("UI")
onready var GUI: Control = UI.get_node("GUI")
onready var progressBar: TextureProgress = GUI.get_node("ProgressBar")
onready var balanceUI: MarginContainer = GUI.get_node("VBoxEconomy/Balance")
onready var Blur: ColorRect = GUI.get_node("Blur")

# UI CONSTANTS

const UI_SCALE: Vector2 = Vector2(2, 2)
const UI_BLUR_AMOUNT: float = 1.7
const UI_ANIMATION_DURATION: float = 0.3
const TOOLTIP_DELAY: float = 0.5

# ECONOMY VARIABLES

var balance: int = 100 setget setBalance

# ECONOMY CONSTANTS

const BALANCE_CAP: int = 950
const sunValue: int = 50

# ENUMS

enum mode {
	PLACE,
	REMOVE
}

enum fade {
	IN,
	OUT
}

# ENGINE METHODS

func _ready() -> void:
	pause_mode = PAUSE_MODE_PROCESS

# Handles UI input
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen

# SETTERS

func setBalance(amount: int) -> void:
	balance = amount
	if balance > BALANCE_CAP:
		balance = BALANCE_CAP
	balanceUI.setBalance(balance)
	emit_signal("balance_changed")
