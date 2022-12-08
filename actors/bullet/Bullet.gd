extends RigidBody

var shoot = false

const SPEED = 30

func _ready():
	set_as_toplevel(true)

func _physics_process(delta):
	if shoot:
		apply_impulse(transform.basis.z, -transform.basis.z * SPEED)
		shoot = false


func _on_Area_body_entered(body):
	queue_free()
