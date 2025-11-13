extends Area2D

func _on_body_entered(body):
	if body.name == "Character":
		GameManager.set_checkpoint(body.global_position)
		print("Checkpoint set at: ", body.global_position)
