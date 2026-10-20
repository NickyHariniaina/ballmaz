extends RigidBody3D

@export var roll_force: float = 10.0
@onready var camera = get_node("../Camera3D")
@onready var spawn_position = global_position

func _physics_process(delta: float) -> void:
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if Input.is_action_just_pressed("ui_accept"):
		respawn()
	if input_dir.length() > 0:
		var forward = camera.global_transform.basis.z
		var right = camera.global_transform.basis.x
		
		var move_dir = (right * input_dir.x + forward * input_dir.y).normalized()
		
		apply_central_force(move_dir * roll_force * 5.0)

func respawn():
	global_position = spawn_position
	linear_velocity = Vector3.ZERO
	angular_velocity = Vector3.ZERO
	
	if camera:
		camera.global_position = spawn_position + Vector3(0, 5, 10)

func _on_kill_zone_body_entered(body: Node3D) -> void:
	if body.has_method("respawn"):
		body.respawn()
