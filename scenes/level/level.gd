extends Node2D

func _ready() -> void:
	$BackgroundMusic.play()


func _on_player_ship_shoot(bullet: Resource, location: Vector2) -> void:
	var spawned_bullet: Area2D = bullet.instantiate()
	spawned_bullet.position = location
	$PlayerBullets.add_child(spawned_bullet)
	spawned_bullet.position = location
