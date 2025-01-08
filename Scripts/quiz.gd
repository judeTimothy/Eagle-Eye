extends Button
var quiz_name = "Quiz"
var questions = 10
var id = 1231231231
var id_display = ""
var status = "Not Answered"

func _ready():
	%Name.text = quiz_name
	id_display = "ID: " + str(id)
	%ID.text = id_display
	%Questions.text = str(questions)
	%Status.text = status


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	get_parent().get_parent().get_parent().get_parent().selected_id = id
	get_parent().get_parent().get_parent().get_parent().populate_panel(quiz_name)
