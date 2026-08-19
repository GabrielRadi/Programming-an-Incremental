extends Control

@onready var musica_config_button: Button = $MarginContainer/VBoxContainer/musica_config_button
@onready var sfx_config_button: Button = $MarginContainer/VBoxContainer/sfx_config_button

func _ready() -> void:
	if global.game_data.musica:
		musica_config_button.text = "MUSICA: ATIVADO"
	else: musica_config_button.text = "MUSICA: DESATIVADO"
	if global.game_data.sfx:
		sfx_config_button.text = "SFX: DESATIVADO"
	else: sfx_config_button.text = "SFX: ATIVADO"

func _on_apagar_dados_button_pressed() -> void:
	# reset global de variaveis
	Musica.play_SFX(Musica.reset)
	global.game_data.money = 0
	global.game_data.velo_estudo = 0.2
	global.game_data.velocidade_custo = 5
	global.game_data.qtd_livros = 1 
	global.game_data.livros_custo = 10
	global.game_data.ganhos_EXP = 1
	global.game_data.EXP_custo = 20
	global.game_data.Assistente_custo = 50
	global.game_data.Assistente_AFK_gains = 0
	# reset de prestigios
	global.game_data.nivel_de_prestigio = 0
	global.game_data.moedas_prestigio = 1000 # alterar essa variavel para testar os prestigios
	global.game_data.money_for_prestigio = 1000000
	global.game_data.p1 = false
	global.game_data.p2 = false
	global.game_data.p3 = false
	global.game_data.p4 = false
	global.game_data.p5 = false
	global.game_data.p6 = false
	get_tree().change_scene_to_file("res://menu.tscn")
	global.save_data()

func _on_voltar_button_pressed() -> void:
	Musica.play_SFX(Musica.click)
	get_tree().change_scene_to_file("res://menu.tscn")

func _on_musica_config_button_pressed() -> void:
	Musica.play_SFX(Musica.click)
	if global.game_data.musica:
		Musica.stop_music()
		Musica.is_playing = false
		musica_config_button.text = "MUSICA: DESATIVADO"
		global.game_data.musica = false
	else: 
		Musica.play_music(Musica.MUSICA_FUNDO_INCREMENTALIS)
		Musica.is_playing = true
		musica_config_button.text = "MUSICA: ATIVADO"
		global.game_data.musica = true
	global.save_data()

func _on_sfx_config_button_pressed() -> void:
	Musica.play_SFX(Musica.click)
	var sfx_bus_index = AudioServer.get_bus_index("SFX")
	if global.game_data.sfx:
		sfx_config_button.text = "SFX: ATIVADO"
		global.game_data.sfx = false
		AudioServer.set_bus_mute(sfx_bus_index, global.game_data.sfx)
	else: 
		Musica.play_SFX(Musica.menu_up)
		sfx_config_button.text = "SFX: DESATIVADO"
		global.game_data.sfx = true
		AudioServer.set_bus_mute(sfx_bus_index, global.game_data.sfx)
	global.save_data()

# SFX de botões

func _on_voltar_button_mouse_entered() -> void:
	Musica.play_SFX(Musica.hover)

func _on_musica_config_button_mouse_entered() -> void:
	Musica.play_SFX(Musica.hover)

func _on_sfx_config_button_mouse_entered() -> void:
	Musica.play_SFX(Musica.hover)

func _on_apagar_dados_button_mouse_entered() -> void:
	Musica.play_SFX(Musica.hover)
