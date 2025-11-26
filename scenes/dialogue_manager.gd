extends Control

@onready var dialogue_box = $DialogueBox
@onready var character_name = $DialogueBox/NameLabel
@onready var dialogue_text = $DialogueBox/TextLabel
@onready var continue_button = $DialogueBox/ContinueButton
@onready var gray_filter = $GrayFilter
@onready var left_portrait = $CharacterPortraits/LeftPortraits
@onready var right_portrait = $CharacterPortraits/RightPortraits
@onready var animated_rain = $AnimatedSprite2D

var dialogue_data: Array = []
var current_dialogue_index: int = 0
var is_dialogue_active: bool = false
var text_speed: float = 0.03
var is_typing: bool = false

var dialogue_step: int = 0  # 1 = primeiro diálogo, 2 = segundo diálogo

signal dialogue_finished


func _ready():
	dialogue_box.visible = false
	gray_filter.visible = true
	continue_button.pressed.connect(_on_continue_pressed)
	
	animated_rain.play()

	# Deixa só o frame 0 do left_portrait, sem animar
	if left_portrait.has_method("stop"):
		left_portrait.stop()
		left_portrait.frame = 0

	# O retrato da direita só vai aparecer no segundo diálogo
	right_portrait.visible = false

	dialogue_finished.connect(_on_dialogue_finished)

	await get_tree().create_timer(0.5).timeout
	start_first_dialogue()


# ============================================================
# PRIMEIRO DIÁLOGO (SEM portrait da direita)
# ============================================================

func start_first_dialogue():
	dialogue_step = 1

	var auto_dialogue = [
		{"character": "Narrador", "text": "V saiu da prisão depois de 5 anos."},
		{"character": "Narrador", "text": "O mundo lá fora parecia diferente..."},
		{"character": "Narrador", "text": "E agora ele sabia exatamente onde precisava ir e o que precisava fazer."}
	]

	start_dialogue(auto_dialogue)


# ============================================================
# SEGUNDO DIÁLOGO (AGORA portrait da direita aparece)
# ============================================================

func start_second_dialogue():
	dialogue_step = 2

	right_portrait.visible = true

	var pensamento = [
		{"character": "Guarda", "text": "Ficou com saudades de ver o sol nascer quadrado?"},
		{"character": "V", "text": "Dessa vez eu vim fazer o que deveria ter feito a muito tempo."},
		{"character": "Guarda", "text": "Isso é sobre seu pai ou sua irmã?"},
		{"character": "Guarda", "text": "Gente que nem eles não merecem fim melhor."},
		{"character": "Guarda", "text": "Você é covarde igual a eles."},
		{"character": "V", "text": "Me chamo V."},
		{"character": "V", "text": "V de Vingança."},
		{"character": "V", "text": "V de Vilão."},
	]

	start_dialogue(pensamento)


# ============================================================
# AÇÕES APÓS DIÁLOGOS
# ============================================================

func _on_dialogue_finished():

	if dialogue_step == 1:
		# Terminou primeiro diálogo → inicia o segundo
		start_second_dialogue()
		return

	if dialogue_step == 2:
		# Terminou o segundo diálogo → esconde caixa e anima personagem
		_finalize_and_start_character_animation()
		return


func _finalize_and_start_character_animation():
	# Remove caixa de diálogo
	dialogue_box.visible = false
	gray_filter.visible = false
	is_dialogue_active = false

	# Inicia animação do personagem
	if left_portrait.has_method("play"):
		left_portrait.play("atirando")
		
	await get_tree().create_timer(3).timeout
		
	get_tree().change_scene_to_file("res://scenes/credits.tscn")


# ============================================================
# SISTEMA DE DIÁLOGO
# ============================================================

func start_dialogue(dialogue_array: Array) -> void:
	dialogue_data = dialogue_array
	current_dialogue_index = 0
	is_dialogue_active = true

	gray_filter.visible = true
	dialogue_box.visible = true

	show_current_dialogue()


func show_current_dialogue():
	if current_dialogue_index >= dialogue_data.size():
		end_dialogue()
		return

	var current_data = dialogue_data[current_dialogue_index]
	character_name.text = current_data.get("character", "")
	start_typing_animation(current_data.get("text", ""))


func start_typing_animation(text: String) -> void:
	is_typing = true
	dialogue_text.text = ""
	continue_button.visible = false

	for i in text.length():
		dialogue_text.text += text[i]
		await get_tree().create_timer(text_speed).timeout

		if Input.is_action_just_pressed("ui_accept"):
			dialogue_text.text = text
			break

	is_typing = false
	continue_button.visible = true


func _on_continue_pressed():
	if is_typing:
		return

	current_dialogue_index += 1
	show_current_dialogue()


func end_dialogue():
	is_dialogue_active = false
	dialogue_box.visible = false
	gray_filter.visible = false

	dialogue_finished.emit()


func _unhandled_input(event):
	if not is_dialogue_active or is_typing:
		return

	if event.is_action_pressed("ui_accept") or event.is_action_pressed("ui_select"):
		_on_continue_pressed()
