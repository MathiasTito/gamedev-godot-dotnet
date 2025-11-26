extends CharacterBody2D

# Configurações editáveis no Inspector
@export var distancia_patrulha: int = 500  # Quantos pixels ele anda para esquerda
@export var velocidade: float = 100.0
@export var tempo_espera: float = 1.0 # Tempo parado antes de voltar

# Variáveis internas
var posicao_inicial: Vector2
var posicao_final: Vector2
var indo_para_final: bool = true
var esta_esperando: bool = false

func _ready():
	# Salva onde o policial começou
	posicao_inicial = global_position
	# Calcula onde ele deve chegar (Para esquerda = subtrair X)
	posicao_final = posicao_inicial - Vector2(distancia_patrulha, 0)

func _physics_process(delta):
	# Se estiver no tempo de espera, não faz nada
	if esta_esperando:
		return

	# Define qual é o alvo atual (Ida ou Volta?)
	var alvo = posicao_final if indo_para_final else posicao_inicial
	
	# Move o policial em direção ao alvo
	global_position = global_position.move_toward(alvo, velocidade * delta)

	# Verifica se chegou no destino (distância menor que 1 pixel)
	if global_position.distance_to(alvo) < 1.0:
		iniciar_retorno()

func iniciar_retorno():
	esta_esperando = true
	# Espera um tempinho parado (opcional, fica mais natural)
	await get_tree().create_timer(tempo_espera).timeout
	
	# Inverte o objetivo
	indo_para_final = !indo_para_final
	virar_personagem()
	esta_esperando = false

func virar_personagem():
	# Multiplicar a escala X por -1 espelha o personagem
	# Isso vira o sprite E A LANTERNA/COLLISION junto!
	var direcao = -1 if indo_para_final else 1
	
	# Se o sprite original olha para a direita, use scale.x = direcao
	# Se o sprite original olha para a esquerda, inverta a lógica
	scale.x = -1 if indo_para_final else 1
	
	# OBS: Se seu sprite ficar de cabeça para baixo, me avise, 
	# pois teremos que virar apenas o Sprite e a Lanterna, não o nó todo.

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		await get_tree().create_timer(0.3).timeout
		get_tree().reload_current_scene()
