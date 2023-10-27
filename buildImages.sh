# This is the script to build all the docker images

docker build --tag hangman_py_server --no-cache -f hangmanPy/server.Dockerfile ./hangmanPy/
docker build --tag hangman_py_client --no-cache -f hangmanPy/client.Dockerfile ./hangmanPy/
gradle build -p ./hangmanJava/
docker build --tag hangman_java_server --no-cache -f hangmanJava/server.Dockerfile ./hangmanJava/
docker build --tag hangman_java_client --no-cache -f hangmanJava/client.Dockerfile ./hangmanJava/
