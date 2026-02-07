extends GridContainer

@export var rows := 9
@export var v_columns := 4
@export var slot_scene: PackedScene

var active_row := 0
var secret_code = []
var color_count := 6
var code_length := v_columns

func _ready():
	randomize()
	generate_code()
	build_board()

func generate_code():
	secret_code.clear()
	
	for i in range(code_length):
		secret_code.append(randi() % color_count)
		
	print("Secret: ", secret_code)

func build_board():
	columns = v_columns

	for r in rows:
		for c in columns:
			var slot = slot_scene.instantiate()
			slot.row = rows - 1 - r
			slot.column = columns - 1 - c
			add_child(slot)


func _on_pressed() -> void:
	submit_guess()
	
func submit_guess():
	var guess = []
	
	for slot in self.get_children():
		if slot.row == active_row:
			if slot.color_id == -1:
				print("Invalid Guess")
				return

			guess.append(slot.color_id)
	
	print("Guess:", guess)
	
	active_row += 1

func evaluate_guess(guess):
	var black := 0
	var white := 0
	
	var secret_copy = secret_code.duplicate()
	var guess_copy = guess.duplicate()
	
	for i in range(code_length):
		if guess_copy[i] == secret_copy[i]:
			black += 1
			guess_copy[i] = -1
	
	for i in range(code_length):
		pass