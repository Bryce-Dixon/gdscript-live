# GDScript.Live

Tool for quick GDScript testing and creating proof-of-concept scripts.

Use online now: https://gdscript.live

## Profiling

*Note:* Profiling is only supported for Godot 4 builds. attempting to call `GDScriptLive.profile(...)` for Godot 3 builds will result in an error message.

Using `GDScriptLive.profile(callback: Callable, ierations: int = 10_000)`, you can test the performance of various `Callable`s. This includes lambdas and asynchronous coroutines.

By default, `GDScriptLive.profile(callable)` will execute `callable` 10,000 times. This is done in batches of 1024 iterations per process frame to prevent the application from hanging indefinitely while profiling slower functions.

If you need to clean up anything before the engine closes to avoid errors (eg: free constructed non-`RefCounted` `Object`s), you can connect the signal `GDScriptLive.profiling_done` to your cleanup function(s) which will run after all profiling is complete. Do *not* `await GDScriptLive.profiling_done` as that will cause your script to hang indefinitely (scripts are automatically killed after 30 seconds).
