extends Label

func _ready() -> void:
	State.stars_changed.connect(_on_stars_changed)
	_on_stars_changed(State.current_star)

func _on_stars_changed(new_amount: int) -> void:
	text = str(new_amount)
