FROM gdscript-live/godot:base-3.x
COPY . .
RUN curl https://github.com/godotengine/godot-builds/releases/download/3.1.2-stable/Godot_v3.1.2-stable_linux_headless.64.zip -Lo /app/godot.zip
RUN unzip /app/godot.zip
RUN rm /app/godot.zip
RUN mv /app/Godot* /app/godot

