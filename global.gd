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
