extends MarginContainer

@onready var label = $HBoxContainer/MarginContainer/Label
@onready var texture_rect = $HBoxContainer/MarginContainer2/Avatar
@onready var letter_display_timer = $LetterDisplayTimer
@onready var animation_player = $AnimationPlayer

var faces = ["res://assets/icon.svg", "res://assets/siencetist/naukowiec.png"]

var dialog_lines = []

const MAX_WIDTH = 256
var text = ""
var letter_index = 0
var line_index = 0
var letter_time = 0.05
var space_time = 0.06
var punctuation_time = 0.2

signal animation_finished


func _input(event):
	if event.is_action_pressed("ui_accept") and dialog_lines:
		letter_index = 0
		display_line()

func set_up_text(text_file: String):
	print(text_file)
	var file = FileAccess.open(text_file, FileAccess.READ)
	while not file.eof_reached():
		dialog_lines.append(file.get_line())
	dialog_lines.pop_back()
	label.text = ""
	display_line()
	
func display_line():
	if line_index >= len(dialog_lines):
		end_dialog()
		return
	label.text = ""
	text = dialog_lines[line_index]
	line_index += 1
	match text[0]:
		'!':
			texture_rect.texture = load(faces[0])
		'?':
			texture_rect.texture = load(faces[1])
	text = text.erase(0, 1)
	_display_letter()
	
func _display_letter():
	label.text += text[letter_index]
	letter_index += 1
	if letter_index >= text.length():
		letter_index = 0
		return
	letter_display_timer.start(letter_time)

func emit_animation_finished():
	animation_finished.emit()
	
func end_dialog():
	animation_player.play("out")

func _on_letter_display_timer_timeout():
	_display_letter()
