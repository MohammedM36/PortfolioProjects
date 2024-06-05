#!/usr/bin/env python
# coding: utf-8

# In[ ]:





# In[2]:


import random
import time


# In[3]:


print("\nWelcome to Hangman game by Fouad\n")
name = input('Enter your name: ')
print('Hello ' + name + '\n! Best of Luck!')
time.sleep(2)
print("The game is about to start!\nLet's play Hangman!")
time.sleep(3)


# In[4]:


def main() :
    global count
    global display
    global word
    global already_guessed
    global length
    global play_game
    words_to_guess = ['karanarjun','dabangg','wanted','sultan','jawan','hellobrother','welcome','ready','ddlj','pathan','welcome']
    word = random.choice(words_to_guess)
    length = len(word)
    count = 0
    display = '_' * length
    already_guessed = []
    play_game = ''


# In[5]:


def play_loop():
    global play_game
    play_game = input('Do you want to play again ? y = yes, n = no \n')
    while play_game not in ["y","n","Y","N"]:
        play_game = input('Do you want to play again ? y = yes, n = no \n')
    if play_game == "y":
        main()
    elif play_game == "n":
        print("Thanks for playing! We expect you back again!")
        exit()


# In[ ]:


def hangman():
    global count
    global display
    global word
    global already_guessed
    global play_game
    limit = 8
    guess = input("This is the  word: " + display + "Enter your guess: \n")
    guess = guess.strip()
    if len(guess.strip()) == 0 or len(guess.strip()) >= 2 or guess <= "9":
        print("Invalid input, Try a letter\n")
        hangman()
    
    elif guess in word: 
        already_guessed.extend([guess])
        indices = [i for i, letter in enumerate(word) if letter == guess]
        for index in indices:
            word = word[:index] + "_" + word[index + 1:]
            display = display[:index] + guess +  display[index + 1:]
        print(display + "\n")

    elif guess in already_guessed:
        print("Try another letter.\n")
    
    else:
        count += 1
    
        if count == 1:
            time.sleep(1)
            print("  _____ \n"
                    " |      \n"
                    " |      \n"
                    " |      \n"
                    " |      \n"
                    " |      \n"
                    " |      \n"
                    "_|_\n")
            print("Wrong guess. " + str(limit - count) + " guesses remaining\n")
    
        elif count == 2:
            time.sleep(1)
            print("  _____ \n"
                    " |     | \n"
                    " |      \n"
                    " |      \n"
                    " |      \n"
                    " |      \n"
                    " |      \n"
                    "_|_\n")
            print("Wrong guess. " + str(limit - count) + " guesses remaining\n")
        
        elif count == 3:
            time.sleep(1)
            print("  _____ \n"
                    " |     | \n"
                    " |     O\n"
                    " |      \n"
                    " |      \n"
                    " |      \n"
                    " |      \n"
                    "_|_\n")
            print("Wrong guess. " + str(limit - count) + " guesses remaining\n")
        
        elif count == 4:
            time.sleep(1)
            print("  _____ \n"
                    " |     | \n"
                    " |     O \n"
                    " |     | \n"
                    " |      \n"
                    " |      \n"
                    " |      \n"
                    "_|_\n")
            print("Wrong guess. " + str(limit - count) + " guesses remaining\n")
        
        elif count == 5:
            time.sleep(1)
            print("  _____ \n"
                    " |     | \n"
                    " |     O \n"
                    " |     |\ \n"
                    " |      \n"
                    " |      \n"
                    " |      \n"
                    "_|_\n")
            print("Wrong guess. " + str(limit - count) + " guesses remaining\n")
        
        elif count == 6:
            time.sleep(1)
            print("  _____ \n"
                    " |     | \n"
                    " |     O \n"
                    " |    /|\ \n"
                    " |      \n"
                    " |      \n"
                    " |      \n"
                    "_|_\n")
            print("Wrong guess. " + str(limit - count) + " guesses remaining\n")
        
        elif count == 7:
            time.sleep(1)
            print("  _____ \n"
                    " |     | \n"
                    " |     O \n"
                    " |    /|\  \n"
                    " |      \ \n"
                    " |      \n"
                    " |      \n"
                    "_|_\n")
            print("Wrong guess. " + str(limit - count) + " last guess remaining\n")
        
        elif count == 8:
            time.sleep(1)
            print("  _____ \n"
                    " |     | \n"
                    " |     O \n"
                    " |    /|\  \n"
                    " |    / \ \n"
                    " |      \n"
                    " |      \n"
                    "_|_\n")
            print("Wrong guess.  You are hanged!!!\n")
            print("The word was: ",already_guessed,word)
            play_loop()
        
    if word == '_' * length:
        print("Congrats! You have guessed the word correctly!")
        play_loop()
        
    elif count != limit:
        hangman()
        
        
main()

hangman()


# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:




