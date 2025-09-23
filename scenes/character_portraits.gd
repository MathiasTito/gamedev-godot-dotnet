extends HBoxContainer

@onready var left_portrait = $LeftPortraits
@onready var right_portrait = $RightPortraits

func _ready():
	left_portrait.play()
	right_portrait.play()
