extends Node

signal crystal_gather
signal enemy_killed
signal player_death
signal call_escape_ship

func emit_crystal_gather():
	crystal_gather.emit()
	
func emit_enemy_killed():
	enemy_killed.emit()
	
func emit_player_death():
	player_death.emit()

func emit_call_escape_ship():
	call_escape_ship.emit()
