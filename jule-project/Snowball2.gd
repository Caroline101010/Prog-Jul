extends CharacterBody2D
@export var id := 1
var Movement_Speed_P = 400
var Course = 1
var piss_P = false
var PissTimer = -1
var PissActiveTime = 5

#Start function, places snowballs out of screen
func _ready():
	global_position = Vector2(-5, -94)
	hide()
#Check if it is snowball 2 (piss)
func _physics_process(_delta):
	if SnowballSwitchManager.active_snowball != 2:
		hide()
		velocity = Vector2.ZERO
		global_position = Vector2(-5, -94)
		return
	else:
		show()
		
	#Check if "piss" have been clicked, if yes start a countdown
	if Input.is_action_just_pressed("Piss"):
		piss_P = true
		_start_countdown(PissActiveTime)
		
	#Calling countdown function
	_countdown(_delta)
	
	#The throw function for the snowball
	if Input.is_action_just_pressed("Left_Throw"):
		show()
		global_position = Vector2(285, 237)
		velocity.x = -Movement_Speed_P
		Course = -1
		piss_P = false
	elif Input.is_action_just_pressed("Right_Throw"):
		show()
		global_position = Vector2(285, 237)
		velocity.x = Movement_Speed_P
		Course = 1
		piss_P = false
		
	#Moves the snowball the correct direction
	velocity.x = Course * Movement_Speed_P
	
	#Check if there is a hit, gives points and respawns the snowball, 
	#for it to be used again
	var EnemyHit = move_and_collide(velocity * _delta)
	if EnemyHit:
		var Hit = EnemyHit.get_collider()
		if Hit.is_in_group("Enemy_Kid"):
			#add 20 points
			Hit.queue_free()           
			_Respawn_Snowball2()                   
			return
		elif Hit.is_in_group("Enemy_Adult"):
			#remove 10 points
			Hit.queue_free()           
			_Respawn_Snowball2()                    
			return
		elif Hit.is_in_group("Enemy_Police"):
			#end game
			Hit.queue_free()           
			_Respawn_Snowball2()                   
			return

#The start of countdown funtion
func _start_countdown(Time_Seconds):
	PissTimer = Time_Seconds
#The countdown function, that changes snowball back when times up
func _countdown(delta):
	if PissTimer > 0:
		PissTimer -= delta
	elif PissTimer <= 0 and PissTimer != -1:
		PissTimer = -1
		SnowballSwitchManager.active_snowball = 1
#The respawn function that makes the snowball able to use again
func _Respawn_Snowball2():
	hide()
	velocity = Vector2.ZERO
	global_position = Vector2(-5, -94)
	piss_P = false
