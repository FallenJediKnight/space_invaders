extends CharacterBody2D

const SPEED = 300.0
const INVADER_POINT_VALUE = 1
const MOTHERSHIP_POINT_VALUE = 5

var bullet = preload("res://scenes/player_ship/player_ship_bullet.tscn")
var gun_enabled = true
var last_destroyed_rid: RID
var score = 0


func _ready() -> void:
	SignalBus.invader_destroyed.connect(_on_invader_destroyed)
	SignalBus.mothership_destroyed.connect(_on_mothership_destroyed)


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("shoot") and gun_enabled:
		gun_enabled = false
		$GunTimer.start()
		SignalBus.player_ship_shoot.emit(bullet, $Marker2D.global_position)


func _physics_process(_delta: float) -> void:
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		move_and_slide()


func _on_gun_timer_timeout() -> void:
	gun_enabled = true


func _on_invader_destroyed(invader_rid: RID) -> void:
	if invader_rid != last_destroyed_rid:
		score += INVADER_POINT_VALUE
		last_destroyed_rid = invader_rid


func _on_mothership_destroyed() -> void:
	score += MOTHERSHIP_POINT_VALUE
