class_name Feedback_Grid
extends Control

@export var peg_scene: PackedScene

@onready var background = $TextureRect
@onready var grid = $GridContainer
var row := 0

func _ready():
	background.size.x = grid.columns * 48

func show_results(black, white):
	for i in range(black):
		var peg = peg_scene.instantiate()
		peg.set_color(0)
		grid.add_child(peg)
	for i in range(white):
		var peg = peg_scene.instantiate()
		peg.set_color(1)
		grid.add_child(peg)
	