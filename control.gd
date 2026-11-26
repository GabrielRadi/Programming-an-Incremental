extends Control

@onready var experiencia_label: Label = %ExperienciaLabel
@onready var velo_show_label: Label = %VeloShow_label
@onready var velocidade_upg: Button = %Velocidade_upg
@onready var velocidade_label: Label = %Velocidade_label
@onready var comprar_livro_upg: Button = %ComprarLivro_upg
@onready var comprar_livro_label: Label = %ComprarLivro_label
@onready var grid_container: GridContainer = %GridContainer
@onready var mais_exp_upg: Button = %MaisEXP_upg
@onready var mais_exp_label: Label = %MaisEXP_label
@onready var assistente_upg: Button = %Assistente_upg
@onready var assistente_label: Label = %Assistente_label
@onready var texture_rect: TextureRect = %TextureRect
@onready var prestige_button: Button = %Prestige_Button
@onready var leave_button: Button = %Leave_Button

const BOTAO_PRINCIPAL = preload("uid://iupichumrp0l")

func _ready() -> void: # função pra carregar os elementos como objetos (botão principal etc)
	check_status()
	trocar_botoes()
	check_disabled()
	recarregar_botoes_salvos()
	trocar_background(global.game_data.bg)

func _process(_delta: float) -> void:
	experiencia_label.text = "Experiencia: " + global.format(global.game_data.money)
	velo_show_label.text = "Velocidade: " + str(global.game_data.velo_estudo)
	velocidade_upg.tooltip_text = "Preço: " + str(global.game_data.velocidade_custo)
	comprar_livro_upg.tooltip_text = "Preço: " + str(global.game_data.livros_custo)
	mais_exp_upg.tooltip_text = "Preço: " + str(global.game_data.EXP_custo)
	assistente_upg.tooltip_text = "Preço: " + str(global.game_data.Assistente_custo)
	global.gain_prestige()
	# botões e labels

func recarregar_botoes_salvos() -> void:
	for child in grid_container.get_children():
		child.queue_free()
	
	for i in range(global.game_data.qtd_livros):
		var novo_botao = BOTAO_PRINCIPAL.instantiate()
		grid_container.add_child(novo_botao)

func check_disabled() -> void: #checa todos os botões pra ver se devem ser desativados
	if global.game_data.velo_estudo >= 8.0 && global.game_data.p1:
		global.game_data.velo_estudo = 8.0 # ELIF relacionado ao Prestigio 1
		velocidade_upg.text = "Maximizado!"
		@warning_ignore("standalone_expression")
		velocidade_upg.disabled #funcional
	elif global.game_data.velo_estudo >= 4.0 && !global.game_data.p1:
		global.game_data.velo_estudo = 4.0
		velocidade_upg.text = "Maximizado!"
		@warning_ignore("standalone_expression")
		velocidade_upg.disabled #funcional
	if global.game_data.qtd_livros >= 5 && !global.game_data.p1:
		global.game_data.qtd_livros = 5
		comprar_livro_upg.text = "Maximizado!"
		@warning_ignore("standalone_expression")
		comprar_livro_upg.disabled #funcional
	elif global.game_data.qtd_livros >= 10 && global.game_data.p1:
		global.game_data.qtd_livros = 10
		comprar_livro_upg.text = "Maximizado!"
		@warning_ignore("standalone_expression")
		comprar_livro_upg.disabled #funcional

	if global.game_data.ganhos_EXP >= 10 && !global.game_data.p1:
		global.game_data.ganhos_EXP = 10
		mais_exp_upg.text = "Maximizado!"
		@warning_ignore("standalone_expression")
		mais_exp_upg.disabled #funcional
	elif global.game_data.ganhos_EXP >= 20 && global.game_data.p1:
		global.game_data.ganhos_EXP = 20
		mais_exp_upg.text = "Maximizado!"
		@warning_ignore("standalone_expression")
		mais_exp_upg.disabled #funcional

	if global.game_data.Assistente_AFK_gains >= 15 && !global.game_data.p1:
		global.game_data.Assistente_AFK_gains = 15
		assistente_upg.text = "Maximizado!"
		@warning_ignore("standalone_expression")
		assistente_upg.disabled; #funcional
	elif global.game_data.Assistente_AFK_gains >= 30 && global.game_data.p1:
		global.game_data.Assistente_AFK_gains = 30
		assistente_upg.text = "Maximizado!"
		@warning_ignore("standalone_expression")
		assistente_upg.disabled; #funcional

