extends CharacterBody2D
@export var id := 1
var Movement_Speed_N = 400
var Course = 1
var piss_N = true

#Start function, places snowballs out of screen
func _ready():
	global_position = Vector2(-5, -94)
	hide()
#Check if it is snowball 1 (normal)
func _physics_process(_delta):
	if SnowballSwitchManager.active_snowball != 1:
		hide()
		velocity = Vector2.ZERO
		global_position = Vector2(-5, -94)
		return
	else:
		show()
		
	#Sets snowball 1 to true if false, mainly to use after switching back
	if piss_N == false:
		piss_N = true
		velocity.x = Course * Movement_Speed_N
	
	#The throw function for the snowball	
	if Input.is_action_just_pressed("Left_Throw"):
		show()
		global_position = Vector2(210, 225)
		velocity.x = -Movement_Speed_N
		Course = -1
		piss_N = true
	elif Input.is_action_just_pressed("Right_Throw"):
		show()
		global_position = Vector2(210, 225)
		velocity.x = Movement_Speed_N
		Course = 1
		piss_N = true
	
	#Check if there is a hit, gives points and respawns the snowball, 
	#for it to be used again
	if piss_N == true:
		var EnemyHit = move_and_collide(velocity * _delta)
		if EnemyHit:
			var Hit = EnemyHit.get_collider()
			if Hit.is_in_group("Enemy_Kid"):
				#add 20 points
				Hit.queue_free()           
				_Respawn_Snowball1()                 
				return
			elif Hit.is_in_group("Enemy_Adult"):
				#remove 10 points
				Hit.queue_free()           
				_Respawn_Snowball1()                   
				return
			elif Hit.is_in_group("Enemy_Police"):
				#end game
				Hit.queue_free()           
				_Respawn_Snowball1()                     
				return
	#Changes snowball 1 (normal) to snowball 2 (piss) if "piss" is clicked
	if Input.is_action_just_pressed("Piss"):
		SnowballSwitchManager.active_snowball = 2
		piss_N = false
		
#The respawn function that makes the snowball able to use again
func _Respawn_Snowball1():
	hide()
	velocity = Vector2.ZERO
	global_position = Vector2(-5, -94)
	piss_N = false
