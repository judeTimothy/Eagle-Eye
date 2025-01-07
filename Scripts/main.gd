extends Control

var COLLECTION_ID = "quizzes"
var SCORE_ID = "scores"
var quiz_array = []
var answered_quiz = []
var selected_id = "213123123123"
var score = 0

var current_score_view = "213123123123"

@onready var quiz_select = preload("res://Scenes/quiz.tscn")
@onready var item_select = preload("res://Scenes/item.tscn")
# Called when the node enters the scene tree for the first time.

func _ready():
	load_data()
	
	
	
	
	
func get_finished_quizzes():
	answered_quiz = []
	var auth = Firebase.Auth.auth
	var query : FirestoreQuery = FirestoreQuery.new().from("scores")
	var result: Array = await Firebase.Firestore.query(query).result_query
	if result.size() > 0:
		for i in range(result.size()):
			if result[i].doc_name == auth.localid:
				answered_quiz = result[i].doc_fields.keys()
	print("Finished Quizzes")
	print(answered_quiz)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if not quiz_array.is_empty():
		%QuizContainer/NotAvailable.visible = false
	else:
		%QuizContainer/NotAvailable.visible = true


func _on_logout_pressed():
	Firebase.Auth.logout()
	get_tree().change_scene_to_file("res://Scenes/authentication.tscn")


func _on_save_pressed():
	#save_data()
	%CreatePanel.visible = true
	
