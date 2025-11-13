extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Character":
		print("You Died")
		body.global_position = GameManager.checkpoint_position
		body.velocity = Vector2.ZERO
