extends CharacterBody2D
var Movement_Speed_P = 400
var piss_P = false
var Piss_timer = 5.0
const piss_timer_end = 5

func _ready():
	global_position = Vector2(10, 10) 
	hide() 
	
func _process(delta):
	if Input.is_action_just_pressed("Piss"):
		piss_P = true
		Piss_timer = 5.0
	if piss_P:
		Piss_timer += delta
		if Piss_timer >= piss_timer_end:
			piss_P = false
	else:
		piss_P = false
		
func _physics_process(_delta):
	if piss_P == true:
		if Input.is_action_just_pressed("Left_Throw"):
			show()  
			global_position = Vector2(285, 241) 
			velocity.x = -Movement_Speed_P
		elif Input.is_action_just_pressed("Right_Throw"):
			show()
			global_position = Vector2(285, 241)
			velocity.x = Movement_Speed_P
		move_and_slide()
	elif piss_P == false:
		pass
