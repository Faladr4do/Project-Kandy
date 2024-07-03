extends Boss_Character
class_name Golem

var stomp_count : int
var awaken : bool = false
var can_attack : bool = false
var is_crouch : bool = false
var stompin : bool = false
var melee : bool = false

var max_stomp : int = 3
var stomp_number : int = 1

var direction = 0

func ataque_melee():
	esta_atacar = true
	animacoes.play("melee_attack")
	print_debug("melee")
	
func special_attack():
	esta_atacar = true
	animacoes.play("special")

func summon_column():
	esta_atacar = true
	animacoes.play("summon_coluna")

func stomp_attack():
	if !esta_atacar and !stompin:
		stomp_count = randi_range(4,6)
		esta_atacar = true
	if !stompin:
		stompin = true
		animacoes.play("stomp")

func wake_up():
	animacoes.play("awaken")

func movement_func():
	print_debug(direction)
	if distance_player > 150.0:
		print_debug("right")
		direction = 1
	elif distance_player < -150.0:
		print_debug("left")
		direction = -1
	if distance_player == -150.0 or 150.0:
		can_attack = true
