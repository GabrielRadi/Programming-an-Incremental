extends Control

@onready var line_edit: LineEdit = $LineEdit

func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	pass


func _on_line_edit_text_submitted(new_text: String) -> void:
	line_edit.deselect()


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://control.tscn")

# sfx

func _on_button_mouse_entered() -> void:
		Musica.play_SFX(Musica.hover)


func _on_line_edit_focus_entered() -> void:
	Musica.play_SFX(Musica.hover)
