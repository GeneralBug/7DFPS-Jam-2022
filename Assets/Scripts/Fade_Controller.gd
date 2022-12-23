extends Control

onready var Rect = $Rect
export var Fade_Step: float = 0.1
var Alpha = 1
var Fade_In = false
func _ready():
	Rect.color = Color.black
	print(Color.black)

func _physics_process(_delta):
	if(Fade_In):	
		Rect.color = Color(0, 0, 0, Alpha)
		Alpha -= Fade_Step
		if(Alpha < 0):
			Fade_In = false


func _on_Fade_In_Timer_timeout():
	Fade_In = true
