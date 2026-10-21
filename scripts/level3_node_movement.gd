extends Node3D
@onready var animation_player = $AnimationPlayer
@onready var area = $Area3D


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is RigidBody3D:
		animation_player.play("make_jump")
