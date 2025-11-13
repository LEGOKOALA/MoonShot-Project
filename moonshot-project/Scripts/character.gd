extends CharacterBody2D

# --- CONSTANTS ---
const SPEED = 100.0
const JUMP_VELOCITY = -300.0

# --- NODES ---
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

# --- HEALTH ---
@export var max_health := 5
var current_health := max_health

# --- GOOP ---
@export var max_goop := 100.0
@export var heal_cost := max_goop / 3.0
var current_goop := 0.0
var can_heal := true

# --- MAIN LOOP ---
func _physics_process(_delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * _delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := 0
	if Input.is_action_pressed("move_right"):
		direction += 1
	if Input.is_action_pressed("move_left"):
		direction -= 1

	if direction != 0:
		velocity.x = direction * SPEED
		animated_sprite.flip_h = direction < 0
		animated_sprite.play("Run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if is_on_floor():
			animated_sprite.play("Idle")

	move_and_slide()

	# Healing
	if Input.is_action_pressed("heal"):
		handle_healing(_delta)

# --- HEALING ---
func handle_healing(_delta: float) -> void:
	if can_heal and current_health < max_health and current_goop >= heal_cost:
		can_heal = false
		perform_heal()
		await get_tree().create_timer(1.0).timeout
		can_heal = true

func perform_heal() -> void:
	current_goop -= heal_cost
	current_health += 1
	current_health = clamp(current_health, 0, max_health)
	current_goop = clamp(current_goop, 0, max_goop)
	print("💊 Healed! Health:", current_health, "/", max_health, "| Goop:", current_goop, "/", max_goop)
	GameManager.update_ui_health(current_health, max_health)
	GameManager.update_ui_goop(current_goop, max_goop)

# --- DAMAGE ---
func take_damage(amount: int) -> void:
	current_health -= amount
	if current_health <= 0:
		die()
	else:
		print("💢 Damage taken! Health:", current_health, "/", max_health)
		GameManager.update_ui_health(current_health, max_health)

# --- GOOP COLLECTION ---
func add_goop(amount: float) -> void:
	current_goop = clamp(current_goop + amount, 0, max_goop)
	print("🧪 Goop:", current_goop, "/", max_goop)
	GameManager.update_ui_goop(current_goop, max_goop)

# --- DEATH ---
func die() -> void:
	print("☠️ You Died!")
	GameManager.player_died()
