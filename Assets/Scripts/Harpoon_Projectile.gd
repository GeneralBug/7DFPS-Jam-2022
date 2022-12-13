extends KinematicBody

export var ID = "default"
enum STATE {LOADED, FIRING, LANDED, RETRACTING}
var State = STATE.LOADED
var Changing_State = true
export var Speed: float = 0.5
onready var Harpoon_Gun = $"../Player/Camera Anchor/Harpoon/Harpoon_Gun"
onready var Player = $"../Player"
onready var Fake_Harpoon = $"../Player/Camera Anchor/Harpoon/Harpoon_Gun/Fake_Harpoon"

func GetID() -> String:
	return ID
	
func _physics_process(delta):
	match State:
		STATE.LOADED: #follow gun
			if(Changing_State):
				Fake_Harpoon.show()
				self.hide()
				
				Changing_State = false
				
		STATE.FIRING: 
			if(Changing_State):
				self.global_transform = Harpoon_Gun.global_transform
				Fake_Harpoon.hide()
				self.show()
				Changing_State = false
			move_and_collide(transform.basis.xform(Vector3(1, 0, 0)* Speed) )
			#move_and_slide(Player.transform.basis.xform(Vector3(0, 0, 1).normalized()) * Speed, Vector3.UP, true, 0, 0.785398, false)
			
		STATE.LANDED:
			pass #TODO
			
		STATE.RETRACTING:
			pass #TODO
		
func Fire():
	if(State == STATE.LOADED):
		Changing_State = true
		State = STATE.FIRING
		

