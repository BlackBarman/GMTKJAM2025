extends RigidBody2D

@export var max_speed := 200.0

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	# Cap speed manually
	if state.linear_velocity.length() > max_speed:
		state.linear_velocity = state.linear_velocity.normalized() * max_speed
