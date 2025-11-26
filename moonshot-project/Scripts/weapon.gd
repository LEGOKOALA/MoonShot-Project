extends Node2D

@export var fire_rate := 0.25
@export var bullet_scene: PackedScene

var can_shoot := true

func _ready():
	$FireRate.wait_time = fire_rate
	$FireRate.one_shot = true

func shoot(target_pos: Vector2):
	if not can_shoot:
		return

	can_shoot = false
	$FireRate.start()

	# Make bullet
	var bullet = bullet_scene.instantiate()
	get_tree().current_scene.add_child(bullet)
	bullet.global_position = $Muzzle.global_position
	bullet.look_at(target_pos)

func _on_FireRate_timeout():
	can_shoot = true
