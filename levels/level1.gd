extends Node2D

@export var crystal_count_to_dig: int = 5
var crystal_count_current: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	GameEvents.connect("crystal_gather", on_crystal_gather)
	

func on_crystal_gather():
	crystal_count_current += 1
	if crystal_count_current >= crystal_count_to_dig:
		all_crystals_conected()
	print(crystal_count_current)
	

func all_crystals_conected():
	print("ALL crystals colected")
