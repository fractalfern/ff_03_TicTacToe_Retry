extends Panel

@export var circle_marker: PackedScene
@export var cross_marker: PackedScene

var marker_position: Vector2i
var marker: Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var cell_size: int = size.x
	
	@warning_ignore("integer_division")
	marker_position = Vector2i(cell_size/2,cell_size/2)
	
	print("Panel cell Size: ", cell_size)

func place_marker(player: int) -> void:
	if marker:
		marker.queue_free()
		
	if player == Constants.PLAYER_CIRCLE:
		marker = circle_marker.instantiate()
	else: #player == Constants.PLAYER_CROSS:
		marker = cross_marker.instantiate()
	
	assert(marker != null)
	@warning_ignore("integer_division")
	marker.position = marker_position
	print("Marker Position: ", marker.position)
	add_child(marker)
