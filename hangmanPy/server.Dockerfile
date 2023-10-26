FROM python:3.11
WORKDIR /usr/local/src/
COPY server.py /usr/local/src/server.py
COPY words.txt /usr/local/src/words.txt
CMD [ "python", "-u", "server.py" ]
