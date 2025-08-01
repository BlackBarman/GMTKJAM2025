extends CharacterBody2D

# Configurazione
@export var speed: float = 500.0  # Velocità di movimento
@export var acceleration: float = 15.0  # Fluidità in partenza
@export var friction: float = 20.0  # Fluidità in frenata
@export var push_strength: float = 100.0  # Forza applicata ai corpi rigidi

var direction: Vector2 = Vector2.ZERO  # Direzione di input

func _ready() -> void:
	physics_interpolation_mode = Node.PHYSICS_INTERPOLATION_MODE_ON


func _physics_process(delta: float) -> void:
	
	# 1. Ottieni l'input (8 direzioni)
	direction.x = Input.get_axis("ui_left", "ui_right")
	direction.y = Input.get_axis("ui_up", "ui_down")
	
	# 2. Normalizza la direzione
	if direction.length() > 0:
		direction = direction.normalized()
	
	# 3. Calcola la velocità desiderata
	if direction != Vector2.ZERO:
		velocity = velocity.lerp(direction * speed, acceleration * delta)
	else:
		velocity = velocity.lerp(Vector2.ZERO, friction * delta)
	
	# 4. Usa move_and_collide per gestire le collisioni
	var collision = move_and_collide(velocity * delta)
	
	# 5. Se colpisce qualcosa, spingilo se è un corpo rigido
	if collision and collision.get_collider() is RigidBody2D:
		var body := collision.get_collider() as RigidBody2D
		var push_dir := velocity.normalized()
		body.apply_central_impulse(push_dir * push_strength)
