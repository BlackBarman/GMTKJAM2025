extends RigidBody2D
class_name Block

@export var max_speed := 200.0

enum Shape {
	X, 
	TRIANGLE,
	CIRCLE,
	SQUARE,
}

var  textures: Array[Texture2D] = [
	preload("res://Assets/x.png"),
	preload("res://Assets/triangle.png"),
	preload("res://Assets/circle.png"),
	preload("res://Assets/sqaure.png"),
	]




func _set_shape(new_shape: Shape) -> void:
	var shape = new_shape
	%X.texture = textures[int(shape)]

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	# Cap speed manually
	if state.linear_velocity.length() > max_speed:
		state.linear_velocity = state.linear_velocity.normalized() * max_speed
