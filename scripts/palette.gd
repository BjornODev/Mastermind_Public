extends HBoxContainer


@export var peg_scene: PackedScene
var color_count := 6

func _ready():
	for i in color_count:
		var peg = peg_scene.instantiate()
		add_child(peg)
		peg.set_color(i)
	var spacer = Control.new()
	spacer.custom_minimum_size.x = 48  # half slot width
	add_child(spacer)