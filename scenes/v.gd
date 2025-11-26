extends Node

@onready var music_player_V = $V
@onready var music_player_rain = $Rain

var volume_final_V = -25.0
var volume_final_rain = -60.0
var tempo_espera_V = 2.0   
var tempo_espera_rain = 0.2  
var duracao_fade = 4.0   

func _ready():
	music_player_V.volume_db = -80.0
	music_player_rain.volume_db = -80.0
	
	music_player_V.play()
	music_player_rain.play()
	
	start_fade_in()

func start_fade_in():
	var tween_V = create_tween()
	var tween_rain = create_tween()
	
	tween_V.set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)
	tween_rain.set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)
	
	tween_V.tween_interval(tempo_espera_V)
	tween_rain.tween_interval(tempo_espera_rain)
	
	tween_V.tween_property(music_player_V, "volume_db", volume_final_V, duracao_fade)
	tween_rain.tween_property(music_player_rain, "volume_db", volume_final_rain, duracao_fade)
