extends Control
var DATABASE_FILE="res://user_information.json"
var user_info = {
	"UserName":"username",
	"PassWord":"password"
}


# Called when the node enters the scene tree for the first time.
func _ready():
	_on_Login_pressed()

func _on_Login_pressed():
	if($NinePatchRect/VBoxContainer/Username.text != user_info.UserName || $NinePatchRect/VBoxContainer/Password.text != user_info.PassWord):
		print("User doesn't exists ! Please check you input")
	else:
		get_tree().change_scene("res://character appearance.tscn")
		print("场景更换成功")


func _on_Register_pressed():
	var file = File.new()
	file.open(DATABASE_FILE,File.WRITE)
	file.store_string(to_json(user_info))
	file.close()
	print(to_json(user_info))






