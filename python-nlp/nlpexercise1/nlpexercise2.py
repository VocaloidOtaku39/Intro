import spacy
nlp = spacy.load('en_core_web_md')

import os

workingDir = os.getcwd()
print("current working directory: " + workingDir)

# os.listdir lists files and folders inside a path:
insideDir = os.listdir(workingDir)
print("inside this directory are the following files AND directories: " + str(insideDir))

# use os.path.join to connect the subdirectory to the working directory:
CollPath = os.path.join(workingDir, 'nlpexercise2')
print(f'{CollPath=}')

def readTextFiles(filepath):
    with open(filepath, 'r', encoding='utf8') as f:
        chatresults = open('ahopple-chatgpt-results.txt', 'r', encoding="utf8")
        otherresults = open('nlpexercise2/ahopple-claude-results.txt')
        words = chatresults.read()
        wordstrings = str(words)
        newwords = otherresults.read()
        newstrings = str(newwords)
        print(wordstrings)

        chatwords = nlp(wordstrings)
        claude = nlp(newstrings)

        vectors = chatwords.vector

        wordofinterest = nlp(u'Samus')
        print(wordofinterest, ' : ', wordofinterest.vector_norm)

        wordofinterest2 = nlp(u'Ridley')
        print(wordofinterest2, ' : ', wordofinterest2.vector_norm)

        wordOfInterest3 = nlp(u'Metroid')
        print(wordOfInterest3, ' : ', wordOfInterest3.vector_norm)

        highSimilarityDict = {}
        for token in chatwords:
            if (token and token.vector_norm):
                if wordofinterest.similarity(token) > .3:
                    highSimilarityDict[token] = wordofinterest.similarity(token)
            # The line above creates the structure for each entry in my dictionary.
            # print(token.text, "about this much similar to", wordOfInterest, ": ", wordOfInterest.similarity(token))
        print("This is a dictionary of words most similar to the word " + wordofinterest.text + " in this file.")
        print(highSimilarityDict)

        highSimilarityReduced = {}
        for key, value in highSimilarityDict.items():
            if value not in highSimilarityReduced.values():
                highSimilarityReduced[key] = value
        print(highSimilarityReduced)
        print(len(highSimilarityReduced.items()), " vs ", len(highSimilarityDict.items()))

        switcheroo = {val: key for key, val in highSimilarityDict.items()}
        deduped = {val: key for key, val in switcheroo.items()}
        print(str(len(switcheroo)) + ' **** ' + f'{switcheroo=}')

        print(len(deduped), ' **** ', f'{deduped=}')
        print(len(deduped.items()), " vs ", len(highSimilarityDict.items()))

# ********* SORTING THE VALUES ************
# The sorted() function pull the dictionary items out and sorts by value.
# We set reverse=True so that highest similarity values come out first.

        sortedSimValues = sorted(deduped.items(), key=lambda x: x[1], reverse=True)
        print(type(sortedSimValues), f'{sortedSimValues=}')
        sortedSimDict = dict(sortedSimValues)
        print(type(sortedSimValues), f'{sortedSimValues=}')
        return sortedSimDict
# HEY, that's not a dictionary! It's a list. Let's convert it back to a dictionary.
# ebb: This controls our file handling as a for loop over the directory:
for file in os.listdir(CollPath):
    if file.endswith(".txt"):
        filepath = f"{CollPath}/{file}"
        print(filepath)
        readTextFiles(filepath)