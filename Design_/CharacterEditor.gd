extends Node2D

var current_item = 'Hair'
#为了保持每次对应的按钮的选择完以后的颜色
#var color_map = {
#	"Hair":Color.white,
#	"Tshirt":Color.white,
#	"Short":Color.white,
#	"Shoes":Color.white
#}
#为了方便颜色的保存，这里最好保存为颜色的字符串
var color_map = {
	"Hair":"ffffff",
	"Tshirt":"ffffff",
	"Short":"ffffff",
	"Shoes":"ffffff",
}
#var FILE_NAME="user://character_appearance.json"
var FILE_NAME="res://character_appearance.json"
#所以这里的$应该就是一个节点选择器
# Called when the node enters the scene tree for the first time.
func _ready():
	
	$Hair.connect("pressed",self,"on_button_processed",[$Hair])
	$Tshirt.connect("pressed",self,"on_button_processed",[$Tshirt])
	$Short.connect("pressed",self,"on_button_processed",[$Short])
	$Shoes.connect("pressed",self,"on_button_processed",[$Shoes])
#因为这些按钮被放进了一个container里面了，所以就直接用循环进行访问节点了
#不知道什么原因，我放进去一个container以后，就访问不到他的子节点，所以这个代码暂时不能用
#	for node in $ChangeButtonContainer.get_children():
#		node.connect("pressed",self,"on_button_processed",[node])
#	$ChangeButtonContainer.get_node(current_item).pressed = true

	var file = File.new()
	if(file.file_exists(FILE_NAME)):
		file.open(FILE_NAME,File.READ)
		color_map = parse_json(file.get_as_text())
		file.close()
	else:
		print("File doesn't exsits")
		
	for node in $Base.get_children():
		node.modulate = Color(color_map[node.name])

func on_button_processed(button):
	#通过按钮的名称来调用这些函数的按钮事件
	current_item = button.name
	print(current_item)
	$Panel/ColorPicker.color =Color(color_map[current_item]) 
	
func on_color_change(color):
	$Base.get_node(current_item).modulate = color
	color_map[current_item] = color.to_html()


func _on_SaveButton_pressed():
	var file = File.new()
	file.open(FILE_NAME,File.WRITE)
	file.store_string(to_json(color_map))
	file.close()
	print(to_json(color_map))
