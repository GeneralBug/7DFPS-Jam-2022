extends Spatial

export var Target: NodePath
var Target_Node
# Called when the node enters the scene tree for the first time.
func _ready():
	Target_Node = get_node(Target)

func _physics_process(delta):
	self.global_translation = Target_Node.global_translation
	self.global_rotation = Target_Node.global_rotation
