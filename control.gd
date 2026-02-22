extends Control

@onready var experiencia_label: Label = $MarginContainer/VBoxContainer/HBoxContainer/ExperienciaLabel
@onready var velo_show_label: Label = $MarginContainer/VBoxContainer/HBoxContainer/VeloShow_label
@onready var velocidade_upg: Button = $MarginContainer/VBoxContainer/HBoxContainer/HBoxContainer/Velocidade_upg
@onready var comprar_livro_upg: Button = $MarginContainer/VBoxContainer/HBoxContainer/HBoxContainer2/ComprarLivro_upg
@onready var grid_container: GridContainer = $MarginContainer/VBoxContainer/ScrollContainer/GridContainer
@onready var mais_exp_upg: Button = $MarginContainer/VBoxContainer/HBoxContainer/HBoxContainer3/MaisEXP_upg
@onready var mais_exp_label: Label = $MarginContainer/VBoxContainer/HBoxContainer/HBoxContainer3/MaisEXP_label
@onready var assistente_upg: Button = $MarginContainer/VBoxContainer/HBoxContainer/HBoxContainer4/Assistente_upg
@onready var assistente_label: Label = $MarginContainer/VBoxContainer/HBoxContainer/HBoxContainer4/Assistente_label


const BOTAO_PRINCIPAL = preload("uid://iupichumrp0l")

func _ready() -> void:
	recarregar_botoes_salvos()

func _process(delta: float) -> void:
	experiencia_label.text = "Experiencia: " + str(global.game_data.money)
	velo_show_label.text = "Velocidade: " + str(global.game_data.velo_estudo)
	velocidade_upg.tooltip_text = "Preço: " + str(global.game_data.velocidade_custo)
	comprar_livro_upg.tooltip_text = "Preço: " + str(global.game_data.livros_custo)
	mais_exp_upg.tooltip_text = "Preço: " + str(global.game_data.EXP_custo)
	assistente_upg.tooltip_text = "Preço: " + str(global.game_data.Assistente_custo)
	 # botões e labels


func recarregar_botoes_salvos() -> void:
	for child in grid_container.get_children():
		child.queue_free()
	
	for i in range(global.game_data.qtd_livros):
		var novo_botao = BOTAO_PRINCIPAL.instantiate()
		grid_container.add_child(novo_botao)

func _on_velocidade_upg_pressed() -> void:
	if global.game_data.velo_estudo >= 4.0:
		velocidade_upg.disabled = true
		velocidade_upg.text = "Maximizado!"
	elif global.game_data.money >= global.game_data.velocidade_custo:
		global.game_data.money -= global.game_data.velocidade_custo
		global.game_data.velo_estudo += 0.2
		global.game_data.velocidade_custo += int(round(global.game_data.velocidade_custo * 0.5))
		global.save_data()

func _on_comprar_livro_upg_pressed() -> void:
	if global.game_data.money >= global.game_data.livros_custo:
		global.game_data.money -= global.game_data.livros_custo
		global.game_data.qtd_livros += 1
		global.game_data.livros_custo += int(round(global.game_data.livros_custo * 2))
		
		var novo_botao = BOTAO_PRINCIPAL.instantiate()
		grid_container.add_child(novo_botao)
		
		global.save_data()

func _on_mais_exp_upg_pressed() -> void:
	if global.game_data.money >= global.game_data.EXP_custo:
		global.game_data.money -= global.game_data.EXP_custo
		global.game_data.ganhos_EXP *= 2
		global.game_data.EXP_custo += int(round(global.game_data.EXP_custo * 2))
		global.save_data()

func _on_assistente_upg_pressed() -> void:
	if global.game_data.money >= global.game_data.Assistente_custo:
		global.game_data.money -= global.game_data.Assistente_custo
		if global.game_data.Assistente_AFK_gains > 10:
			global.game_data.Assistente_AFK_gains += 2
		else: global.game_data.Assistente_AFK_gains += 1
		global.game_data.Assistente_custo += int(round(global.game_data.Assistente_custo * 2))
		global.save_data()

func _on_timer_timeout() -> void:
	global.game_data.money += global.game_data.Assistente_AFK_gains
