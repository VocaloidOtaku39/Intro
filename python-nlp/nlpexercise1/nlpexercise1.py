import spacy

nlp = spacy.load('en_core_web_sm')

chatResults = open('ahopple-chatgpt-results.txt', 'r', encoding="utf8")
words = chatResults.read()
wordStrings = str(words)
print(wordStrings)

chatWords = nlp(wordStrings)
for token in chatWords:
    # if token.pos_ == "VERB":
    print(token.text, "---->", token.pos_, ":::::", token.lemma_)

