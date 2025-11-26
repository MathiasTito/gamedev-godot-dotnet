extends Node2D

@onready var title = $V
@onready var body = $Label

var speed := 80.0

var start_y := 0.0
var spacing := 40.0 

func _ready():
	var screen_height = get_viewport_rect().size.y

	start_y = screen_height + 50
	title.position.y = start_y

	body.position.y = title.position.y + title.size.y + spacing

func _process(delta):
	title.position.y -= speed * delta
	body.position.y -= speed * delta
