import spacy
nlp = spacy.load('en_core_web_md')

import os

workingDir = os.getcwd()
print("current working directory: " + workingDir)

# os.listdir lists files and folders inside a path:
insideDir = os.listdir(workingDir)
print("inside this directory are the following files AND directories: " + str(insideDir))

# use os.path.join to connect the subdirectory to the working directory:
CollPath = os.path.join(workingDir, 'textCollection')
print(CollPath)

chatResults = open('ahopple-chatgpt-results.txt', 'r', encoding="utf8")
otherResults = open('nlpexercise2/ahopple-claude-results.txt')
words = chatResults.read()
wordStrings = str(words)
newWords = otherResults.read()
newStrings = str(newWords)
print(wordStrings)

chatWords = nlp(wordStrings)
claude = nlp(newStrings)
# Here is a list of items and character names, as well as the foods that are mentioned as a part of the recipe.
# It is not perfect, but I am new to Python and spaCy.
print("Characters and Items")
for token in chatWords:
    if token.pos_ == "PROPN":
        print(token.text)
# I originally recycled this line of code to experiment with other spaCy commands.
# I will also use such code for future reference to spaCy. It will take time for me to get used to Python and spaCy.
for token in chatWords:
    print(token.text, ":", token.pos_, ". This word's root is", token.lemma_)

for ent in chatWords.ents:
    print(ent.text, ent.start_char, ent.end_char, ent.label_)

for token in chatWords:
    print(token.text, token.lemma_, token.pos_, token.tag_, token.dep_, token.shape_)

for token in claude:
    if token.pos_ == "PROPN":
        print(token.text)

vectors = chatWords.vector

wordOfInterest = nlp(u'Samus')
print(wordOfInterest, ' : ', wordOfInterest.vector_norm)

wordOfInterest2 = nlp(u'Ridley')
print(wordOfInterest2, ' : ', wordOfInterest2.vector_norm)

wordOfInterest3 = nlp(u'Metroid')
print(wordOfInterest3, ' : ', wordOfInterest3.vector_norm)

highSimilarityDict = {}
for token in chatWords:
    if (token and token.vector_norm):
        # if token not in highSimilarityDict.keys(): Alas, this did not work to remove duplicates from my dictionary
        if wordOfInterest.similarity(token) > .3:
            highSimilarityDict[token] = wordOfInterest.similarity(token)
            # The line above creates the structure for each entry in my dictionary.
            # print(token.text, "about this much similar to", wordOfInterest, ": ", wordOfInterest.similarity(token))
print("This is a dictionary of words most similar to the word " + wordOfInterest.text + " in this file.")
print(highSimilarityDict)

highSimilarityReduced = {}
for key, value in highSimilarityDict.items():
    if value not in highSimilarityReduced.values():
        highSimilarityReduced[key] = value
        print(highSimilarityReduced)
    print(len(highSimilarityReduced.items()), " vs ", len(highSimilarityDict.items()))