extends Area2D

class_name SpaceInvader

const GAME_OVER_Y_POSITION: float = 768.0
const DISTANCE_TO_BOTTOM_OF_SPRITE: float = 25.0
const MAX_SPEED: float = 200.0
const SPEED_INCREASE_CONSTANT = 1.03
const MAX_BULLET_WAIT_TIME = 15
const MIN_BULLET_WAIT_TIME = 1

var speed = 20.0
var right_edge_delta = 100.0
var left_edge_delta = 32
var descend_delta = 32
var direction = Vector2.RIGHT
var shooting_allowed = true
var bullet_timer: Timer
var bullet = preload("res://scenes/space_invaders/space_invader_bullet.tscn")


func _ready() -> void:
	bullet_timer = Timer.new()
	add_child(bullet_timer)
	bullet_timer.one_shot = true
	bullet_timer.wait_time = randi_range(MIN_BULLET_WAIT_TIME, MAX_BULLET_WAIT_TIME)
	bullet_timer.autostart = true
	bullet_timer.timeout.connect(_on_bullet_timer_timeout)


func _process(_delta: float) -> void:
	if shooting_allowed:
		shooting_allowed = false
		bullet_timer.wait_time = randi_range(MIN_BULLET_WAIT_TIME, MAX_BULLET_WAIT_TIME)
		bullet_timer.start()


func _physics_process(delta: float) -> void:
	if has_invaded():
		SignalBus.game_over.emit()
	if has_hit_an_edge():
		SignalBus.hit_an_edge.emit()
	var position_delta = direction * speed * delta
	position += position_delta


func _on_bullet_timer_timeout() -> void:
	SignalBus.invader_shoot.emit(bullet, $BulletSpawnPoint.global_position)
	shooting_allowed = true


func descend() -> void:
	position += Vector2(0, descend_delta)
	direction = direction.rotated(deg_to_rad(180))


func accelerate() -> void:
	speed = min(MAX_SPEED, speed * SPEED_INCREASE_CONSTANT)


func has_hit_an_edge() -> bool:
	return (position.x > get_viewport_rect().end.x - right_edge_delta) or (position.x < get_viewport_rect().position.x - left_edge_delta)


func has_invaded() -> bool:
	return global_position.y + DISTANCE_TO_BOTTOM_OF_SPRITE > GAME_OVER_Y_POSITION


func explode() -> void:
	# TODO add explosion effects: sound
	set_collision_layer_value(3, false)
	SignalBus.invader_destroyed.emit(get_rid())
	$AnimatedSprite2D.play("explode", 2.0)
	await $AnimatedSprite2D.animation_finished
	queue_free()
