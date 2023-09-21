import socket
import struct
from typing import List

sAddress = ('127.0.0.1', 1943)

sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
size = struct.calcsize('c')

def display(st : List[str], atmptR : int ):
    print((f"%s you have {atmptR} left")% ''.join(st))

all_characters = {chr(i) for i in range(ord('a'), ord('z') + 1)}
    
def main():
    remaining_characters = all_characters.copy()
    success = False
    sock.connect_ex(sAddress)
    wordLenB = sock.recv(struct.calcsize('!i'), socket.MSG_WAITALL)
    wordLen, = struct.unpack('!i', wordLenB)

    wordB = sock.recv(wordLen)

    word = wordB.decode('ascii')

    sock.close()

    attempts = 10

    st = ['-' for _ in range( wordLen)]
    while attempts > 0:
        display(st, attempts)
        dataChar = input('Your next Guess: ')
        if len(dataChar) != 1:
            print("Please enter only 1 character.")
            continue
        if dataChar not in all_characters:
            print("Please enter a valid English character.")
            continue
        elif dataChar not in remaining_characters:
            print(f"You have already tried the letter {dataChar}")
            continue
        else:
            remaining_characters.remove(dataChar)
            li = []
            for i in range(len(word)):
                if word[i] == dataChar:
                    li.append(i)
            if len(li) > 0:
                for i in li:
                    st[i] = dataChar
                if st.count('-') <= 0:
                    success = True
                    break
            else:
                attempts -= 1

    if success:
        print(f"You won.\nThe word is {word} and you have {attempts} attempts left")
    else:
        print(f"You lost.\nThe word is {word}")

main()
