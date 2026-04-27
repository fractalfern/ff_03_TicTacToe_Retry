extends Node

const EMPTY_CELL: int = 0

var grid: Array

enum {COMPUTER_FIRST_CELL, COMPUTER_RANDOM, COMPUTER_HARD}
var difficulty: int

func empty_grid() -> void:
	grid = [[0, 0, 0],
			[0, 0, 0],
			[0, 0, 0]]

func print_grid() -> void:
	var p: String = "[\n"
	
	for row in grid.size():
		p += " ["
		
		var row_size: int = grid[row].size()
		for col in row_size:
			p+= str(grid[row][col])
			if col != (row_size-1):
				p+= ","
				
		p += "],\n"
			
	p += "]"
	print(p)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	difficulty = COMPUTER_FIRST_CELL
	empty_grid()

func get_first_available_cell() -> Vector2i:
	#TODO
	assert(false)
	var cell: Vector2i
	return cell

func get_random_available_cell() -> Vector2i:
	#TODO
	assert(false)
	var cell: Vector2i
	return cell

func get_best_avaialable_cell() -> Vector2i:
	#TODO
	assert(false)
	var cell: Vector2i
	return cell

func get_computer_move() -> Vector2i:
	var row: int
	var col: int
	
	var cell: Vector2i
	
	if difficulty == COMPUTER_FIRST_CELL:
		cell = get_first_available_cell()
	elif difficulty == COMPUTER_RANDOM:
		cell = get_random_available_cell()
	else: #difficulty == COMPUTER_HARD
		cell = get_best_avaialable_cell()
	
	assert(cell != null)
	return Vector2i(col, row)

func is_cell_empty(cell: Vector2i) -> bool:
	if grid[cell.y][cell.x] == EMPTY_CELL:
		return true
		
	return false
	
func get_winner() -> int:
	#TODO
	assert(false)
	return 0
