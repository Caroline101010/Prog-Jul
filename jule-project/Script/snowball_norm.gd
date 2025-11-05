extends CharacterBody2D
var Movement_Speed_N = 400
var piss_N = false
var Piss_timer = 5.0
const piss_timer_end = 5

func _ready():
	global_position = Vector2(0, 0) 
	hide() 

func _physics_process(_delta):
	if piss_N == false:
		if Input.is_action_just_pressed("Left_Throw"):
			show()  
			global_position = Vector2(210, 225) 
			velocity.x = -Movement_Speed_N
		elif Input.is_action_just_pressed("Right_Throw"):
			show()
			global_position = Vector2(210, 225)
			velocity.x = Movement_Speed_N
		move_and_slide()
	elif piss_N == true:
		pass
		
