extends Control

@onready var texto_mutavel: Label = $"MarginContainer/VBoxContainer/texto mutavel"
@onready var ods_15_reflorestamento: Button = $"MarginContainer/VBoxContainer/ODS_15(Reflorestamento)"
@onready var ods_12_lixo: Button = $"MarginContainer/VBoxContainer/ODS_12 (Lixo)"
@onready var timer: Timer = $Timer


func _ready() -> void:
	texto_mutavel.text = "Escolha sua ODS!"

func _process(delta: float) -> void:
	pass

func _on_ods_15_reflorestamento_pressed() -> void:
	if !global.game_data.p4:
		texto_mutavel.text = "Você precisa do upgrade\n'Estudar a Natureza'"
		timer.start()
	else:
		Musica.play_SFX(Musica.START)
		get_tree().change_scene_to_file("res://control.tscn")
		global.game_data.nivel_de_prestigio = 2
		global.game_data.bg = "PlantaBg"
		global.save_data()

func _on_ods_12_lixo_pressed() -> void:
	if !global.game_data.p5:
		texto_mutavel.text = "Você precisa do upgrade\n'Aprender Coleta de Lixo'"
		timer.start()
	else:
		Musica.play_SFX(Musica.START)
		get_tree().change_scene_to_file("res://control.tscn")
		global.game_data.nivel_de_prestigio = 3
		global.game_data.bg = "LixoBg"
		global.save_data()

func _on_timer_timeout() -> void:
	texto_mutavel.text = "Escolha sua ODS!"

# hovers de botões para som

func _on_ods_12_lixo_mouse_entered() -> void:
	Musica.play_SFX(Musica.hover)

func _on_ods_15_reflorestamento_mouse_entered() -> void:
	Musica.play_SFX(Musica.hover)
