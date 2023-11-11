extends MeshInstance3D

# TODO
# Physics
# XR

@export var density : int = 100
@export var noiseMax : float
@export var maxHeight : float
@export var shellCount : int = 16

#var shellMaterials : Array[Material]

func _ready():
	construct_shells()

func construct_shells():
#	shellMaterials = []
	var shellMaterial = self.get_active_material(0)
	shellMaterial.set_shader_parameter("_Density", density)
	shellMaterial.set_shader_parameter("_NoiseMax", noiseMax)
	shellMaterial.set_shader_parameter("_MaxHeight", maxHeight)
	for shellIndex in shellCount:
		var shell = MeshInstance3D.new()
		shell.name = "Shell %d" % shellIndex
		shell.mesh = self.mesh
		self.add_child(shell)
		
#		var shellMaterial = shell.get_active_material(0)
#		shellMaterials.append(shellMaterial)
		
		var normalizedHeight = float(shellIndex) / (shellCount - 1)
		shell.set_instance_shader_parameter("_NormalizedHeight", normalizedHeight)


func _process(delta):
	pass
