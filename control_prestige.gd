extends Control

@onready var prestige_qtd_label: Label = $VBoxContainer/VBoxContainer/prestige_qtd_label
@onready var prestigio_button: Button = $VBoxContainer/VBoxContainer/Prestigio_button
@onready var p_1_button: Button = $VBoxContainer/p1_button
@onready var no_p_1_warning_label: Label = $VBoxContainer/NoP1WarningLabel
@onready var p_2_button: Button = $VBoxContainer/p2_button
@onready var p_3_button: Button = $VBoxContainer/p3_button
@onready var p_4_button: Button = $VBoxContainer/p4_button
@onready var p_5_button: Button = $VBoxContainer/p5_button
@onready var end_game_button: Button = $HBoxContainer/EndGame_button
@onready var vanish_timer: Timer = $Timer

func _ready() -> void:
	check_disabled()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	prestige_qtd_label.text = "CERTIFICADOS: " + global.format(global.game_data.moedas_prestigio)
	p_1_button.tooltip_text = "Seus Upgrades ficam 2x mais potentes\ne ganham mais leveis!"
	p_2_button.tooltip_text = "A Velocidade Inicial\ndo Botão Principal é quintuplicada!"
	p_3_button.tooltip_text = "Inicia com um bônus de 20 experiencia\nAlém de ganhar mais um botão principal no inicio"
	p_4_button.tooltip_text = "Permite criar jogos sobre árvores!\nSeus botões iniciais terão 10 de experiencia\nO upgrade fica 2x mais barato"
	p_5_button.tooltip_text = "Permite criar jogos sobre coleta de lixo!\nSeus Assistentes ficam ativos desde o começo\nda run, além disso, seus upgrades serão Multiplicados ao inves de Adicionados"

func _on_p_1_button_pressed() -> void:
	if global.game_data.p1: 
		ja_possui()
	elif global.game_data.moedas_prestigio >= 1:
		global.game_data.moedas_prestigio -= 1
		global.game_data.p1 = true
		check_disabled()
		global.save_data()
	elif !global.game_data.p1: no_certificates()

func _on_p_2_button_pressed() -> void:
	if global.game_data.p2: 
		ja_possui()
	elif !global.game_data.p1: no_upg()
	elif global.game_data.moedas_prestigio < 5: no_certificates()
	elif global.game_data.moedas_prestigio >= 5:
		global.game_data.moedas_prestigio -= 5
		global.game_data.p2 = true
		check_disabled()
		global.save_data()

func _on_p_3_button_pressed() -> void:
	if global.game_data.p3: 
		ja_possui()
	elif !global.game_data.p1: no_upg()
	elif global.game_data.moedas_prestigio < 15: no_certificates()
	elif global.game_data.moedas_prestigio >= 15:
		global.game_data.moedas_prestigio -= 15
		global.game_data.p3 = true
		check_disabled()
		global.save_data()

func _on_p_4_button_pressed() -> void:
	if global.game_data.p4: 
		ja_possui()
	elif !global.game_data.p2 or !global.game_data.p3: no_upg()
	elif global.game_data.moedas_prestigio < 30: no_certificates()
	elif global.game_data.moedas_prestigio >= 30:
		global.game_data.moedas_prestigio -= 30
		global.game_data.p4 = true
		check_disabled()
		global.save_data()

func _on_p_5_button_pressed() -> void:
	if global.game_data.p5: 
		ja_possui()
	elif !global.game_data.p2 or !global.game_data.p3: no_upg()
	elif global.game_data.moedas_prestigio < 60: no_certificates()
	elif global.game_data.moedas_prestigio >= 60:
		global.game_data.moedas_prestigio -= 60
		global.game_data.p5 = true
		check_disabled()
		global.save_data()

func _on_end_game_button_pressed() -> void:
	if global.game_data.p6: 
		ja_possui()
	elif !global.game_data.p5: no_upg()
	elif global.game_data.moedas_prestigio < 120: no_certificates()
	elif global.game_data.moedas_prestigio >= 120:
		global.game_data.moedas_prestigio -= 120
		global.game_data.p6 = true
		check_disabled()
		global.save_data()
	# criar final do jogo aqui -----------------------------

func _on_prestige_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://control.tscn")

func _on_prestigio_button_pressed() -> void:
	if (global.game_data.p1):
		global.prestigio()
		global.save_data()
	else: 
		vanish_timer.start()
		no_p_1_warning_label.text = "Compre pelo menos um upgrade antes de\ncomeçar a criar um novo jogo!"

func _on_timer_timeout() -> void:
	no_p_1_warning_label.text = ""

func no_certificates() -> void:
	vanish_timer.start()
	no_p_1_warning_label.text = "Você não tem Certificados o Suficiente"

func no_upg() -> void:
	if end_game_button.button_pressed:
		vanish_timer.start()
		no_p_1_warning_label.text = "Obtenha todos os Upgrades\nde Prestigio para Terminar\nO Jogo!"
	else: 
		vanish_timer.start()
		no_p_1_warning_label.text = "Precisa ter o Upgrade anterior para\nLiberar este upgrade"

func ja_possui() -> void:
	vanish_timer.start()
	no_p_1_warning_label.text = "Você já possui este upgrade"

func check_disabled() -> void:
	if global.game_data.p1: 
		p_1_button.disabled
		p_1_button.text = "Comprado!"
	if global.game_data.p2: 
		p_2_button.disabled
		p_2_button.text = "Aprendeu!"
	if global.game_data.p3: 
		p_3_button.disabled
		p_3_button.text = "Aprendeu!"
	if global.game_data.p4: 
		p_4_button.disabled
		p_4_button.text = "Aprendeu!"
	if global.game_data.p5: 
		p_5_button.disabled
		p_5_button.text = "Aprendeu!"
	if global.game_data.p6: 
		end_game_button.disabled
		end_game_button.text = "Meus Parabéns\nVocê Finalizou o Jogo!"
