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
		game_data.money += ganhos_afk