func save_data():
	var auth = Firebase.Auth.auth
	randomize()
	var randomid = ""
	for i in range(28):
		randomize()
		var int_or_hex = randi_range(1,2)
		if i == 0:
			int_or_hex = 2
		if int_or_hex == 1:
			randomid += str(randi_range(0,9))
		else:
			var alphabet = {1: "A", 2: "B", 3: "C", 4: "D", 5: "E", 6: "F", 7: "G", 8: "H", 9: "I", 10: "J", 11: "K", 12: "L", 13: "M", 14: "N", 15: "O", 16: "P", 17: "Q", 18: "R", 19: "S", 20: "T", 21: "U", 22: "V", 23: "W", 24: "X", 25: "Y", 26: "Z"}
			var hex_number = randi_range(1,26)
			randomize()
			var upper_or_not = randi_range(1,2)
			if upper_or_not == 1:
				randomid += alphabet[hex_number]
			else:
				randomid += alphabet[hex_number].to_lower()
	if auth.localid:
		var collection: FirestoreCollection = Firebase.Firestore.collection(COLLECTION_ID)
		randomize()
		var random_num = randi_range(1,10)
		var data: Dictionary = {
			"points": random_num,
			"quiz_name": $%CreatePanel/ScrollContainer/ItemContainer/QuizNameEdit.text,
			"Q1": $CreatePanel/ScrollContainer/ItemContainer/Item1/Question.text,
			"S1": $CreatePanel/ScrollContainer/ItemContainer/Item1/Answer.text,
			"A1": $CreatePanel/ScrollContainer/ItemContainer/Item1/Choice1.text,
			"B1": $CreatePanel/ScrollContainer/ItemContainer/Item1/Choice2.text,
			"C1": $CreatePanel/ScrollContainer/ItemContainer/Item1/Choice3.text,
			"D1": $CreatePanel/ScrollContainer/ItemContainer/Item1/Choice4.text,
			"Q2": $CreatePanel/ScrollContainer/ItemContainer/Item2/Question.text,
			"S2": $CreatePanel/ScrollContainer/ItemContainer/Item2/Answer.text,
			"A2": $CreatePanel/ScrollContainer/ItemContainer/Item2/Choice1.text,
			"B2": $CreatePanel/ScrollContainer/ItemContainer/Item2/Choice2.text,
			"C2": $CreatePanel/ScrollContainer/ItemContainer/Item2/Choice3.text,
			"D2": $CreatePanel/ScrollContainer/ItemContainer/Item2/Choice4.text,
			"Q3": $CreatePanel/ScrollContainer/ItemContainer/Item3/Question.text,
			"S3": $CreatePanel/ScrollContainer/ItemContainer/Item3/Answer.text,
			"A3": $CreatePanel/ScrollContainer/ItemContainer/Item3/Choice1.text,
			"B3": $CreatePanel/ScrollContainer/ItemContainer/Item3/Choice2.text,
			"C3": $CreatePanel/ScrollContainer/ItemContainer/Item3/Choice3.text,
			"D3": $CreatePanel/ScrollContainer/ItemContainer/Item3/Choice4.text,
			"Q4": $CreatePanel/ScrollContainer/ItemContainer/Item4/Question.text,
			"S4": $CreatePanel/ScrollContainer/ItemContainer/Item4/Answer.text,
			"A4": $CreatePanel/ScrollContainer/ItemContainer/Item4/Choice1.text,
			"B4": $CreatePanel/ScrollContainer/ItemContainer/Item4/Choice2.text,
			"C4": $CreatePanel/ScrollContainer/ItemContainer/Item4/Choice3.text,
			"D4": $CreatePanel/ScrollContainer/ItemContainer/Item4/Choice4.text,
			"Q5": $CreatePanel/ScrollContainer/ItemContainer/Item5/Question.text,
			"S5": $CreatePanel/ScrollContainer/ItemContainer/Item5/Answer.text,
			"A5": $CreatePanel/ScrollContainer/ItemContainer/Item5/Choice1.text,
			"B5": $CreatePanel/ScrollContainer/ItemContainer/Item5/Choice2.text,
			"C5": $CreatePanel/ScrollContainer/ItemContainer/Item5/Choice3.text,
			"D5": $CreatePanel/ScrollContainer/ItemContainer/Item5/Choice4.text,
			"Q6": $CreatePanel/ScrollContainer/ItemContainer/Item6/Question.text,
			"S6": $CreatePanel/ScrollContainer/ItemContainer/Item6/Answer.text,
			"A6": $CreatePanel/ScrollContainer/ItemContainer/Item6/Choice1.text,
			"B6": $CreatePanel/ScrollContainer/ItemContainer/Item6/Choice2.text,
			"C6": $CreatePanel/ScrollContainer/ItemContainer/Item6/Choice3.text,
			"D6": $CreatePanel/ScrollContainer/ItemContainer/Item6/Choice4.text,
			"Q7": $CreatePanel/ScrollContainer/ItemContainer/Item7/Question.text,
			"S7": $CreatePanel/ScrollContainer/ItemContainer/Item7/Answer.text,
			"A7": $CreatePanel/ScrollContainer/ItemContainer/Item7/Choice1.text,
			"B7": $CreatePanel/ScrollContainer/ItemContainer/Item7/Choice2.text,
			"C7": $CreatePanel/ScrollContainer/ItemContainer/Item7/Choice3.text,
			"D7": $CreatePanel/ScrollContainer/ItemContainer/Item7/Choice4.text,
			"Q8": $CreatePanel/ScrollContainer/ItemContainer/Item8/Question.text,
			"S8": $CreatePanel/ScrollContainer/ItemContainer/Item8/Answer.text,
			"A8": $CreatePanel/ScrollContainer/ItemContainer/Item8/Choice1.text,
			"B8": $CreatePanel/ScrollContainer/ItemContainer/Item8/Choice2.text,
			"C8": $CreatePanel/ScrollContainer/ItemContainer/Item8/Choice3.text,
			"D8": $CreatePanel/ScrollContainer/ItemContainer/Item8/Choice4.text,
			"Q9": $CreatePanel/ScrollContainer/ItemContainer/Item9/Question.text,
			"S9": $CreatePanel/ScrollContainer/ItemContainer/Item9/Answer.text,
			"A9": $CreatePanel/ScrollContainer/ItemContainer/Item9/Choice1.text,
			"B9": $CreatePanel/ScrollContainer/ItemContainer/Item9/Choice2.text,
			"C9": $CreatePanel/ScrollContainer/ItemContainer/Item9/Choice3.text,
			"D9": $CreatePanel/ScrollContainer/ItemContainer/Item9/Choice4.text,
			"Q10": $CreatePanel/ScrollContainer/ItemContainer/Item10/Question.text,
			"S10": $CreatePanel/ScrollContainer/ItemContainer/Item10/Answer.text,
			"A10": $CreatePanel/ScrollContainer/ItemContainer/Item10/Choice1.text,
			"B10": $CreatePanel/ScrollContainer/ItemContainer/Item10/Choice2.text,
			"C10": $CreatePanel/ScrollContainer/ItemContainer/Item10/Choice3.text,
			"D10": $CreatePanel/ScrollContainer/ItemContainer/Item10/Choice4.text
		}
		var task: FirestoreTask = collection.update(randomid,data)
		
