#!/usr/bin/python
import socket
import threading

import struct

from typing import Any
import random

words = []

with open("words.txt", "r") as file:
    words = file.read().splitlines()

sAddress = (socket.gethostbyname(socket.gethostname()), 1943)

sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

sock.bind(sAddress)

sock.listen(1)


def rpd(c: socket.socket, addr: Any, word: str):
    lenWordB = struct.pack("!i", len(word))
    c.sendall(lenWordB)
    c.sendall(bytes(word, "ascii"))


def main():
    while True:
        print("Waiting for client connection.")
        a, b = sock.accept()
        threading.Thread(target=rpd, args=(a, b, random.choice(words))).start()


# print(socket.gethostbyname(socket.gethostname()))
main()
