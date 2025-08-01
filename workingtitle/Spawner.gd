extends Node2D

@export var block_scene: PackedScene

func spawn_block(shape: Block.Shape, Pos: Vector2) -> Block:
	var block = block_scene.instantiate() as Block
	block.global_position = Pos
	block._set_shape(shape)
	add_child(block)
	return block
