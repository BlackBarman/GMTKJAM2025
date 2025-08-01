extends Node2D




func should_destroy(body : Block):
	pass

func _on_body_entered(body: Block) -> void:
		should_destroy(body)
		pass 
