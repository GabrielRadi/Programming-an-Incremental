extends Control

@onready var conf = preload("res://configuração.tscn")  

func _ready() -> void:
	if global.game_data.musica and Musica.is_playing == false:
		Musica.play_music(Musica.MUSICA_FUNDO_INCREMENTALIS)

func _process(delta: float) -> void:
	pass


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://control.tscn")


func _on_conf_button_pressed() -> void:
	var config = conf.instantiate()
	add_child(config)
