FROM gdscript-live/godot:base-4.x
COPY . .
RUN curl https://github.com/godotengine/godot-builds/releases/download/4.4-dev1/Godot_v4.4-dev1_linux.x86_64.zip -Lo /app/godot.zip
RUN unzip /app/godot.zip
RUN rm /app/godot.zip
RUN mv /app/Godot* /app/godot
CMD ["./godot", "--script", "bootstrap.gd", "--headless"]

