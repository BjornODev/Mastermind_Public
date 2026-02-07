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
		
#	print("Secret: ", secret_code)

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
	if evaluate_guess(guess):
		print(secret_code)
	
	active_row += 1
	if active_row >= rows:
		print(secret_code)

func evaluate_guess(guess):
	var black := 0
	var white := 0
	
	var secret_copy = secret_code.duplicate()
	var guess_copy = guess.duplicate()
	
	for i in range(code_length):
		if guess_copy[i] == secret_copy[i]:
			black += 1
			guess_copy[i] = -1
			secret_copy[i] = -1
	
	for g in guess_copy:
		for s in secret_copy:
			if g != -1 and g == s:
				white += 1
				var secret_index = secret_copy.find(g)
				secret_copy[secret_index] = -1
	
	if black == code_length:
		return true
	
	print("Black: {} White: {}".format([black,white], "{}"))