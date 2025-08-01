extends CharacterBody2D

const SPEED = 300.0

signal shoot(bullet: Area2D, location: Vector2)

var bullet = preload("res://scenes/player_ship/player_ship_bullet.tscn")

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		shoot.emit(bullet, $Marker2D.global_position)

func _physics_process(_delta: float) -> void:
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		move_and_slide()
