extends Node

var save_path = "user://savegame.tres"
var game_data: GameData

func _ready() -> void:
	load_data()

func save_data() -> void:
	Time.get_unix_time_from_system()
	game_data.ultimo_login = Time.get_unix_time_from_system()
	ResourceSaver.save(game_data, save_path)
	print("Jogo Salvo!")

func load_data() -> void:
	if ResourceLoader.exists(save_path):
		game_data = ResourceLoader.load(save_path) as GameData
		offline_money()
	else:
		game_data = GameData.new()

func offline_money() -> void:
	var this_time = Time.get_unix_time_from_system()
	var tempo = this_time - game_data.ultimo_login
	var ganhos_afk = tempo * game_data.Assistente_AFK_gains
	if ganhos_afk > 0:
		@warning_ignore("narrowing_conversion")
		game_data.money += ganhos_afk

func gain_prestige() -> void:
	if (game_data.money >= game_data.money_for_prestigio):
		game_data.moedas_prestigio += 1
		game_data.money_for_prestigio *= 1.3
		save_data()

func prestigio() -> void:
	if game_data.p3:
		game_data.money = 20
	else: game_data.money = 0
	if game_data.p2:
		game_data.velo_estudo = 1.0
	else: game_data.velo_estudo = 0.2
	game_data.velocidade_custo = 5
	if game_data.p3:
		game_data.qtd_livros = 2
	else: game_data.qtd_livros = 1 
	game_data.livros_custo = 10
	if game_data.p4: 
		game_data.ganhos_EXP = 2
		game_data.EXP_custo = 10
	else:
		game_data.ganhos_EXP = 1
		game_data.EXP_custo = 20
	game_data.Assistente_custo = 50
	if game_data.p5: game_data.Assistente_AFK_gains = 2
	else: game_data.Assistente_AFK_gains = 0
	if (game_data.nivel_de_prestigio < 1 && global.game_data.p1):
		game_data.nivel_de_prestigio = 1
		get_tree().change_scene_to_file("res://control.tscn")
		save_data()
	if (game_data.p4):
		get_tree().change_scene_to_file("res://escolha_de_ODS.tscn")
		save_data()
	else:
		get_tree().change_scene_to_file("res://control.tscn")
		save_data()

func format(valor: float) -> String:
	if valor < 1000:
		return str(floor(valor)) # in-game: 950
	
	if valor < 1000000:
		return str(snapped(valor / 1000.0, 0.1)) + "K" # in-game: 1.5K
	
	if valor < 1000000000:
		return str(snapped(valor / 1000000.0, 0.1)) + "M" # in-game: 1.5M
	
	if valor < 1000000000000:
		return str(snapped(valor / 1000000000.0, 0.1)) + "B" # In-game:1.5B
		
	return str(snapped(valor / 1000000000000.0, 0.1)) + "T" # Ingame: 1.5T
