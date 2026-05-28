extends Control

@onready var conf = preload("res://configuração.tscn")  

func _ready() -> void:
	if global.game_data.musica and Musica.is_playing == false:
		Musica.play_music(Musica.MUSICA_FUNDO_INCREMENTALIS)


func _on_start_button_pressed() -> void:
	Musica.play_SFX(Musica.START)
	get_tree().change_scene_to_file("res://control.tscn")


func _on_conf_button_pressed() -> void:
	Musica.play_SFX(Musica.menu_up)
	var config = conf.instantiate()
	add_child(config)


func _on_quit_button_pressed() -> void:
	Musica.play_SFX(Musica.menu_up)
	global.save_data()
	get_tree().quit()

# SFX dos botões (hover)

func _on_start_button_mouse_entered() -> void:
	Musica.play_SFX(Musica.hover)

func _on_conf_button_mouse_entered() -> void:
	Musica.play_SFX(Musica.hover)

func _on_quit_button_mouse_entered() -> void:
	Musica.play_SFX(Musica.hover)
