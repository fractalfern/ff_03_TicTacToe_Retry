extends Node2D

@onready var ticTacToe_Logic: Node = $TicTacToe_Logic
@onready var ticTacToe_Board_Graphic: Sprite2D = $TicTacToe_Board_Graphic
@onready var gameOverScreen: CanvasLayer = $GameOverScreen

var current_player: int
var is_user_turn: bool
var has_computer_opponent: bool
var num_turns: int

func new_game() -> void:	
	get_tree().paused = false
	
	ticTacToe_Logic.empty_grid()
	ticTacToe_Logic.print_grid()
	
	current_player = Constants.PLAYER_CIRCLE
	is_user_turn = true
	has_computer_opponent = false
	num_turns = 0
	
	get_tree().call_group("cross_markers", "queue_free")
	get_tree().call_group("circle_markers", "queue_free")
	
	gameOverScreen.hide()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	new_game()

func is_left_mouse_click(event: InputEvent) -> bool:
	if event is InputEventMouseButton && event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			return true
			
	return false

func is_valid_user_click(event: InputEvent) -> bool:
	if is_user_turn && \
	   is_left_mouse_click(event) && \
	   ticTacToe_Board_Graphic.is_on_board(event.position):
		return true
		
	return false

func swap_current_player() -> void:
	if current_player == Constants.PLAYER_CIRCLE:
		current_player = Constants.PLAYER_CROSS
	else:
		current_player = Constants.PLAYER_CIRCLE

func process_turn(cell: Vector2i) -> void:
	#Update the data for that cell
	ticTacToe_Logic.grid[cell.y][cell.x] = current_player
	print("Grid after turn:")
	ticTacToe_Logic.print_grid()
	
	#Put a graphic in that cell
	ticTacToe_Board_Graphic.place_marker(current_player, cell)
	
	num_turns += 1
	swap_current_player()

func process_user_turn(cell: Vector2i) -> void:
	# We've determined to play the user's turn. Immediately flip user_turn
	# to false while processing
	is_user_turn = false

	process_turn(cell)

func process_computer_turn() -> void:
	var cell: Vector2i = ticTacToe_Logic.get_computer_move()
	process_turn(cell)

func handle_game_over(winner: int) -> void:
	if winner == Constants.PLAYER_CIRCLE:
		gameOverScreen.gameOverLabel.text = "Circle Wins!"
	elif winner == Constants.PLAYER_CROSS:
		gameOverScreen.gameOverLabel.text = "Cross Wins!"
	else:
		gameOverScreen.gameOverLabel.text = "It's a tie!"
	
	get_tree().paused = true
	gameOverScreen.show()

func _input(event: InputEvent) -> void:
	#print("Position: ", event.position)
	
	#if valid input (for a variety of reasons)
	if is_valid_user_click(event):
		var cell: Vector2i = ticTacToe_Board_Graphic.get_cell(event.position)
		
		if ticTacToe_Logic.is_cell_empty(cell):		
			process_user_turn(cell)
		
			var winner: int = ticTacToe_Logic.get_winner()
			
			if winner == 0 && num_turns != 9: 
				if has_computer_opponent:
					process_computer_turn()
			
			if winner != 0 || num_turns == 9:
				handle_game_over(winner)
			
			is_user_turn = true

func _on_game_over_screen_restart() -> void:
	new_game()
