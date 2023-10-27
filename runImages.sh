#Use this command to run the python server docker image to connect to clients running in other docker containers.
docker run --rm --net hangman --name hangmanServer enlighteningcrow/hangman_py_server:latest

#Use this command to run the python client docker image to connect to a server running in another docker container.
docker run --rm --net hangman --name hangmanClient --interactive enlighteningcrow/hangman_py_client:latest

#Use this command to run the java server docker image to connect to clients running in other docker containers.
docker run --rm --net hangman --name hangmanServer enlighteningcrow/hangman_java_server:latest

#Use this command to run the java client docker image to connect to a server running in another docker container.
docker run --rm --net hangman --name hangmanClient --interactive enlighteningcrow/hangman_java_client:latest

#Use this command to run the python server docker image to connect to clients running natively on the machine.
docker run --rm --name hangmanServer -p 1943:1943 enlighteningcrow/hangman_py_server:latest

#Use this command to run the java server docker image to connect to clients running natively on the machine.
docker run --rm --name hangmanServer -p 1943:1943 enlighteningcrow/hangman_java_server:latest

#Use this command to run the python server natively
cd $(git rev-parse --show-toplevel)/hangmanPy/;python server.py

#Use this command to run the python client natively
cd $(git rev-parse --show-toplevel)/hangmanPy/;python clientNative.py

#Use this command to run the java server natively
cd $(git rev-parse --show-toplevel)/hangmanJava/;gradle run

#Use this command to run the java client natively
cd $(git rev-parse --show-toplevel)/hangmanJava/app/build/classes/java/main;java hangman.ClientNative
