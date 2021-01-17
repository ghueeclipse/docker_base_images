docker run -d \
  --net=host \
  -v /local_directory_for_your_medias:/media \
  -e MINIDLNA_MEDIA_DIR=V,/media \
  -e MINIDLNA_FRIENDLY_NAME="Petit Serveur de la maison" \
  --name minidlna \
  minidlnagh:latest
