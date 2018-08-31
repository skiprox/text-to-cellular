byte[] lines;
CA ca;   // An instance object to describe the Wolfram basic Cellular Automata
int counter = 0;
byte[] manifesto;
int[][] manifestoBytes;
color bg = color(255);

void setup() {
	// This loads the text file, prints it in binary
	loadFile();
	size(800, 600);
	// An initial rule system
	int[] ruleset = {0,1,1,0,1,1,1,0};
	// Initialize CA
	ca = new CA(ruleset, manifestoBytes[counter]);
	counter++;
	background(bg);
}

void loadFile() {
	manifesto = loadBytes("manifesto.txt");
	manifestoBytes = new int[manifesto.length][32];
	for (int i = 0; i < manifesto.length; i++) {
		int a = manifesto[i] & 0xff;
		String line = binary(a) + "";
		String[] lineArray = line.split("");
		int[] numberArray = new int[lineArray.length];
		for (int j = 0; j < lineArray.length; j++) {
			int byteNumber = Integer.parseInt(lineArray[j]);
			numberArray[j] = byteNumber;
			manifestoBytes[i][j] = byteNumber;
		}
	}
}

void draw() {
	// Draw the CA
	ca.render();
	// Generate the next level
	ca.generate();
	// If we're done, clear the screen, pick a new ruleset and restart
	if (ca.finished()) {
		if (counter >= manifesto.length) {
			exit();
		} else {
			saveFrame("screenshots/screen-" + counter + ".png");
			background(bg);
			ca.randomize();
			ca.restart(manifestoBytes[counter]);
			counter++;
		}
	}
}