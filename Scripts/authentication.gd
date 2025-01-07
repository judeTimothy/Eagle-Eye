extends Control

var stay = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	Firebase.Auth.login_succeeded.connect(on_login_succeeded)
	Firebase.Auth.signup_succeeded.connect(on_signup_succeeded)
	Firebase.Auth.login_failed.connect(on_login_failed)
	Firebase.Auth.signup_failed.connect(on_signup_failed)

	if Firebase.Auth.check_auth_file():
		%StateLabel.visible = true
		%StateLabel.text = "Logged in."
		# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if not stay:
		%CheckBox.text = "SAVE LOGIN?"
		%CheckBox.set("theme_override_colors/font_color",Color.WHITE)
		%CheckBox.set("theme_override_colors/font_pressed_color",Color.WHITE)
		%CheckBox.set("theme_override_colors/font_focus_color",Color.WHITE)
		%CheckBox.set("theme_override_colors/font_hover_color",Color.WHITE)
		%CheckBox.set("theme_override_colors/font_hover_pressed_color",Color.WHITE)
	else:
		%CheckBox.text = "LOGIN SAVED"
		%CheckBox.set("theme_override_colors/font_color",Color.GREEN)
		%CheckBox.set("theme_override_colors/font_pressed_color",Color.GREEN)
		%CheckBox.set("theme_override_colors/font_focus_color",Color.GREEN)
		%CheckBox.set("theme_override_colors/font_hover_color",Color.GREEN)
		%CheckBox.set("theme_override_colors/font_hover_pressed_color",Color.GREEN)
	if len(%Password.text) > 0:
		%Button.visible = true
	else:
		%Button.visible = false
		
	if Input.is_action_just_pressed("accept"):
		login()
	
	


func _on_login_pressed():
	login()

func login():
	var email = %Email.text 
	var password = %Password.text
	Firebase.Auth.login_with_email_and_password(email, password)
	%StateLabel.visible = true
	%StateLabel.text = "Logging in"


func _on_register_pressed():
	var email = %Email.text 
	var password = %Password.text
	Firebase.Auth.signup_with_email_and_password(email, password)
	%StateLabel.visible = true
	%StateLabel.text = "Signing up"


func on_login_succeeded(auth):
	#print(auth)
	%ToastTimer.start()
	%StateLabel.visible = true
	%StateLabel.text = "Login Success!"
	if stay:
		Firebase.Auth.save_auth(auth)
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
	
func on_signup_succeeded(auth):
	#print(auth)
	%ToastTimer.start()
	%StateLabel.visible = true
	%StateLabel.text = "Signup Success!"
	if stay:
		Firebase.Auth.save_auth(auth)
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
	
func on_login_failed(error_code, message):
	#print(error_code)
	#print(message)
	%ToastTimer.start()
	%StateLabel.visible = true
	%StateLabel.text = "Login failed. Error: %s" % message
	
func on_signup_failed(error_code, message):
	#print(error_code)
	#print(message)
	%ToastTimer.start()
	%StateLabel.visible = true
	%StateLabel.text = "Signup failed. Error: %s" % message


func _on_check_box_pressed():
	stay = not stay


func _on_button_pressed():
	%Password.secret = not %Password.secret
	if %Password.secret:
		%Button.text = "SHOW"
	else:
		%Button.text = "HIDE"


func _on_toast_timer_timeout():
	%StateLabel.visible = false
