FROM openjdk:18.0.2
RUN mkdir -p /app/hangman/
WORKDIR /app/
COPY app/bin/main/hangman/Client.class /app/hangman/Client.class
COPY app/bin/main/hangman/Server.class /app/hangman/Server.class
COPY app/bin/main/hangman/Server\$Responder.class /app/hangman/Server\$Responder.class
COPY app/bin/main/words.txt /app/words.txt
CMD [ "java", "hangman/Server" ]
