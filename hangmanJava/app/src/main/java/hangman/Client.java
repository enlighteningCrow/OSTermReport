package hangman;

import java.io.DataInputStream;
import java.io.IOException;
import java.net.Socket;
import java.util.Scanner;
import java.util.TreeSet;

public class Client implements AutoCloseable {
  void display(String st, int atmptR) {
    System.out.println(st + " you have " + atmptR + " attempts left.");
  }

  Client() throws IOException {
    for (char c = 'a'; c <= 'z'; ++c)
      all_characters.add(c);
  }

  Socket sock;
  int size = 1;
  TreeSet<Character> all_characters = new TreeSet<Character>();
  DataInputStream in;
  Scanner sc = new Scanner(System.in);

  void Main() throws IOException {
    TreeSet<Character> remaining_characters = new TreeSet<Character>(all_characters);
    int attempts = 10;
    boolean success = false;
    sock = new Socket("hangmanServer", 1943);
    in = new DataInputStream(sock.getInputStream());
    int len = in.readInt();
    byte[] b = new byte[len];
    int res = in.readNBytes(b, 0, len);
    assert (res == len);
    in.close();
    sock.close();
    String s = new String(b);
    StringBuffer c = new StringBuffer("-".repeat(len));

    while (attempts > 0) {
      display(c.toString(), attempts);
      System.out.print("Your next Guess: ");
      Character e = Character.toLowerCase(sc.next().charAt(0));
      assert (c.length() == s.length());

      if (!all_characters.contains(e)) {
        System.out.println("Please enter a valid English character.");
        continue;
      }
      if (!remaining_characters.contains(e)) {
        System.out.println("You have already tried the letter " + e + ".");
        continue;
      }
      boolean matched = false;
      for (int i = 0; i < s.length(); ++i)
        if (s.charAt(i) == e) {
          matched = true;
          assert (c.charAt(i) == '-');
          c.replace(i, i + 1, e.toString());
        }
      remaining_characters.remove(e);
      if (matched) {
        if (c.toString().indexOf('-') == -1) {
          success = true;
          break;
        }
      } else
        attempts -= 1;
    }
    if (success)
      System.out.println("You won.\nThe word is \"" + s + "\" and you have " + attempts + " attempts left.");
    else
      System.out.println("You lost.\nThe word is \"" + s + "\".");
  }

  @Override
  public void close() {
    sc.close();
  }

  public static void main(String[] args) {
    try (Client client = new Client()) {
      client.Main();
    } catch (IOException e) {
      System.err.println("Error connecting to the server. See stack trace below:");
      e.printStackTrace();
    }
  }
}
