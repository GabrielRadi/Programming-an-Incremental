extends VBoxContainer

@onready var anim_paper: AnimationPlayer = $AnimationPlayer
@onready var button: Button = $Button

var estado_botao_principal = 0 # 0 = inativo, 1 = em coleta

func _on_button_pressed() -> void:
	if anim_paper:
		anim_paper.speed_scale = global.game_data.velo_estudo
	if estado_botao_principal == 0:
		if anim_paper: anim_paper.play("paper_click")
		button.text = "estudando..." 
		button.disabled = true
	elif estado_botao_principal == 1:
		global.game_data.money += global.game_data.ganhos_EXP
		button.text = "Estudar"
		estado_botao_principal = 0
		if anim_paper: anim_paper.play("RESET")
		global.save_data()

@warning_ignore("unused_parameter")
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if button.disabled == true:
		button.text = "Aprender"
		estado_botao_principal = 1
	else: 
		button.text = "Estudar"
		estado_botao_principal = 0
	button.disabled = false