func check_status() -> void: #checa em qual prestigio o player está
	match global.game_data.nivel_de_prestigio:
		0:
			velocidade_upg.text = "Comprar Oculos"
			velocidade_label.text = "Deixa o Botão mais rápido"
			comprar_livro_upg.text = "Comprar Livro"
			comprar_livro_label.text = "Adiciona mais um Livro"
			mais_exp_upg.text = "Comprar Canetas Coloridas"
			mais_exp_label.text = "Ganha mais Experiencia\npor Botão"
			assistente_upg.text = "Comprar Assistente"
			assistente_label.text = "Gera Experiencia\nsem precisar\nclicar no botão"
		1:
			velocidade_upg.text = "Melhorar a digitação"
			velocidade_label.text = "para poder codar mais rápido!"
			comprar_livro_upg.text = "Contratar um DEV novo"
			comprar_livro_label.text = "Adiciona um Computador extra\npara ajudar"
			mais_exp_upg.text = "Estudar GDScript"
			mais_exp_label.text = "Ganha mais Experiencia por Codar!"
			assistente_upg.text = "Automatizar o Codigo!"
			assistente_label.text = "Reutilizar Código é útil!\n e permite lhe darexperiencia\nsem precionar o botão"
		2:
			velocidade_upg.text = "Aprender a plantar\nmais rápido!"
			velocidade_label.text = "Sim, até nisso dá pra melhorar"
			comprar_livro_upg.text = "Comprar uma área"
			comprar_livro_label.text = "Para poder plantar\nmais arvores"
			mais_exp_upg.text = "Plantar diferentes\ntipos de arvore"
			mais_exp_label.text = "Diferentes tipos dão mais dinheiro... \n por alguma razão"
			assistente_upg.text = "Fazer uma IA\nque planta sozinha!"
			assistente_label.text = "Pra quê plantar você mesmo? \n quando a IA faz por você?"
		3: 
			velocidade_upg.text = "Comprar Luvas"
			velocidade_label.text = "para não precisar lavar suas mãos\neconomizando tempo!"
			comprar_livro_upg.text = "Chamar voluntários"
			comprar_livro_label.text = "Mais uma pessoa para te ajudar!"
			mais_exp_upg.text = "Aprender técnicas de coleta"
			mais_exp_label.text = "Funciona muito bem! e permite coletar mais lixo!"
			assistente_upg.text = "Comprar Drones Automatizados"
			assistente_label.text = "Coletar lixo de lagos assim é\nsurpreendentemente funcional!"

func trocar_botoes() -> void:
	var imagem: Texture2D
	match global.game_data.nivel_de_prestigio:
		0: imagem = preload("res://Backgrounds/BotaoTintaAzul.png")  # estudo
		1: imagem = preload("res://Backgrounds/BotaoPasta.png")  # código
		2: imagem = preload("res://Backgrounds/BotaoFumaca.png")  # ODS 15
		3: imagem = preload("res://Backgrounds/BotaoLatinhaRefri.png")  # ODS 12
		_: imagem = preload("res://Backgrounds/BotaoTintaAzul.png")  # segurança
	for b: Button in [velocidade_upg, comprar_livro_upg, mais_exp_upg, assistente_upg]:
		b.icon = imagem
		b.expand_icon = true
		b.custom_minimum_size = Vector2(300, 80)
		b.size_flags_vertical = Control.SIZE_SHRINK_CENTER

	for b: Button in [prestige_button, leave_button]:
		b.icon = imagem
		b.expand_icon = true
		b.custom_minimum_size = Vector2(163, 40)

func _on_velocidade_upg_pressed() -> void: # Velocidade da Animação
	check_disabled()
	if global.game_data.velo_estudo >= 4.0 && !global.game_data.p1:
		velocidade_upg.tooltip_text = "Maximizado!"
	elif global.game_data.money >= global.game_data.velocidade_custo:
		global.game_data.money -= global.game_data.velocidade_custo
		Musica.play_SFX(Musica.upgrade)
		if global.game_data.p1:
			global.game_data.velo_estudo += 0.4
		else: global.game_data.velo_estudo += 0.2
		global.game_data.velocidade_custo += int(round(global.game_data.velocidade_custo * 0.5))
		global.save_data()
