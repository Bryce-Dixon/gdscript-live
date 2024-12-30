extends SceneTree

func get_options() -> Dictionary:
  var options := {}
  var args := OS.get_cmdline_args()
  for i in range(args.size()):
    var equal_index := args[i].find("=")
    if equal_index != -1:
      options[args[i].substr(0, equal_index)] = args[i].substr(equal_index, args[i].length() - equal_index)
    else:
      options[args[i]] = null
  return options

func profile(_callable, _iterations := 10_000):
  printerr("Profiling is not supported for this version of Godot")

var initialized := false
func _initialize():
  var user_script := load("/mnt/user/script.gd") as GDScript
  if not user_script:
    push_error("Missing user script file!")
    quit()
    return
  var script_instance = user_script.new()
  if not script_instance:
    push_error("Failed to make instance of user script")
    quit()
    return
  var options := get_options()
  var entrypoint: String = options.get("entrypoint", "main")
  if not script_instance.has_method(entrypoint):
    push_error("User script has no entrypoint: " + entrypoint)
    quit()
    return
  initialized = true
  var user_return = script_instance.call(entrypoint)
  if user_return is GDScriptFunctionState:
    user_return = user_return.resume()
  if user_return != null:
    print("Returned: ", user_return)
  emit_signal("profiling_done")
  var profile_results_file := File.new()
  if profile_results_file.open("/mnt/user/profiler", File.WRITE) != OK or not profile_results_file.is_open():
    push_error("Failed to open profile results file for write")
  else:
    profile_results_file.store_string("[]")
    profile_results_file.close()
  
  quit()

func _process(_delta):
  if not initialized:
    push_error("_initialize() failed to complete")
    quit()

signal profiling_done

