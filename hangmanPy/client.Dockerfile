FROM python:3.11
WORKDIR /usr/local/src/
COPY client.py /usr/local/src/client.py
CMD [ "python", "-u", "client.py" ]
