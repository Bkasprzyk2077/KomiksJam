extends Node2D

@export var crystal_count_to_dig: int = 5
var crystal_count_current: int = 0
@export var enemy_count_to_kill: int = 5
var enemy_count_current: int = 0
@export var task_count: int = 2
var current_task_count: int = 0

@export var should_flip: bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	crystal_count_to_dig = len(get_tree().get_nodes_in_group("crystal"))
	enemy_count_to_kill = len(get_tree().get_nodes_in_group("enemy"))
	GameEvents.connect("crystal_gather", on_crystal_gather)
	GameEvents.connect("enemy_killed", on_enemy_killed)

func _process(delta):
	if current_task_count >= task_count:
		GameEvents.emit_call_escape_ship()

func on_crystal_gather():
	crystal_count_current += 1
	if crystal_count_current >= crystal_count_to_dig:
		all_crystals_conected()
	
func on_enemy_killed():
	enemy_count_current += 1
	if enemy_count_current >= enemy_count_to_kill:
		all_enemies_killed()

func flip_planets():
	if should_flip:
		DialogManager.start_dialog("res://dialogs/3_crystals_2.txt")
		var big_s = get_tree().get_nodes_in_group("big_s")
		for planet in big_s:
			planet.get_node("Sprite1").texture = load("res://assets/planet_B/pB5_core_corrupted.png")
			planet.get_node("Sprite2").texture = load("res://assets/planet_B/pB2_orbita_corrupted.png")
			planet.get_node("Sprite3").texture = load("res://assets/planet_B/pB4_background_corrupted.png")
			planet.get_node("Sprite4").texture = load("res://assets/planet_B/pB1_glow_corrupted.png")
						
		var small_s = get_tree().get_nodes_in_group("small_s")
		for planet in small_s:
			planet.get_node("Front").texture = load("res://assets/other_planets/2LVL_SMALL_PLANET_corrupted.png")
			planet.get_node("Sprite4").texture = load("res://assets/other_planets/2LVL_SMALL_PLANET_GLOW_corrupted.png")


func all_crystals_conected():
	current_task_count += 1
	flip_planets()
	
func all_enemies_killed():
	current_task_count += 1