# p1 completo
# p2 completo
func _on_comprar_livro_upg_pressed() -> void: # Adicionar mais um botão (objeto classe botao_principal.gd)
	check_disabled() # Prestigio Feito no P1 pronto
	if global.game_data.p1 && global.game_data.qtd_livros >= 10:
		comprar_livro_upg.text = "Maximizado!"
	elif global.game_data.qtd_livros >= 5 && !global.game_data.p1:
		comprar_livro_upg.text = "Maximizado!"
	elif global.game_data.money >= global.game_data.livros_custo:
		Musica.play_SFX(Musica.upgrade)
		global.game_data.money -= global.game_data.livros_custo
		global.game_data.qtd_livros += 1 # if abaixo para caso a pessoa tenha o primeiro prestigio liberado, o preço aumenta de forma menor, deixando mais barato
		if global.game_data.p1: global.game_data.livros_custo += int(round(global.game_data.livros_custo * 0.4))
		else: global.game_data.livros_custo += int(round(global.game_data.livros_custo * 0.8))
		
		var novo_botao = BOTAO_PRINCIPAL.instantiate()
		grid_container.add_child(novo_botao)
		
		global.save_data()
# p1 completo
func _on_mais_exp_upg_pressed() -> void: # Ganho de Experiencia/Dinheiro
	check_disabled()
	if global.game_data.ganhos_EXP >= 20 && global.game_data.p1:
		mais_exp_upg.text = "Maximizado!"
	elif global.game_data.ganhos_EXP >= 10 && !global.game_data.p1:
		mais_exp_upg.text = "Maximizado!"
	elif global.game_data.money >= global.game_data.EXP_custo:
		Musica.play_SFX(Musica.upgrade)
		global.game_data.money -= global.game_data.EXP_custo
		if global.game_data.p1: global.game_data.ganhos_EXP += 2 # se tiver prestigio, terá um aumento maior por cada nivel
		else: global.game_data.ganhos_EXP += 1 # caso contrario, nivel normal
		global.game_data.EXP_custo += int(round(global.game_data.EXP_custo * 1.7))
		global.save_data()
# p1 completo
func _on_assistente_upg_pressed() -> void: # ganhos AFK
	check_disabled()
	if global.game_data.Assistente_AFK_gains >= 30 && global.game_data.p1:
		assistente_upg.text = "Maximizado!"
	elif global.game_data.Assistente_AFK_gains >= 15 && !global.game_data.p1:
		assistente_upg.text = "Maximizado!"
	elif global.game_data.money >= global.game_data.Assistente_custo:
		Musica.play_SFX(Musica.upgrade)
		global.game_data.money -= global.game_data.Assistente_custo
		if global.game_data.p1 && !global.game_data.p5: global.game_data.Assistente_AFK_gains += 2 # se tiver prestigio 1, ganha o dobro de ganhos afk por nivel
		elif global.game_data.p5: global.game_data.Assistente_AFK_gains *= 1.5
		else: global.game_data.Assistente_AFK_gains += 1
		global.game_data.Assistente_custo += int(round(global.game_data.Assistente_custo * 1.5))
		global.save_data()
# p1 completo
func _on_timer_timeout() -> void:
	global.game_data.money += global.game_data.Assistente_AFK_gains

func _on_prestige_button_pressed() -> void:
	global.save_data()
	Musica.play_SFX(Musica.menu_up)
	get_tree().change_scene_to_file("res://control_prestige.tscn")

func _on_leave_button_pressed() -> void:
	global.save_data()
	get_tree().change_scene_to_file("res://menu.tscn")

func trocar_background(nome: String) -> void:
	global.trocarBackground()
	var path_completo = "res://Backgrounds/" + global.game_data.bg + ".jpeg"
	if ResourceLoader.exists(path_completo):
		var nova_textura = load(path_completo)
		texture_rect.texture = nova_textura
	else:
		global.game_data.bg = "PapelBg"

# Sons de Hover do Mouse

func _on_velocidade_upg_mouse_entered() -> void:
	Musica.play_SFX(Musica.hover)

func _on_comprar_livro_upg_mouse_entered() -> void:
	Musica.play_SFX(Musica.hover)

func _on_mais_exp_upg_mouse_entered() -> void:
	Musica.play_SFX(Musica.hover)

func _on_assistente_upg_mouse_entered() -> void:
	Musica.play_SFX(Musica.hover)

func _on_leave_button_mouse_entered() -> void:
	Musica.play_SFX(Musica.hover)

func _on_prestige_button_mouse_entered() -> void:
	Musica.play_SFX(Musica.hover)
