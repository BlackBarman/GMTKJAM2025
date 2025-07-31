# ConveyorBelt.gd
extends Area2D

enum Direction {
	RIGHT,
	LEFT,
	UP,
	DOWN
}

@export var direction: Direction:
	set(value):
		direction = value
		conveyor_force = get_direction_vector() 
		
@export var belt_speed = 20

var conveyor_force: Vector2 
var bodies_in_area: Array[RigidBody2D] = []

func _ready():
	# Ensure conveyor_force is initialized at startup
	conveyor_force = get_direction_vector() * belt_speed
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)

func _physics_process(delta):
	for body in bodies_in_area:
		if body and body.is_inside_tree():
			body.apply_force(conveyor_force*belt_speed)

func _on_body_entered(body):
	if body is RigidBody2D:
		bodies_in_area.append(body)
		body.linear_velocity = conveyor_force.normalized() * body.linear_velocity.length()

func _on_body_exited(body):
	if body is RigidBody2D:
		bodies_in_area.erase(body)

func get_direction_vector() -> Vector2:
	match direction:
		Direction.RIGHT:
			return Vector2.RIGHT
		Direction.LEFT:
			return Vector2.LEFT
		Direction.UP:
			return Vector2.UP
		Direction.DOWN:
			return Vector2.DOWN
		_:
			return Vector2.ZERO
