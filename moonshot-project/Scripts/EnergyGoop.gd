extends Area2D
@export var energy_amount := 0.1  # small increments per pickup

func _on_body_entered(body):
	if body.name == "Character":
		body.collect_energy(energy_amount)
		queue_free()
