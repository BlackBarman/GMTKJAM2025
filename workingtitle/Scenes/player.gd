extends CharacterBody2D

# Configurazione
@export var speed: float = 500.0  # Velocità di movimento
@export var acceleration: float = 15.0  # Fluidità in partenza
@export var friction: float = 20.0  # Fluidità in frenata

var direction: Vector2 = Vector2.ZERO  # Direzione di input

func _physics_process(delta: float) -> void:
	# 1. Ottieni l'input (8 direzioni)
	direction.x = Input.get_axis("ui_left", "ui_right")  # -1 (sinistra), +1 (destra)
	direction.y = Input.get_axis("ui_up", "ui_down")     # -1 (su), +1 (giù)
	
	# 2. Normalizza la direzione per evitare velocità maggiori in diagonale
	if direction.length() > 0:
		direction = direction.normalized()  # Lunghezza = 1
	
	# 3. Calcola la velocità
	if direction != Vector2.ZERO:
		velocity = velocity.lerp(direction * speed, acceleration * delta)  # Accelerazione progressiva
	else:
		velocity = velocity.lerp(Vector2.ZERO, friction * delta)  # Decelerazione progressiva
	
	# 4. Muovi il personaggio
	move_and_slide()
