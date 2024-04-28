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


func _physics_process(delta):
	$Tasks/MarginContainer/VBoxContainer/crystals.text = "Kryształki:" + str(crystal_count_current) + "/" + str(crystal_count_to_dig)
	$Tasks/MarginContainer/VBoxContainer/enemies.text = "Przeciwnicy:" + str(enemy_count_current) + "/" + str(enemy_count_to_kill)
	var ship = get_tree().get_first_node_in_group("box_ship")
	if ship:
		$Tasks/MarginContainer/VBoxContainer/boxes.text = "Pudełka:" + str(ship.box_count_current) + "/" + str(ship.box_count_to_kick)
	
	
func on_crystal_gather():
	crystal_count_current += 1
	if crystal_count_current >= crystal_count_to_dig:
		all_crystals_conected()
	
func on_enemy_killed():
	enemy_count_current += 1
	if enemy_count_current >= enemy_count_to_kill:
		all_enemies_killed()

func all_crystals_conected():
	current_task_count += 1
	DialogManager.start_dialog("res://dialogs/task_end_crystals.txt")
	if current_task_count >= task_count:
		GameEvents.emit_call_escape_ship()
		flip_planets()
	
func all_enemies_killed():
	current_task_count += 1
	DialogManager.start_dialog("res://dialogs/task_end_enemies.txt")
	if current_task_count >= task_count:
		GameEvents.emit_call_escape_ship()
		flip_planets()
		
func flip_planets():
	if should_flip:
		DialogManager.start_dialog("res://dialogs/3_crystals_2.txt")
		var a_planets = get_tree().get_nodes_in_group("planet_a")
		for planet in a_planets:
			planet.get_node("Front").texture = load("res://assets/planet_A/planeta a_corrupted.png")
			planet.get_node("Sprite4").texture = load("res://assets/planet_A/planeta a gradient_corrupted.png")
						
		var c_planets = get_tree().get_nodes_in_group("planet_c")
		for planet in c_planets:
			planet.get_node("Front").texture = load("res://assets/planet_C/planeta_c_corrupted.png")
			planet.get_node("Sprite4").texture = load("res://assets/planet_A/planeta a gradient_corrupted.png")

