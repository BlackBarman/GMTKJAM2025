extends RigidBody2D
class_name Block

@export var max_speed := 200.0

enum Shape {
	X, 
	TRIANGLE,
	CIRCLE,
	SQUARE,
}



func _ready() -> void:
	pass

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	# Cap speed manually
	if state.linear_velocity.length() > max_speed:
		state.linear_velocity = state.linear_velocity.normalized() * max_speed
