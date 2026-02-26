extends Node3D
class_name Avatar

@export var mouths:Node3D
@onready var animation_controller:AnimationController = get_node("AnimationTree")
@onready var costumes_node:Node3D = get_node("acidzz/Arm/Skeleton3D/OutfitAttachment/Costumes")

var costume_index:int = 0
var costumes: Array[Node3D] = []

func _ready():
	for child in costumes_node.get_children():
		if child is Node3D:
			costumes.append(child)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed('next_costume'):
		update_costumes(costume_index+1)
	if event.is_action_pressed('previous_costume'):
		update_costumes(costume_index-1)

func update_costumes(new_index: int) -> void:
	# 1. Hide the CURRENT costume first
	costumes[costume_index].visible = false
	
	# 2. Update the costume_index with the new_index
	costume_index = new_index
	
	# 3. Handle the wrapping (Overshoot/Undershoot)
	if costume_index < 0:
		costume_index = costumes.size() - 1
	elif costume_index >= costumes.size():
		costume_index = 0
	
	# 4. Show the NEW costume at the updated index
	costumes[costume_index].visible = true
