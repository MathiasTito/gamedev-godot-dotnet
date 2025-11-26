extends Control

@onready var dialogue_box = $DialogueBox
@onready var character_name = $DialogueBox/NameLabel
@onready var dialogue_text = $DialogueBox/TextLabel
@onready var continue_button = $DialogueBox/ContinueButton
@onready var gray_filter = $GrayFilter
@onready var left_portrait = $CharacterPortraits/LeftPortraits
@onready var right_portrait = $CharacterPortraits/RightPortraits

var dialogue_data: Array = []
var current_dialogue_index: int = 0
var is_dialogue_active: bool = false
var text_speed: float = 0.03
var is_typing: bool = false

var dialogue_step: int = 0  # controla se estamos no 1° ou 2° diálogo

signal dialogue_finished


func _ready():
	dialogue_box.visible = false
	gray_filter.visible = true
	right_portrait.visible = false  # right portrait começa escondido

	# left portrait começa parado no frame 0
	if left_portrait is AnimatedSprite2D:
		left_portrait.stop()
		left_portrait.frame = 0

	continue_button.pressed.connect(_on_continue_pressed)

	dialogue_finished.connect(_on_dialogue_finished)

	await get_tree().create_timer(0.5).timeout
	start_first_dialogue()


# ============================================================
# PRIMEIRO DIÁLOGO (sem right portrait)
# ============================================================

func start_first_dialogue():
	dialogue_step = 1

	var auto_dialogue = [
		{"character": "Guarda", "text": "Você finalmente vai sair depois de 5 anos."},
		{"character": "Guarda", "text": "Mas não vai durar por muito tempo, a gente sabe o que você fez."},
		{"character": "Guarda", "text": "E gente que nem você nunca terá nada."},
		{"character": "V", "text": "Eu não me importo com essa sua falação."},
		{"character": "V", "text": "Se eu tivesse outra oportunidade, faria tudo igual."},
		{"character": "Guarda", "text": "Vamos ver quanto tempo dura essa sua marra."}
	]

	start_dialogue(auto_dialogue)


# ============================================================
# SEGUNDO DIÁLOGO (right portrait aparece antes dele)
# ============================================================

func start_second_dialogue():
	dialogue_step = 2

	right_portrait.visible = true  # agora aparece

	var pensamento = [
		{"character": "V", "text": "Vou naquela delegacia caçar informações."},
		{"character": "V", "text": "Vou me vingar dele."}
	]

	start_dialogue(pensamento)


# ============================================================
# FINALIZAÇÃO DE CADA DIÁLOGO
# ============================================================

func _on_dialogue_finished():

	if dialogue_step == 1:
		# terminou o primeiro → inicia o segundo
		start_second_dialogue()
		return

	if dialogue_step == 2:
		# terminou o segundo → começa animação do personagem
		_finalize_and_start_character_animation()
		return


# ============================================================
# ANIMAÇÃO FINAL DO PERSONAGEM
# ============================================================

func _finalize_and_start_character_animation():
	dialogue_box.visible = false
	gray_filter.visible = false
	is_dialogue_active = false

	# toca animação final no personagem
	if left_portrait is AnimatedSprite2D:
		left_portrait.play("andar")  # troque pelo nome correto da animação

		# quando a animação terminar → muda de cena
		left_portrait.animation_finished.connect(_on_character_animation_finished)


func _on_character_animation_finished():
	get_tree().change_scene_to_file("res://credits.tscn")


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
