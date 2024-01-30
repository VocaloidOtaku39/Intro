import spacy

nlp = spacy.load('en_core_web_sm')

chatResults = open('ahopple-chatgpt-results.txt', 'r', encoding="utf8")
words = chatResults.read()
wordStrings = str(words)
print(wordStrings)

chatWords = nlp(wordStrings)

print("Characters and Items")
for token in chatWords:
    if token.pos_ == "PROPN":
        print(token.text)

for token in chatWords:
    print(token.text, "---->", token.pos_, ":::::", token.lemma_)