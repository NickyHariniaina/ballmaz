extends Node

var current_level_index: int = 0
var levels: Array[String] = [
	"res://level/level_1.tscn",
	"res://level/level_2.tscn",
]

func _ready() -> void:
	pass

func go_to_next_level() -> void:
	current_level_index += 1
	print(current_level_index)
	if current_level_index < levels.size():
		print(current_level_index)
		get_tree().change_scene_to_file(levels[current_level_index])
	else:
		print("Wait for the next release mf")
