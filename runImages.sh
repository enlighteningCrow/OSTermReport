#Do not run this file. This is a collection of commands to run the clients and servers in docker and natively.
#Use this by copying one command into the terminal manually.

#Use this command before running the first four commands below to create the hangman network.
docker network create hangman

#Use this command to run the python server docker image to connect to clients running in other docker containers.
docker run --rm --net hangman --name hangmanServer hangman_py_server:latest

#Use this command to run the python client docker image to connect to a server running in another docker container.
docker run --rm --net hangman --name hangmanClient --interactive hangman_py_client:latest

#Use this command to run the java server docker image to connect to clients running in other docker containers.
docker run --rm --net hangman --name hangmanServer hangman_java_server:latest

#Use this command to run the java client docker image to connect to a server running in another docker container.
docker run --rm --net hangman --name hangmanClient --interactive hangman_java_client:latest

#Use this command to run the python server docker image to connect to clients running natively on the machine.
docker run --rm --name hangmanServer -p 1943:1943 hangman_py_server:latest

#Use this command to run the java server docker image to connect to clients running natively on the machine.
docker run --rm --name hangmanServer -p 1943:1943 hangman_java_server:latest

#Use this command to run the python server natively
cd $(git rev-parse --show-toplevel)/hangmanPy/;python server.py

#Use this command to run the python client natively
cd $(git rev-parse --show-toplevel)/hangmanPy/;python clientNative.py

#Use this command to run the java server natively
cd $(git rev-parse --show-toplevel)/hangmanJava/;gradle run

#Use this command to run the java client natively
cd $(git rev-parse --show-toplevel)/hangmanJava/app/build/classes/java/main;java hangman.ClientNative
