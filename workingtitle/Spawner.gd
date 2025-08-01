extends Node2D

@export var block_scene: PackedScene

func _ready() -> void:
	randomize()
	%Timer.start()

func randomize_shape() -> Block.Shape:
	return randi_range(0, 3)

func spawn_block(shape: Block.Shape, pos: Vector2) -> Block:
	var block = block_scene.instantiate() as Block
	add_child(block)  # Add to tree first
	block.global_position = global_position  # Use global_position after it's added
	block._set_shape(shape)
	return block

func _on_timer_timeout() -> void:
	spawn_block(randomize_shape(), global_position)
