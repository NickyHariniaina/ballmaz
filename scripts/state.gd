extends Node

signal stars_changed(new_amount)

var current_level_index: int = 0
var current_star: int = 0

# On garde les chemins des scènes
var levels: Array[String] = [
	"res://level/level_1.tscn",
	"res://level/level_2.tscn",
]

# Un dictionnaire pour sauvegarder le meilleur score de chaque niveau
# Format : { "res://level/level_1.tscn": 5, "res://level/level_2.tscn": 0 }
var stars_per_level: Dictionary = {}

func _ready() -> void:
	# Au lancement du jeu, on charge le score du premier niveau
	load_level_stars()

# Appelé à chaque fois qu'on ramasse une étoile
func add_star(amount: int = 1) -> void:
	current_star += amount
	stars_changed.emit(current_star)

# Appelé quand le joueur meurt ou recommence le niveau
func reset_stars_for_current_level() -> void:
	var current_path = levels[current_level_index]
	current_star = stars_per_level.get(current_path, 0)
	stars_changed.emit(current_star)

# Appelé quand le joueur finit le niveau (avant de passer au suivant)
func save_stars_for_current_level() -> void:
	var current_path = levels[current_level_index]
	var previous_best = stars_per_level.get(current_path, 0)
	
	# On ne sauvegarde que si le joueur a fait un meilleur score
	if current_star > previous_best:
		stars_per_level[current_path] = current_star

# Appelé au changement de niveau pour charger le bon nombre d'étoiles
func load_level_stars() -> void:
	var current_path = levels[current_level_index]
	current_star = stars_per_level.get(current_path, 0)
	stars_changed.emit(current_star)

func go_to_next_level() -> void:
	# 1. On sauvegarde les étoiles du niveau qu'on vient de finir
	save_stars_for_current_level()
	
	# 2. On passe au niveau suivant
	current_level_index += 1
	
	if current_level_index < levels.size():
		load_level_stars() # On charge les étoiles du nouveau niveau
		get_tree().change_scene_to_file(levels[current_level_index])
	else:
		print("Félicitations ! Tu as fini le jeu !")
