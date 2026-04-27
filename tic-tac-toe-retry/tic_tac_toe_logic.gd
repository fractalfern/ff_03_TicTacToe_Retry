extends Node

var grid: Array

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
	empty_grid()
