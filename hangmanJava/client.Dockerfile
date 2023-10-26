FROM openjdk:21-jdk
RUN mkdir -p /app/hangman/
WORKDIR /app/
COPY app/build/classes/java/main/hangman/Client.class /app/hangman/Client.class
CMD [ "java", "hangman.Client" ]
