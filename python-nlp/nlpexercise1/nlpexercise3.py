import spacy
import os, shutil
from dicttoxml import dicttoxml
from xml.dom.minidom import parseString
nlp = spacy.load('en_core_web_md')

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
        words = f.read()
        wordstrings = str(words)
        lengthStrings = len(words)
        print(wordstrings)

        chatwords = nlp(wordstrings)

        vectors = chatwords.vector

        wordofinterest = nlp(u'Ridley')
        print(wordofinterest, ' : ', wordofinterest.vector_norm)

        highSimilarityDict = {}
        for token in chatwords:
            if (token and token.vector_norm):
                if wordofinterest.similarity(token) > .3:
                    highSimilarityDict[token] = wordofinterest.similarity(token)
            # The line above creates the structure for each entry in my dictionary.
            # print(token.text, "about this much similar to", wordOfInterest, ": ", wordOfInterest.similarity(token))
        print("This is a dictionary of words most similar to the word " + wordofinterest.text + " in this file.")
        print(highSimilarityDict)

        switcheroo = {val: key for key, val in highSimilarityDict.items()}
        deduped = {val: key for key, val in switcheroo.items()}
        print(str(len(switcheroo)) + f'{switcheroo=}')

        print(len(deduped), f'{deduped=}')
        print(len(deduped.items()), " vs ", len(highSimilarityDict.items()))

        highSimilarityReduced = {}
        for key, value in highSimilarityDict.items():
            if value not in highSimilarityReduced.values():
                highSimilarityReduced[key] = value
        print(highSimilarityReduced)
        print(len(highSimilarityReduced.items()), " vs ", len(highSimilarityDict.items()))

        sortedSimValues = sorted(deduped.items(), key=lambda x: x[1], reverse=True)
        print(type(sortedSimValues), f'{sortedSimValues=}')
        # HEY, that's not a dictionary! It's a list. Let's convert it back to a dictionary.

        sortedSimDict = dict(sortedSimValues)
        print(type(sortedSimValues), f'{sortedSimValues=}')

        return sortedSimDict



# HEY, that's not a dictionary! It's a list. Let's convert it back to a dictionary.
with open('similarity.txt', 'a', encoding='utf8') as f:
    for file in sorted(os.listdir(CollPath)):
        # My filenames are numbered, so I controlled the order of the for loop by sorting them.
        if file.endswith(".txt"):
            filepath = f"{CollPath}/{file}"
            print(filepath)
            similarityData = readTextFiles(filepath)

            # LET'S WRITE OUR DICTIONARY TO A NICE TEXT OUTPUT FILE WHILE WE'RE WORKING ON FILE INPUTS / OUTPUTS!
            f.write(filepath + '\n')
            f.write(str(similarityData) + '\n\n')
if os.path.exists("xml-output"):
    shutil.rmtree("xml-output")

os.mkdir('xml-output')

for file in sorted(os.listdir(CollPath)):
    # My filenames are numbered, so I controlled the order of the for loop by sorting them.
    if file.endswith(".txt"):
        filepath = f"{CollPath}/{file}"
        print(filepath)
        filenameTxt = os.path.basename(filepath).split('/')[-1]
        filename = filenameTxt[:-4]
        print(filename)
        similarityData = readTextFiles(filepath)

        xml = dicttoxml(similarityData)
        dom = parseString(xml)
        # dom is just a string. We can pretty print it in the console,
        # but this is not good for writing to an XML file.
        print(dom.toprettyxml())
        with open(f'xml-output/{filename}.xml', 'w') as xmlFile:
            xml_decode = xml.decode()
            xmlFile.write(xml_decode)
            xmlFile.close()