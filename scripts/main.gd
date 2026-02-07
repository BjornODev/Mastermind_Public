extends Node2D


var secret_code = []
var color_count = 6
var code_length = 4

func generate_code():
    secret_code.clear()
    for i in code_length:
        secret_code.append(randi() % color_count)
