extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var Loaded: bool = true
var Projectile

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func SetProjectile(Ref):
	Projectile = Ref
	
func Shoot():
	#1. check if fired
	#	a. tether unlocks (TODO: max tether length?)
	#	b. shoot harpoon (anim trigger)
	#	c. **harpoon collides, sticks to object
	#	d. **tether locks
	#2. else, unloaded:
	#	a. "tug" harpoon (anim trigger)
	#		I. in object, unsticks
	#		II. in fish, chance to pull fish
	#	b. tether retracts
	#	c. **touches player, reloads 
	
	print("bang")
	if(Loaded):
		print("firing " + Projectile.ID)
		#Loaded = false;
		#TODO: unlock tether
		#TODO: trigger gun animation
		Projectile.Fire()
	else:
		print("not firing")
