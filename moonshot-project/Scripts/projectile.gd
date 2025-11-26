# scripts/projectile.gd
extends Area2D

@export var speed: float = 900.0
@export var damage: int = 15
@export var lifetime: float = 2.0
var velocity: Vector2 = Vector2.ZERO

func _ready():
	$CollisionShape2D.disabled = false
	# start one-shot lifetime timer using create_timer
	_start_lifetime()

func _physics_process(delta):
	position += velocity * delta

func launch(dir: Vector2):
	velocity = dir.normalized() * speed
	rotation = dir.angle()

func _start_lifetime():
	var t = get_tree().create_timer(lifetime)
	t.timeout.connect(self._on_life_timeout)

func _on_life_timeout():
	queue_free()

# Detect hitting physics bodies (CharacterBody2D enemies)
func _on_area_entered(area: Area2D) -> void:
	# prefer body_entered if enemy is PhysicsBody2D; but area_entered can work if enemy uses Area2D hitbox
	if area.has_method("take_damage"):
		area.take_damage(damage)
		queue_free()

# Also connect body_entered for CharacterBody2D collisions (recommended)
func _on_body_entered(body: Node) -> void:
	if body.has_method("take_damage"):
		body.take_damage(damage)
		queue_free()
