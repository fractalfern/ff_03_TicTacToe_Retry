extends Sprite2D

@export var circle_marker: PackedScene
@export var cross_marker: PackedScene

const NUM_CELLS: int = 3

var board_size: int
var cell_size: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	board_size = texture.get_width()
	print("Board Size: ", board_size)
	
	@warning_ignore("integer_division")
	cell_size = board_size/NUM_CELLS
	print("Cell Size: ", cell_size)

func is_on_board(input_position: Vector2) -> bool:
	print("Input Position: ", input_position)
	if input_position.x < board_size && \
	   input_position.y < board_size:
		return true
		
	return false

func get_cell(input_position: Vector2) -> Vector2i:
	print("Input Position: ", input_position)
	
	var cell: Vector2i = Vector2i(input_position/cell_size)
	print("Cell: ", cell)
	
	return cell

func place_marker(player: int, cell: Vector2i) -> void:
	var marker: Node
	
	if player == Constants.PLAYER_CIRLCLE:
		marker = circle_marker.instantiate()
	else: #player == Constants.PLAYER_CROSS:
		marker = cross_marker.instantiate()
	
	assert(marker != null)
	@warning_ignore("integer_division")
	marker.position = cell * cell_size + Vector2i(cell_size/2,cell_size/2)
	print("Marker Position: ", marker.position)
	add_child(marker)
