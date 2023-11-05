extends MeshInstance3D

# TODO
# Length mapping ends up with cut off strands
# Should be darker further down
# Should use length map texture
# Physics
# XR
# Should use bunny model

@export var density : int = 100
@export var color : Color
@export var shellCount : int = 16
@export var totalHeight : float = 0.2
@export var maxWidth : float = 0.7
@export var indexWidthMapping : Curve

#var shellMaterials : Array[Material]

func _ready():
	construct_shells()

func construct_shells():
#	shellMaterials = []
	var shellMaterial = self.get_active_material(0)
	shellMaterial.set_shader_parameter("_Density", density)
	shellMaterial.set_shader_parameter("_Color", color)
	for shellIndex in shellCount:
		var shell = MeshInstance3D.new()
		shell.name = "Shell %d" % shellIndex
		shell.mesh = self.mesh
		self.add_child(shell)
		
#		var shellMaterial = shell.get_active_material(0)
#		shellMaterials.append(shellMaterial)
		
		var normalizedIndex = float(shellIndex) / (shellCount - 1)
		var threshold = lerp(0.0, 1.0, normalizedIndex)
		var width = maxWidth * indexWidthMapping.sample(normalizedIndex);
		var height = lerp(0.0, totalHeight, normalizedIndex)
		
		shell.set_instance_shader_parameter("_Threshold", threshold)
		shell.set_instance_shader_parameter("_Width", width)
		shell.set_instance_shader_parameter("_Height", height)


func _process(delta):
	pass
