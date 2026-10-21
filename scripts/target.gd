extends Area3D

var already_triggered = false

func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node3D) -> void:
	if not already_triggered:
		already_triggered = true
		State.add_star()
