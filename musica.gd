extends Control

@onready var stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var sfx_stream_player: AudioStreamPlayer = $SfxStreamPlayer

const MUSICA_FUNDO_INCREMENTALIS = preload("uid://cjhecowf0704y")
const click = preload("uid://qm15f0mysr3s")
const load_complete = preload("uid://bdt2vihofqv8v")
const menu_up = preload("uid://bbmbu6prs8ltd")
const hover = preload("uid://qm15f0mysr3s") # mesmo som do click
const buy = preload("uid://dvipe3el26c7x")
const reset = preload("uid://cln86aiujnqmm")
const upgrade = preload("uid://yphk7tpg8sc0")
const prestige = preload("uid://bsetcvos1b2c4")
const START = preload("uid://bmkft80ppbcc7")
const botao_principal_sfx = preload("uid://bgqvhnec25315")

var is_playing: bool

func play_music(music_resource: AudioStream):
	if music_resource:
		stream_player.stream = music_resource
		stream_player.play()

func stop_music():
	stream_player.stop()

func play_SFX(sound_effect: AudioStream):
	if sound_effect == null:
		return
	var new_player = AudioStreamPlayer.new()
	new_player.stream = sound_effect
	new_player.bus = "SFX" 
	add_child(new_player)
	new_player.play()
	new_player.finished.connect(func(): new_player.queue_free());
