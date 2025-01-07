extends VBoxContainer

var question = "This is sample question 1"
var a_choice = "This is a sample choice A"
var b_choice = "This is a sample choice B"
var c_choice = "This is a sample choice C"
var d_choice = "This is a sample choice D"
var answer = "A"
var selected_answer = ""
var correct = false
# Called when the node enters the scene tree for the first time.
func _ready():
	%Question.text = question
	%A/Label.text = a_choice
	%B/Label.text = b_choice
	%C/Label.text = c_choice
	%D/Label.text = d_choice

func _physics_process(delta):
	$A.custom_minimum_size.y = $A/Label.size.y
	$B.custom_minimum_size.y = $B/Label.size.y
	$C.custom_minimum_size.y = $C/Label.size.y
	$D.custom_minimum_size.y = $D/Label.size.y


func _on_a_pressed():
	%B.button_pressed = false
	%C.button_pressed = false
	%D.button_pressed = false
	selected_answer = "A"
	
func _on_b_pressed():
	%A.button_pressed = false
	%C.button_pressed = false
	%D.button_pressed = false
	selected_answer = "B"


func _on_c_pressed():
	%B.button_pressed = false
	%A.button_pressed = false
	%D.button_pressed = false
	selected_answer = "C"


func _on_d_pressed():
	%B.button_pressed = false
	%C.button_pressed = false
	%A.button_pressed = false
	selected_answer = "D"

func check_answer():
	print("Correct Answer: ", answer)
	print("Selected Answer: ", selected_answer )
	if answer == selected_answer:
		correct = true
		%Question.set("theme_override_colors/font_color",Color.GREEN)
	else:
		correct = false
		%Question.set("theme_override_colors/font_color",Color.RED)
	for i in range(get_child_count()):
		if get_child(i).get_index() == 0:
			pass
		else:
			get_child(i).disabled = true
