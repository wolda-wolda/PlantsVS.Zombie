extends Node


# LEVELS

var MainLevel: PackedScene = preload("res://Levels/MainLevel.tscn")
var HomeLevel: PackedScene = preload("res://Levels/HomeLevel.tscn")

# UI SCENES

var MainMenu: PackedScene = preload("res://UI/MainMenu.tscn")
var PauseMenu: PackedScene = preload("res://UI/PauseMenu.tscn")
var ShopItem: PackedScene = preload("res://Economy/ShopItem.tscn")
var PlantInfo: PackedScene = preload("res://UI/PlantInfo.tscn")
var TextAnimation: PackedScene = preload("res://Effects/TextAnimation.tscn")

# BLUEPRINT SCENES

var PlantBlueprint: PackedScene = preload("res://Plants/PlantBlueprint.tscn")
var ZombieBlueprint: PackedScene = preload("res://Zombies/ZombieBlueprint.tscn")

# PROJECTILE SCENES

var PeashooterProjectile: PackedScene = preload("res://Projectiles/Peashooter/PeashooterProjectile.tscn")
var SnowPeashooterProjectile: PackedScene = preload("res://Projectiles/SnowPeashooter/SnowPeashooterProjectile.tscn")

# GAMEOBJECT SCENES

var Sun: PackedScene = preload("res://GameObjects/Sun.tscn")

# GAMEMANAGING SCENES

var PlacementSystem: PackedScene = preload("res://Game/PlacementSystem.tscn")
var Remover: PackedScene = preload("res://Game/Remover.tscn")
var SunSpawner: PackedScene = preload("res://GameObjects/SunSpawner.tscn")
