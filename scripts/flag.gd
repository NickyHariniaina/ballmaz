extends Area3D

@export var text_node: Label3D
var level_finished = false

func _ready() -> void:
	text_node.visible = false
	body_entered.connect(_on_body_entered)
	
func _physics_process(delta: float) -> void:
	if level_finished and Input.is_action_just_pressed("enter"):
		State.go_to_next_level()

func _on_body_entered(body: Node3D) -> void:
	if body.has_method("respawn"):
		level_finished = true
		text_node.visible = true
