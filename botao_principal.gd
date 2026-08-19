extends VBoxContainer

@export var anim_clique: String = "paper_click"
@export var texto_ao_clicar: String = "estudando..."
@export var texto_apos_animacao: String = "Aprender"
@export var texto_reset: String = "Estudar"

var estado_botao_principal = 0 # 0 = inativo, 1 = em coleta

@onready var button = $Button 
@onready var anim_paper: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	check_animation()

func _on_button_pressed() -> void:
	processar_clique(anim_clique, texto_ao_clicar, texto_reset)

func processar_clique(nome_animacao: String, texto_carregando: String, texto_padrao: String) -> void:
	if anim_paper:
		anim_paper.speed_scale = global.game_data.velo_estudo
	
	if estado_botao_principal == 0:
		if anim_paper: 
			anim_paper.play(nome_animacao)
			
		Musica.play_SFX(Musica.botao_principal_sfx)
		button.text = texto_carregando
		button.disabled = true
		
	elif estado_botao_principal == 1:
		Musica.play_SFX(Musica.botao_principal_sfx)
		global.game_data.money += global.game_data.ganhos_EXP
		
		button.text = texto_padrao
		estado_botao_principal = 0
		
		if anim_paper: 
			anim_paper.play("RESET")
			
		global.save_data()

@warning_ignore("unused_parameter")
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if button.disabled == true:
		button.text = texto_apos_animacao
		estado_botao_principal = 1
	else: 
		button.text = texto_reset
		estado_botao_principal = 0
	button.disabled = false

func check_animation() -> void:
	if (global.game_data.nivel_de_prestigio == 1):
		texto_reset = "Escrever Código"
		texto_ao_clicar = "Codando..."
		texto_apos_animacao = "Enviar para o Github"
		anim_clique = "codar_anim"
	elif (global.game_data.nivel_de_prestigio == 2):
		texto_reset = "Plantar Árvore"
		texto_ao_clicar = "Plantando..."
		texto_apos_animacao = "Coletar Sementes"
		anim_clique = "plantar_anim"
	elif (global.game_data.nivel_de_prestigio == 3):
		texto_reset = "Remover Lixo"
		texto_ao_clicar = "Retirando Entulho..."
		texto_apos_animacao = "Reciclar o Lixo"
		anim_clique = "lixo_anim"
	else:
		anim_clique = "paper_click"
		texto_ao_clicar = "estudando..."
		texto_apos_animacao = "Aprender"
		texto_reset = "Estudar"
