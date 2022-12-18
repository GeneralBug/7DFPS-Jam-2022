extends Area

onready var Player = $"../../Player"
onready var Fish = $".."

func _physics_process(delta):
	if(self.overlaps_body(Player)):
		Fish.Detected()
