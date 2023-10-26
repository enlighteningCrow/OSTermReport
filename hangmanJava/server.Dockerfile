FROM openjdk:21-jdk
RUN mkdir -p /app/hangman/
WORKDIR /app/
COPY app/build/classes/java/main/hangman/Server*.class /app/hangman/
COPY app/build/resources/main/* /app/
CMD [ "java", "hangman.Server" ]
