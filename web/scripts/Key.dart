import 'dart:html';

class Key {
    static Map<int, Key> keys = new Map<int, Key>();
    int keyCode;
    String keyLetter;
    Key(this.keyCode,this.keyLetter) {
        keys[keyCode] = this;
    }

    String toString() {
        return keyLetter;
    }

    static Key getKeyFromCode(int keyCode) {
        if(keys.isEmpty) {
            setup();
        }
        return keys[keyCode];
    }

    static void setup() {
        new Key(KeyCode.A, "A");
        new Key(KeyCode.B, "B");
        new Key(KeyCode.C, "C");
        new Key(KeyCode.D, "D");
        new Key(KeyCode.E, "E");
        new Key(KeyCode.F, "F");
        new Key(KeyCode.G, "G");
        new Key(KeyCode.H, "H");
        new Key(KeyCode.I, "I");
        new Key(KeyCode.J, "J");
        new Key(KeyCode.K, "K");
        new Key(KeyCode.L, "L");
        new Key(KeyCode.M, "M");
        new Key(KeyCode.N, "N");
        new Key(KeyCode.O, "O");
        new Key(KeyCode.P, "P");
        new Key(KeyCode.Q, "Q");
        new Key(KeyCode.R, "R");
        new Key(KeyCode.S, "S");
        new Key(KeyCode.T, "T");
        new Key(KeyCode.U, "U");
        new Key(KeyCode.V, "V");
        new Key(KeyCode.W, "W");
        new Key(KeyCode.X, "X");
        new Key(KeyCode.Y, "Y");
        new Key(KeyCode.Z, "Z");
        new Key(KeyCode.PERIOD, ".");
        new Key(KeyCode.COMMA, ",");
        new Key(KeyCode.QUESTION_MARK, "?");
        new Key(KeyCode.SPACE, " ");
        new Key(KeyCode.ONE, "!");


    }


}