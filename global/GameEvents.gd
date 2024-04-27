extends Node

signal crystal_gather
signal player_death

func emit_crystal_gather():
	crystal_gather.emit()
	
func emit_player_death():
	player_death.emit()
