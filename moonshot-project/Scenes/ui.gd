extends CanvasLayer

# Reference to the Label
@onready var coin_label: Label = $CoinLabel

# Current number of coins
var coins: int = 0

func _ready():
	update_coin_label()

# Call this function whenever the player collects coins
func add_coins(amount: int) -> void:
	coins += amount
	update_coin_label()

func remove_coins(amount: int) -> void:
	coins = max(coins - amount, 0)
	update_coin_label()

func update_coin_label() -> void:
	coin_label.text = str(coins)
