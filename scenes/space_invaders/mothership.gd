extends Area2D

class_name Mothership

var health = 3
var speed = 60.0
var direction = Vector2.RIGHT
var last_taken_damage_from: RID


func _ready() -> void:
	$AudioStreamPlayer.play()


func _physics_process(delta: float) -> void:
	if has_left_screen():
		SignalBus.mothership_retreating.emit()
	position += speed * direction * delta


func has_left_screen() -> bool:
	return (position.x > get_viewport_rect().end.x) or (position.x < get_viewport_rect().position.x)


func take_damage(bullet_rid: RID) -> void:
	if bullet_rid != last_taken_damage_from:
		last_taken_damage_from = bullet_rid
		health -= 1
		if health == 0:
			explode()


func explode() -> void:
	SignalBus.mothership_destroyed.emit()
	# TODO add explosion and sfx
	queue_free()


func set_new_movement_parameters() -> void:
	speed = randf_range(40, 80)
	direction = Vector2.RIGHT if randi_range(0, 1) == 0 else Vector2.LEFT
	position = Vector2(0, 16) if direction == Vector2.RIGHT else Vector2(832, 16)
