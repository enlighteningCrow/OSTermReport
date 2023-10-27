package hangman;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.Random;
import java.util.TreeSet;

public class Server {
    ArrayList<String> words;
    ServerSocket socket;

    static class Responder extends Thread {

        Socket conn;
        DataOutputStream out;
        String word;

        Responder(Socket connection, String wd) throws IOException {
            word = wd;
            conn = connection;
            out = new DataOutputStream(conn.getOutputStream());
        }

        @Override
        public void run() {
            try {
                out.writeInt(word.length());
                out.write(word.getBytes());
                out.close();
                conn.close();
            } catch (IOException e) {
                System.err.println("Unable to write to client.");
            }
        }
    }

    Server() throws IOException, URISyntaxException {
        socket = new ServerSocket(1943);
        words = (ArrayList<String>) Files
                .readAllLines(Paths.get(getClass().getClassLoader().getResource("words.txt").toURI()));
    }

    Socket sock;
    int size = 1;
    TreeSet<Character> all_characters = new TreeSet<Character>();
    DataInputStream in;

    public static void main(String[] args) throws IOException, URISyntaxException {
        Server server = new Server();
        while (true) {
            System.out.println("Waiting for client to connect.");
            Socket connection = server.socket.accept();
            Random random = new Random();
            String word = server.words.get(random.nextInt(server.words.size()));
            Responder responder = new Responder(connection, word);
            responder.start();
        }
    }
}
