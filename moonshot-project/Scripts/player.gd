# scripts/player.gd
extends CharacterBody2D

@export var speed: float = 280.0
@export var dash_speed: float = 720.0
@export var dash_time: float = 0.18
@export var dash_cooldown: float = 0.9
@export var max_health: int = 100

var health: int
var velocity: Vector2 = Vector2.ZERO
var is_dashing: bool = false
var dash_timer: float = 0.0
var dash_cooldown_timer: float = 0.0

onready var weapon_holder = $WeaponHolder
# weapon will be a scene instance that exposes fire(direction) method
var active_weapon = null

func _ready():
	health = max_health
	set_process(true)
	set_physics_process(true)

func _physics_process(delta):
	_handle_movement(delta)
	_handle_dash(delta)
	_aim_weapon()

func _handle_movement(delta):
	if is_dashing:
		# moving in current velocity direction while dashing
		velocity = velocity.normalized() * dash_speed
	else:
		var input_vec = Vector2.ZERO
		input_vec.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
		input_vec.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
		if input_vec.length() > 0.1:
			velocity = input_vec.normalized() * speed
		else:
			velocity = Vector2.ZERO
	velocity = move_and_slide(velocity)

func _handle_dash(delta):
	dash_cooldown_timer = max(0.0, dash_cooldown_timer - delta)
	if is_dashing:
		dash_timer -= delta
		if dash_timer <= 0.0:
			is_dashing = false
	elif Input.is_action_just_pressed("dash") and dash_cooldown_timer <= 0.0:
		is_dashing = true
		dash_timer = dash_time
		dash_cooldown_timer = dash_cooldown
		# optional: play dash particles/sfx
		$Particles2D.emitting = true
		$AudioStreamPlayer2D.play()

func _aim_weapon():
	if active_weapon:
		var mouse_pos = get_global_mouse_position()
		var dir = (mouse_pos - global_position).normalized()
		# rotate sprite or weapon holder to face direction (visual)
		weapon_holder.rotation = dir.angle()
		if Input.is_action_pressed("shoot"):
			active_weapon.fire(global_position, dir)

func take_damage(amount: int):
	health -= amount
	if health <= 0:
		health = 0
		emit_signal("died")
	# optional: flash, particles
