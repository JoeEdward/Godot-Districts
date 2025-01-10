extends Camera3D

var RAY_LENGTH = 1000
@export var WorldNode: Node3D = null


# Called when the node enters the scene tree for the first time.
func _ready():
	if !WorldNode:
		WorldNode = get_node('/root/World')
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if (Input.is_action_just_released('ui_mouse_down')):
		var from = project_ray_origin(get_viewport().get_mouse_position())
		var to = from + project_ray_normal(get_viewport().get_mouse_position()) * RAY_LENGTH
		var query = PhysicsRayQueryParameters3D.create(from, to)
		query.collide_with_areas = true
		var result = get_world_3d().direct_space_state.intersect_ray(query)
		handleRayIntersect(result)
	pass

func handleRayIntersect(intersect):
	if intersect:
		var object = MeshInstance3D.new()
		object.mesh = BoxMesh.new()
		object.position = intersect.position
		object.create_trimesh_collision()
		
		WorldNode.add_child(object)
		print(intersect)
	else:
		print('no collision')
	pass
