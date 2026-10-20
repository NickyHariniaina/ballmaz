extends Camera3D

@export var target: Node3D
@export var distance: float = 10.0
@export var height: float = 5.0
@export var mouse_sensitivity: float = 0.005

var _rotation_y: float = 0.0

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		_rotation_y -= event.relative.x * mouse_sensitivity

func _physics_process(delta: float) -> void:
	if not target:
		return
		
	var offset_x = sin(_rotation_y) * distance
	var offset_z = cos(_rotation_y) * distance
	
	var target_position = target.global_position + Vector3(offset_x, height, offset_z)
	
	global_position = global_position.lerp(target_position, delta * 10.0)
	
	look_at(target.global_position)
