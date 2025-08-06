extends Node2D

func _ready() -> void:
	SignalBus.game_over.connect(_on_game_over)
	SignalBus.player_ship_shoot.connect(_on_player_ship_shoot)
	$BackgroundMusic.play()

func _on_player_ship_shoot(bullet: Resource, location: Vector2) -> void:
	var spawned_bullet: Area2D = bullet.instantiate()
	spawned_bullet.position = location
	$PlayerBullets.add_child(spawned_bullet)
	spawned_bullet.position = location
	
func _on_game_over() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED
