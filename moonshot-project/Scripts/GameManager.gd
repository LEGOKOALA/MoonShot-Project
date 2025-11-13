extends Node

var coins := 0
var checkpoint_position: Vector2 = Vector2.ZERO
@onready var ui = $"../UI"

# --- COINS ---
func add_coin() -> void:
	coins += 1
	print("💰 Coins:", coins)
	ui.add_coins(1)

# --- CHECKPOINT ---
func set_checkpoint(pos: Vector2) -> void:
	checkpoint_position = pos

# --- UI UPDATES ---
func update_ui_health(current: int, max_value: int) -> void:
	ui.update_health_bar(current, max_value)

func update_ui_goop(current: float, max_value: float) -> void:
	ui.update_goop_bar(current, max_value)

func player_died() -> void:
	print("☠️ Player died! Handle respawn here.")
