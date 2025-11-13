extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Character":
		GameManager.add_coin()
		queue_free()
