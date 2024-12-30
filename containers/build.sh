FOLDER="$(cd -- "$(dirname "$0")" > /dev/null 2>&1; pwd -P)"
echo Folder=$FOLDER

echo Building global base
docker build -t gdscript-live/godot:base $FOLDER/base/

for version in $(ls -d $FOLDER/*/ | grep -e "base-[^\/]*\/$"); do
	echo Building base $version
	docker build -t gdscript-live/godot:$(basename $version) $version
done

for version in $(ls -d $FOLDER/*/ | grep -ve "base\/$" | grep -ve "base-[^\/]*\/$"); do
	echo Building version $version
	docker build -t gdscript-live/godot:$(basename $version) $version
done

for image in $(docker images -f "dangling=true" -q); do
    docker rmi -f $image
done

