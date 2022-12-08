extends KinematicBody

const MIN_CAMERA_ANGLE = -60
const MAX_CAMERA_ANGLE = 70
const GRAVITY = -40
const RAY_LENGTH = 1000

export var camera_sensitivity: float = 0.1
export var speed: float = 10
export var acceleration: float = 10
export var jump_impulse: float = 12
export var maxhealth: float = 150
var velocity: Vector3 = Vector3.ZERO
var flashclick = preload("res://sounds/temp/413690__splatfreesound__click.wav")
onready var flashlight2 = $head/flashlight2
onready var flashlight3 = $head/flashlight3
onready var head: Spatial = $head

onready var initial_pos = self.global_transform
onready var health = maxhealth
onready var bullet = preload("res://actors/bullet/Bullet.tscn")
onready var shoot = $head/flashlight/Shoot


func _unhandled_input(event):
	if event is InputEventMouseMotion:
		_handle_camera_rotation(event)
		
func _input(event):
	if Input.is_action_just_pressed("toglelight") and flashlight2.visible == false:
		flashlight2.show()
		flashlight3.show()
		$AudioStreamPlayer3D.stream = flashclick
		$AudioStreamPlayer3D.play()
	elif Input.is_action_just_pressed("toglelight") and flashlight2.visible == true:
		flashlight2.hide()
		flashlight3.hide()
		$AudioStreamPlayer3D.stream = flashclick
		$AudioStreamPlayer3D.play()
	

func _get_movement_direction():
	var direction = Vector3.DOWN
	
	if Input.is_action_pressed("forward"):
		direction += transform.basis.x
	if Input.is_action_pressed("backward"):
		direction -= transform.basis.x
	if Input.is_action_pressed("left"):
		direction -= transform.basis.z
	if Input.is_action_pressed("right"):
		direction += transform.basis.z
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = jump_impulse
	
	return direction.normalized()

func _handle_camera_rotation(event):
	rotate_y(deg2rad(-event.relative.x * camera_sensitivity))
	head.rotate_z(deg2rad(-event.relative.y*camera_sensitivity))
	head.rotation.z = clamp(head.rotation.z, deg2rad(MIN_CAMERA_ANGLE), deg2rad(MAX_CAMERA_ANGLE))

func _physics_process(delta):
	var movement = _get_movement_direction()
	var gravity_res = get_floor_normal() if is_on_floor() else Vector3.UP
	
	
	if Input.is_action_just_pressed("shoot"):
		var b = bullet.instance()
		shoot.add_child(b)
		b.rotation = $head/Camera.global_rotation
		#b.rotate_z(deg2rad(5))
		b.shoot = true
	
	velocity.x = lerp(velocity.x,movement.x*speed,acceleration*delta)
	velocity.z = lerp(velocity.z,movement.z*speed,acceleration*delta)
	velocity += GRAVITY * delta * gravity_res
	velocity = move_and_slide(velocity, Vector3.UP)

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func kill():
	self.global_transform = initial_pos
	health = maxhealth

func hurt():
	health -= 10
	if health <= 0:
		self.kill()




