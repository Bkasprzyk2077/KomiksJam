extends Node2D

@export var crystal_count_to_dig: int = 5
var crystal_count_current: int = 0
@export var enemy_count_to_kill: int = 5
var enemy_count_current: int = 0
@export var task_count: int = 2
var current_task_count: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	crystal_count_to_dig = len(get_tree().get_nodes_in_group("crystal"))
	enemy_count_to_kill = len(get_tree().get_nodes_in_group("enemy"))
	GameEvents.connect("crystal_gather", on_crystal_gather)
	GameEvents.connect("enemy_killed", on_enemy_killed)

func _process(delta):
	print(str(current_task_count) + " tasks per " + str(task_count))
	if current_task_count >= task_count:
		print("test")
		GameEvents.emit_call_escape_ship()

func on_crystal_gather():
	crystal_count_current += 1
	if crystal_count_current >= crystal_count_to_dig:
		all_crystals_conected()
	print(str(crystal_count_current) + " / " + str(crystal_count_to_dig))
	
func on_enemy_killed():
	enemy_count_current += 1
	if enemy_count_current >= enemy_count_to_kill:
		all_enemies_killed()
	print(str(enemy_count_current) + " / " + str(enemy_count_to_kill))

func all_crystals_conected():
	current_task_count += 1
	
func all_enemies_killed():
	current_task_count += 1

