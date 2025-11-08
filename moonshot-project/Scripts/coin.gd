extends Area2D

# Signal to notify coin collected
signal collected

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Character":
		emit_signal("collected")
		queue_free()
