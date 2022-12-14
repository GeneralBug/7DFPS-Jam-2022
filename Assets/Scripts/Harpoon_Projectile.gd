extends KinematicBody

export var ID = "default"
enum STATE {LOADED, FIRING, LANDED, RETRACTING}
var State = STATE.LOADED
var Changing_State = true
export var Speed: float = 0.5
onready var Harpoon_Gun = $"../Player/Camera Anchor/Harpoon/Harpoon_Gun"
onready var Player = $"../Player"
onready var Fake_Harpoon = $"../Player/Camera Anchor/Harpoon/Harpoon_Gun/Fake_Harpoon"
var Collision

func GetID() -> String:
	return ID
	
func _physics_process(delta):
	match State:
		STATE.LOADED: #follow gun
			if(Changing_State):
				#TODO: remove rope
				Fake_Harpoon.show()
				self.hide()
				
				Changing_State = false
				
		STATE.FIRING: 
			if(Changing_State):
				#TODO: add rope
				self.global_transform = Harpoon_Gun.global_transform
				Fake_Harpoon.hide()
				self.show()
				Changing_State = false
			Collision = move_and_collide(transform.basis.xform(Vector3(1, 0, 0)* Speed))
			#move_and_slide(Player.transform.basis.xform(Vector3(0, 0, 1).normalized()) * Speed, Vector3.UP, true, 0, 0.785398, false)
			if(Collision):
				Collide(Collision)
			
		STATE.LANDED:
			if(Changing_State):
				#TODO: freeze rope length
				Changing_State = false
			
		STATE.RETRACTING:
			#TODO: replace this with rope retraction
			if(Changing_State):
				print("retracting")
				self.global_transform = Player.global_transform
				
				Changing_State = false
			Collision = move_and_collide(Vector3.ZERO)
			#move_and_slide(Player.transform.basis.xform(Vector3(0, 0, 1).normalized()) * Speed, Vector3.UP, true, 0, 0.785398, false)
			if(Collision):
				Collide(Collision)
			
				
func Fire():
	if(State == STATE.LOADED):
		#TODO: animation
		Changing_State = true
		State = STATE.FIRING
	elif(State == STATE.LANDED):
		#TODO: animation
		Changing_State = true
		State = STATE.RETRACTING

func Collide(collision):
	print(collision.get_collider())
	Changing_State = true
	if(collision.get_collider().name == "Player"):
		print("loading")
		State = STATE.LOADED
	elif(State != STATE.RETRACTING):
		print("landed")
		State = STATE.LANDED
		#TODO: handle fish damage in fish script
