extends Control

@onready var stream_player: AudioStreamPlayer = $AudioStreamPlayer
const MUSICA_FUNDO_INCREMENTALIS = preload("uid://cjhecowf0704y")
var is_playing: bool

func play_music(music_resource: AudioStream):
	if music_resource:
		stream_player.stream = music_resource
		stream_player.play()

func stop_music():
	stream_player.stop()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
