extends KinematicBody2D
var FILE_NAME="res://character_appearance.json"
var SPEED = 20
#为了方便颜色的保存，这里最好保存为颜色的字符串
var color_map = {
	"Hair":"ffffff",
	"Tshirt":"ffffff",
	"Short":"ffffff",
	"Shoes":"ffffff",
}
# Called when the node enters the scene tree for the first time.
func _ready():
	initiate()

func initiate():
	var file = File.new()
	if(file.file_exists(FILE_NAME)):
		file.open(FILE_NAME,File.READ)
		color_map = parse_json(file.get_as_text())
		file.close()
	else:
		print("File doesn't exsits")
		
	for node in $Base.get_children():
		node.modulate = Color(color_map[node.name])
func _physics_process(delta):
	var velocity = Vector2.ZERO
	if(Input.is_action_pressed("ui_up")):
		velocity.y -=1
	if(Input.is_action_pressed("ui_down")):
		velocity.y +=1
	if(Input.is_action_pressed("ui_left")):
		velocity.x-=1
	if(Input.is_action_pressed("ui_right")):
		velocity.x+=1
	move_and_collide(velocity * SPEED*delta)