func load_data():
	quiz_array = []
	get_finished_quizzes()
	if %QuizContainer.get_child_count() > 1:
		for n in %QuizContainer.get_children():
			if n.name != "NotAvailable":
				%QuizContainer.remove_child(n)
				n.queue_free()
	var query : FirestoreQuery = FirestoreQuery.new().from("quizzes").where("points", FirestoreQuery.OPERATOR.GREATER_THAN, 0).order_by("points", FirestoreQuery.DIRECTION.DESCENDING).limit(10)
	var result: Array = await Firebase.Firestore.query(query).result_query
	if result.size() > 0:
		for i in range(result.size()):
			var q = quiz_select.instantiate()
			q.quiz_name = result[i].doc_fields["quiz_name"]
			q.id = str(result[i].doc_name)
			if result[i].doc_name in answered_quiz:
				q.status = "Answered"
			else:
				q.status = "Not Answered"
			q.questions = "Questions: 10"
			%QuizContainer.add_child(q)
			quiz_array.append(result[i].doc_name)
			
	#	#Score retrieval from score collection
	#	var query2 : FirestoreQuery = FirestoreQuery.new().from("scores")
	#	var result2: Array = await Firebase.Firestore.query(query2).result_query
	
	#	var res = result2[0].doc_fields.keys()
	#	print(res[0])
	#	print(result2[0].doc_fields[res[0]][0])
	print("All Quizzes")
	print(quiz_array)
	
func _on_load_pressed():
	get_tree().reload_current_scene()
	

func populate_panel(current_quiz_name):
	var x = quiz_array.find(selected_id)
	%ColorRect.visible = true
	%QuizName.text = str(current_quiz_name)
	%QuizID.text = "ID: " + str(selected_id)
	%Panel.visible = true
	if %ItemContainer.get_child_count() > 0:
		for n in %ItemContainer.get_children():
			if n.name == "CheckAnswer" or n.name == "Close" or n.name == "QuizName" or n.name == "QuizID" or n.name == "FillerSpace" or n.name == "FillerSpace2" or n.name == "Score":
				pass
			else:
				%ItemContainer.remove_child(n)
				n.queue_free()
	if selected_id in answered_quiz:
		$Panel/ScrollContainer/ItemContainer/CheckAnswer.disabled = true
		var auth = Firebase.Auth.auth
		var query : FirestoreQuery = FirestoreQuery.new().from("scores")
		var result: Array = await Firebase.Firestore.query(query).result_query
		var view_score = 0
		if result.size() > 0:
			for i in range(result.size()):
				if result[i].doc_name == auth.localid:
					view_score = result[i].doc_fields[selected_id]
					
		%Panel/ScrollContainer/ItemContainer/CheckAnswer.visible = false
		%Score.visible = true
		%Score.text = "Already Answered: \nScore: " + str(view_score) + "/10"
	else:
		$Panel/ScrollContainer/ItemContainer/Score.visible = false
		$Panel/ScrollContainer/ItemContainer/CheckAnswer.visible = true
		var query : FirestoreQuery = FirestoreQuery.new().from("quizzes").where("points", FirestoreQuery.OPERATOR.GREATER_THAN, 0).order_by("points", FirestoreQuery.DIRECTION.DESCENDING).limit(10)
		var result: Array = await Firebase.Firestore.query(query).result_query
		for i in range(10):
			var t = item_select.instantiate()
			var current_q = "Q1"
			var current_a = "A1"
			var current_b = "B1"
			var current_c = "C1"
			var current_d = "D1"
			var current_s = "S1"
			match i:
				0:
					current_q = "Q1"
					current_a = "A1"
					current_b = "B1"
					current_c = "C1"
					current_d = "D1"
					current_s = "S1"
				1:
					current_q = "Q2"
					current_a = "A2"
					current_b = "B2"
					current_c = "C2"
					current_d = "D2"
					current_s = "S2"
				2:
					current_q = "Q3"
					current_a = "A3"
					current_b = "B3"
					current_c = "C3"
					current_d = "D3"
					current_s = "S3"
				3:
					current_q = "Q4"
					current_a = "A4"
					current_b = "B4"
					current_c = "C4"
					current_d = "D4"
					current_s = "S4"
				4:
					current_q = "Q5"
					current_a = "A5"
					current_b = "B5"
					current_c = "C5"
					current_d = "D5"
					current_s = "S5"
				5:
					current_q = "Q6"
					current_a = "A6"
					current_b = "B6"
					current_c = "C6"
					current_d = "D6"
					current_s = "S6"
				6:
					current_q = "Q7"
					current_a = "A7"
					current_b = "B7"
					current_c = "C7"
					current_d = "D7"
					current_s = "S7"
				7:
					current_q = "Q8"
					current_a = "A8"
					current_b = "B8"
					current_c = "C8"
					current_d = "D8"
					current_s = "S8"
				8:
					current_q = "Q9"
					current_a = "A9"
					current_b = "B9"
					current_c = "C9"
					current_d = "D9"
					current_s = "S9"
				9:
					current_q = "Q10"
					current_a = "A10"
					current_b = "B10"
					current_c = "C10"
					current_d = "D10"
					current_s = "S10"
			t.question = result[x].doc_fields[current_q]
			t.a_choice = result[x].doc_fields[current_a]
			t.b_choice = result[x].doc_fields[current_b]
			t.c_choice = result[x].doc_fields[current_c]
			t.d_choice = result[x].doc_fields[current_d]
			t.answer = result[x].doc_fields[current_s]
			%ItemContainer.add_child(t)
			%ItemContainer.move_child(t,%ItemContainer.get_child_count()-5)
		
		$Panel/ScrollContainer/ItemContainer/CheckAnswer.disabled = false

