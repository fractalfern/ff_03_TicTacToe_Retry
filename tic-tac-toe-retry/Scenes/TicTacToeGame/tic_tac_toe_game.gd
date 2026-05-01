extends Node2D

@onready var game_logic: Node = $TicTacToeLogic
@onready var grid_sprite: Sprite2D = $GridSprite
@onready var game_over_screen: CanvasLayer = $GameOverScreen

var current_player: int
var is_user_turn: bool
var num_turns: int

func new_game() -> void:	
	print("Opponent: ", game_logic.opponent)
	get_tree().paused = false
	
	game_logic.empty_grid()
	game_logic.print_grid()
	
	current_player = Constants.PLAYER_CIRCLE
	is_user_turn = true
	num_turns = 0
	
	get_tree().call_group("cross_markers", "queue_free")
	get_tree().call_group("circle_markers", "queue_free")
	
	game_over_screen.hide()

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
	   grid_sprite.is_on_board(event.position):
		return true
		
	return false

func swap_current_player() -> void:
	if current_player == Constants.PLAYER_CIRCLE:
		current_player = Constants.PLAYER_CROSS
	else:
		current_player = Constants.PLAYER_CIRCLE

func process_turn(cell: Vector2i) -> void:
	#Update the data for that cell
	game_logic.grid[cell.y][cell.x] = current_player
	print("Grid after turn:")
	game_logic.print_grid()
	
	#Put a graphic in that cell
	grid_sprite.place_marker(current_player, cell)
	
	num_turns += 1
	swap_current_player()

func process_user_turn(cell: Vector2i) -> void:
	# We've determined to play the user's turn. Immediately flip user_turn
	# to false while processing
	is_user_turn = false

	process_turn(cell)

func process_computer_turn() -> void:
	var cell: Vector2i = game_logic.get_computer_move()
	process_turn(cell)

func handle_game_over(winner: int) -> void:
	if winner == Constants.PLAYER_CIRCLE:
		game_over_screen.gameOverLabel.text = "Circle Wins!"
	elif winner == Constants.PLAYER_CROSS:
		game_over_screen.gameOverLabel.text = "Cross Wins!"
	else:
		game_over_screen.gameOverLabel.text = "It's a tie!"
	
	get_tree().paused = true
	game_over_screen.show()

func _input(event: InputEvent) -> void:
	#print("Position: ", event.position)
	
	#if valid input (for a variety of reasons)
	if is_valid_user_click(event):
		var cell: Vector2i = grid_sprite.get_cell(event.position)
		
		if game_logic.is_cell_empty(cell):		
			process_user_turn(cell)
		
			# Check for winner after human turn
			var winner: int = game_logic.get_winner()
			
			if winner == 0 && num_turns != 9: 
				if game_logic.opponent != game_logic.HUMAN:
					process_computer_turn()
					
					# Check for winner after computer turn
					winner = game_logic.get_winner()
			
			if winner != 0 || num_turns == 9:
				handle_game_over(winner)
			
			is_user_turn = true

func _on_game_over_screen_restart() -> void:
	new_game()

func _on_opponent_selector_opponent_select(button: BaseButton) -> void:
	print("Button Pressed: " + button.name)
	
	#TODO this is horrible if I rename them, but not sure what else to do
	if button.name == "OpponentHuman":
		game_logic.opponent = game_logic.HUMAN
	elif button.name == "OpponentCompFirst":
		game_logic.opponent = game_logic.COMPUTER_FIRST_CELL
	elif button.name == "OpponentCompRandom":
		game_logic.opponent = game_logic.COMPUTER_RANDOM
	elif button.name == "OpponentCompSmart":
		game_logic.opponent = game_logic.COMPUTER_HARD
	else:
		assert(false)
	
	new_game()
