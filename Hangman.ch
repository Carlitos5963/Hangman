/* File: hangman.c
* Jose Carlos Gomez - JoseCarlosGomez69@gmail.com
* Nick Barding - nbardin92@gmail.com
* Eric Hernandez - Eherny007@yahoo.com
*
* Displays a game of hangman with options on difficulty of word 
*
* This program meets all of the requirements:
* Use a decision (e.g. if-else)
* Use a loop (e.g. for, while)
* Write and use a function that returns a value
* Write and use a function that has a parameter
* Use an array
* Get input from the user or a file
* Print output to the screen or a file
* Use a pointer variable
* Use at least 3 of the 5 features on the Linkbot
*/

#include <stdio.h>
#include <iostream>
#include <linkbot.h>

// Initialize robot
CLinkbotI robot;

// Constants for robot
double radius = 1.75;
double trackwidth = 3.69;

void Gallows(); //prototype method
void game(); //prototype method

int i = 0;

// Array used to hold the letters that have already been guessed
static char guessedLetters[10];
// Loop to fill array with '_' to show the letter hasnt been guessed correctly
for(i = 0; i < 10; i++)
    guessedLetters[i] = '_';

// Pointer to help fill array
char *ch;

ch = guessedLetters;

// Array with easy words
char easy[10][4] = {
    {'m', 'a', 't', 'h'},
    {'c', 'o', 'o', 'l'},
    {'n', 'i', 'c', 'e'},
    {'c', 'a', 'l', 'm'},
    {'j', 'a', 'z', 'z'},
    {'q', 'u', 'i', 'z'},
    {'j', 'u', 'm', 'p'},
    {'c', 'o', 'z', 'y'},
    {'p', 'e', 'r', 'k'},
    {'f', 'u', 'z', 'y'}
};

// Array with medium words
char medium[10][6]={
    {'b','u','z','z','e','d'},
    {'f','i','z','z','l','e'},
    {'q','u','e','a','z','y'},
    {'q','u','a','c','k','y'},
    {'j','i','n','x','e','d'},
    {'h','i','j','a','c','k'},
    {'j','o','y','p','o','p'},
    {'j','u','m','p','e','d'},
    {'e','n','z','y','m','e'},
    {'f','r','e','n','z','y'}};

// Array with hard words
char hard[10][10]={
    {'b','l','a','c','k','j','a','c','k','s'},
    {'z','y','g','o','m','o','r','p','h','y'},
    {'p','o','z','z','o','l','a','n','i','c'},
    {'m','e','z','z','a','l','u','n','a','s'},
    {'s','q','u','e','e','z','a','b','l','e'},
    {'c','o','m','p','l','e','x','i','f','y'},
    {'j','a','c','k','r','a','b','b','i','t'},
    {'e','p','o','x','i','d','i','z','e','d'},
    {'c','z','a','r','e','v','i','t','c','h'},
    {'c','i','r','c','u','m','f','l','e','x'}
   };


int main()
{
    int randomInt = rand()%10; // random int to pick word at random
    printMenu();
    selectOption(randomInt);
    return 0;
}

// Method to print the menu options
int printMenu() {
    cout << "Options: \n";
    cout << "A. Exit program \n";
    cout << "B. Play Easy Game \n";
    cout << "C. Play Medium Game \n";
    cout << "D. Play Hard Game \n";
    cout << "Enter choice letter: \n";
    return 1;
}

// Determines if the game is over by guessing all of the correct letters
// If-else decision used within this function
// For loop used
int gameOver(int wordLength){
    int j; // iterates through array to check if all letters have been guessed.
    for(j = 0; j < wordLength; j++)
            if(guessedLetters[j] != '_');
            else  //If-else decision
                return 0;
        return 1;
    }
    

// Used to handle whichever menu option the user chooses   
// Function uses 1 of 3 arrays to pick a word    
int selectOption(int randomInt) {
    char option;
    scanf("%[^\n]%*c", &option);

    // Option to quit the program
    if (option == 'A' || option == 'a') {
        exit(-1);

    }
    // Option for an easier word
    else if (option == 'B' || option == 'b') {
        game(easy[randomInt][], 4);
        cout << "\nNote: You are only allowed to enter one lowercase letter at a time, and to have 6 wrong guesses. Once this hangman diagram is completed, you lose!\n";

    }
    // Option for a word of medium difficulty
    else if (option == 'C' || option == 'c') {
        game(medium[randomInt][], 6);
        cout << "\nNote: You are only allowed to enter one lowercase letter at a time, and to have 6 wrong guesses. Once this hangman diagram is completed, you lose!\n";

    }
    // Option for a word of hard difficulty
    else if (option == 'D' || option == 'd') {
        game(hard[randomInt][], 10);
        cout << "\nNote: You are only allowed to enter one lowercase letter at a time, and to have 6 wrong guesses. Once this hangman diagram is completed, you lose!\n";
    }

    else
        cout << "invalid option";
    return 1;
}

