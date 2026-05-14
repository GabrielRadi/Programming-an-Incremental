extends Control

@onready var prestige_qtd_label: Label = $prestige_qtd_label

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	prestige_qtd_label.text = "CERTIFICADOS: " + global.format(global.game_data.moedas_prestigio)


func _on_prestige_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://control.tscn")

func _on_prestigio_button_pressed() -> void:
	if (global.game_data.moedas_prestigio > 0):
		global.prestigio()
