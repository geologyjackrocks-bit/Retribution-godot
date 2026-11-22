extends Camera2D

@onready var player = $"../CharacterBody2D"
@onready var player_pos = player.position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$"../CharacterBody2D/var_lable".text = str(player_pos)
	if (player_pos != player.position):
		
		pass
