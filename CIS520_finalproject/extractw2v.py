from sklearn.cluster import KMeans
from nltk.stem.wordnet import WordNetLemmatizer
import numpy as np

lmtzr = WordNetLemmatizer()

f = open('vocabulary.txt')
words = f.readlines()[0].split(' ')
f.close()

lemmas = []
for word in words:
	try:
		lemmas.append(lmtzr.lemmatize(word))
	except:
		lemmas.append(word)

lemma_to_words = {}
for lemma in lemmas:
	lemma_to_words[lemma] = [words[i] for i in range(0, len(words)) if lemmas[i] == lemma]

f = open('glove.6B.50d.txt')
lines = f.readlines()
f.close

lemma_vecs = []
lemma_keys = []

for line in lines:
	toks = line.replace('\n', '').split(' ')
	word = toks[0]
	vec = np.array([float(i) for i in toks[1:]])
	if word in lemmas:
		lemma_keys.append(word)
		lemma_vecs.append(vec)

X = np.array(lemma_vecs)

labels = list(KMeans(n_clusters=100, random_state=0).fit(X).labels_) + [100]

new_labels = []

for i in range(0, len(words)):
	lemma = lemmas[i]
	if lemma in lemma_keys:
		new_labels.append(labels[lemma_keys.index(lemma)])
	elif lemma.isdigit():
		new_labels.append(100)
	else:
		new_labels.append(max(labels) + 1)
		labels.append(max(labels) + 1)

f = open('new_labels.csv', 'w+')
f.write(' ,'.join(map(str, new_labels)))