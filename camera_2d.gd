extends Camera2D

@onready var player =  $"../CharacterBody2D"
@onready var player_pos = player.position
@onready var cam = $"."
var cam_damp = 7


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if (player_pos != player.position):
		cam.position.x -= ((cam.position.x-player.position.x)/cam_damp)
		cam.position.y -= ((cam.position.y-player.position.y)/cam_damp)