// Method to play the game
// This function takes user input to determine the letter guessed
void game(char answer[], int wordLength)
{
    int i;
    int x = 0; // Used to see which attempt the user is currently in
    int isTrue; // Used for boolean statement

    char letter; // Used to hold the users guess

    while (x <= 6)
    {
        cout << "\n\n\n\n\n\n\n\n\n\n\n\n";
        Gallows(x);
        cout << "_________________________________________________________________\n\n\n";
        
        // This checks to see if the game is over
        if(gameOver(wordLength) == 1){
            robot.setLEDColorRGB(0, 255, 0); //turn LED green
            robot.setBuzzerFrequency(250, .4); //beep
            robot.setBuzzerFrequency(250, .4); //beep
            cout << "Congradulations, you aren't dead!";
            exit(-1);
        }
        
        for(i = 0; i < wordLength; i++)
            cout << " " << guessedLetters[i] << " ";
        cout << "Guess a letter \n";
        // Takes user input here for the letter guessed
        scanf("%[^\n]%*c", &letter);
        int isTrue = 0;


        // If letter is in word, keep going, if not, add 1 to the total attempts
        if (letterCheck(answer[], letter, wordLength, isTrue) == 1)
        {
            robot.setLEDColorRGB(0, 255, 0); //Sets LED color to Green
            robot.setBuzzerFrequency(1000, 1); //Robot creates high frequency pitch
            robot.driveAngle(3); // Robot drives forward a little
            printf(" keep going \n");
        }
        else
        {
            robot.setLEDColorRGB(255, 0, 0); //Sets LED color to Red
            robot.setBuzzerFrequency(200, 1); //Robot creates low frequency pitch
            robot.driveAngle(-3); // Robot drives backwards a little
            printf("Try again\n");
            x++;
            //If 6 attempts have been used, game over.
            if (x == 6) {
                Gallows(x);
                // Print out the word if they failed to guess it.
                cout << "\n The word was ";
                int h;
                for (h = 0; h < wordLength; h++)
                    cout << answer[h];
                cout << "\n";
                
                robot.setBuzzerFrequency(200, 5); //Robot creates low frequency pitch
                cout << "Game Over!\n";
                exit(0);
            }
        }
    }
}

// Method used to check if letter guessed is in the answer
// Function returns a value of 1 or 0 (true or false)
// Function also uses a pointer to fill array
int letterCheck(char answer[], char letter, int wordLength, int isTrue) {
    int i = 0;
    int y;
    for (i = 0; i < wordLength; ++i) {
        if (letter == answer[i]){
            isTrue = 1;
            y++;
            // Pointer used to enter the letter into the array of letters already guessed correctly
            *(ch + i) = letter;
            
        }
    }
    if(y ==1)
        cout << y << " " << letter << " found, ";
    if(y != 1)
    cout << y << " " << letter << "'s found, ";
    //Return value true or false
    return isTrue;

}


// This methhod prints the gallows and the person hanging on it.
// Function takes parameter for the number of incorrect guesses taken so far
// This prints the gallows picture to the screen
void Gallows(int wrongGuesses)
{
    cout << "\nYou have " << 6 - wrongGuesses << " guesses left! \n";
    if (wrongGuesses > 5)
        cout << "Game Over!";
    printf("_________ \n");
    printf("|      | \n");

    if (wrongGuesses >= 1)
        printf("|      0 \n");
    else
        printf("| \n");

    if (wrongGuesses == 2 || wrongGuesses <= 4)
        printf("|      | \n");
    else if (wrongGuesses == 5)
        printf("|     /| \n");
    else if (wrongGuesses >= 6)
        printf("|     /|\\     Nice job, murderer \n");
    else
        printf("| \n");

    if (wrongGuesses == 3)
        printf("|      / \n");
    else if (wrongGuesses >= 4)
        printf("|     / \\ \n");
    else
        printf("| \n");

    printf("| \n");
    printf("| \n");
    printf("--------- \n\n");
}