func _on_close_pressed():
	get_tree().reload_current_scene()
	%Panel.visible = false
	%ColorRect.visible = false


func _on_check_answer_pressed():
	score = 0
	if %ItemContainer.get_child_count() > 3:
		for n in %ItemContainer.get_children():
			if n.name == "CheckAnswer" or n.name == "Close" or n.name == "QuizName" or n.name == "QuizID" or n.name == "FillerSpace" or n.name == "FillerSpace2" or n.name == "Score":
				pass
			else:
				n.check_answer()
				if n.correct == true:
					score+=1
	print(score)
	$Panel/ScrollContainer/ItemContainer/CheckAnswer.disabled = true
	send_score()


func _on_close_edit_pressed():
	get_tree().reload_current_scene()
	%CreatePanel.visible = false


func _on_save_quiz_pressed():
	get_tree().reload_current_scene()
	%CreatePanel.visible = false
	save_data()

func send_score():
	var auth = Firebase.Auth.auth
	if auth.localid:
		var collection: FirestoreCollection = Firebase.Firestore.collection(SCORE_ID)
		var string_key = str(selected_id)
		
		# randomizer
		"""randomize()
		var randomid = ""
		for i in range(28):
			randomize()
			var int_or_hex = randi_range(1,2)
			if int_or_hex == 1:
				randomid += str(randi_range(0,9))
			else:
				var alphabet = {1: "A", 2: "B", 3: "C", 4: "D", 5: "E", 6: "F", 7: "G", 8: "H", 9: "I", 10: "J", 11: "K", 12: "L", 13: "M", 14: "N", 15: "O", 16: "P", 17: "Q", 18: "R", 19: "S", 20: "T", 21: "U", 22: "V", 23: "W", 24: "X", 25: "Y", 26: "Z"}
				var hex_number = randi_range(1,26)
				randomize()
				var upper_or_not = randi_range(1,2)
				if upper_or_not == 1:
					randomid += alphabet[hex_number]
				else:
					randomid += alphabet[hex_number].to_lower()
		print(randomid)
		var scores = {
			randomid : [string_key, score]
		}"""
		
		
		var new_key = str(selected_id)
		var scores = {
			new_key: score
 		}
		var task: FirestoreTask = collection.update(auth.localid,scores)
	
