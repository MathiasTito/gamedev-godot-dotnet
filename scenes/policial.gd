extends Node2D

enum Direcao { DIREITA, ESQUERDA, CIMA, BAIXO }

@export var direcao: Direcao = Direcao.ESQUERDA
@export var distancia_patrulha: int = 200
@export var velocidade: float = 100.0
@export var tempo_espera: float = 1.0

var pos_inicial: Vector2
var pos_final: Vector2
var indo_para_final := true
var esperando := false


func _ready():
	pos_inicial = global_position
	pos_final = calcular_posicao_final()


func calcular_posicao_final() -> Vector2:
	match direcao:
		Direcao.DIREITA:
			return pos_inicial + Vector2(distancia_patrulha, 0)
		Direcao.ESQUERDA:
			return pos_inicial - Vector2(distancia_patrulha, 0)
		Direcao.CIMA:
			return pos_inicial - Vector2(0, distancia_patrulha)
		Direcao.BAIXO:
			return pos_inicial + Vector2(0, distancia_patrulha)
	return pos_inicial


func _physics_process(delta):
	if esperando:
		return

	var alvo = pos_final if indo_para_final else pos_inicial
	global_position = global_position.move_toward(alvo, velocidade * delta)

	if global_position.distance_to(alvo) < 1.0:
		inverter_caminho()


func inverter_caminho():
	esperando = true
	await get_tree().create_timer(tempo_espera).timeout

	indo_para_final = !indo_para_final

	rotation += deg_to_rad(180)

	esperando = false


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("activate_doors"):
		await get_tree().create_timer(0.3).timeout
		get_tree().reload_current_scene()
