extends CanvasLayer

# --- NODES ---
@onready var coin_label: Label = $CoinLabel
@onready var health_bar: TextureProgressBar = $HealthBar
@onready var goop_bar: TextureProgressBar = $GoopBar

# --- VARIABLES ---
var coins: int = 0

func _ready() -> void:
	update_coin_label()
	update_health_bar(5, 5)
	update_goop_bar(0, 100)

# --- COINS ---
func add_coins(amount: int) -> void:
	coins += amount
	update_coin_label()

func remove_coins(amount: int) -> void:
	coins = max(coins - amount, 0)
	update_coin_label()

func update_coin_label() -> void:
	coin_label.text = "Coins: " + str(coins)

# --- HEALTH BAR ---
func update_health_bar(current: int, max_value: int) -> void:
	health_bar.max_value = max_value
	health_bar.value = current

# --- GOOP BAR ---
func update_goop_bar(current: float, max_value: float) -> void:
	goop_bar.max_value = max_value
	goop_bar.value = current
