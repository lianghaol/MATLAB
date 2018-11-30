from nltk.stem.wordnet import WordNetLemmatizer
import math
lmtzr = WordNetLemmatizer()

num_features = 1000
freq_w = 1

f = open('vocabulary.txt', 'r+')
words = f.read().replace('\n', '').split()
lemmas = {}
for i in range(0, len(words)):
	word = words[i]
	try:
		lemma = lmtzr.lemmatize(word)
		if lemma in lemmas:
			lemmas[lemma].append(i)
		else:
			lemmas[lemma] = [i]
	except:
		if word in lemmas:
			lemmas[word].append(i)
		else:
			lemmas[word] = [i]

lemmas = lemmas.items()
rev_lemmas = {}
for i in range(0, len(lemmas)):
	for val in lemmas[i][1]:
		rev_lemmas[val] = i


lines2 = map(int, open('data/Y_train.txt').read().replace('\n', ' ').split())
lines1 = open('data/X_train.txt', 'r+').readlines()
lemma_count = {i:0 for i in range(len(lemmas))}
lemma_vals = {i:[] for i in range(len(lemmas))}
lemma_uses = {i:[] for i in range(len(lemmas))}
rows = set()
for line in lines1:
	[row, col, val] = map(int, line.replace('\n', '').split())

	lemma_count[rev_lemmas[row - 1]] += 1
	lemma_uses[rev_lemmas[row - 1]].append(col)
	lemma_vals[rev_lemmas[row - 1]].append((val, lines2[col - 1]))


lemma_vals = {i:[j[1] for j in lemma_vals[i]] for i in lemma_vals}

used_lemmas = filter(lambda i: lemma_count[i] > 4, lemma_count.keys())

def entropy(xs):
	count = {i:xs.count(i) for i in range(1,6)}
	entropy = 0.0
	for var in count:
		if count[var] != 0:
			p = count[var]/(len(xs) + 0.0)
			entropy += p*math.log(p)
	return entropy

entropies = {i:entropy(lemma_vals[i]) for i in lemma_vals}
entropies = {i:entropies[i]/min(entropies.values())*-1 for i in lemma_vals}

frequencies = {i:len(lemma_vals[i]) for i in lemma_vals}
frequencies = {i:(frequencies[i] + 0.0)/max(frequencies.values()) for i in lemma_vals}

scores = {i:entropies[i] + freq_w*frequencies[i] for i in lemma_vals}

scores = sorted(scores.items(), key = lambda i: i[1], reverse = True)

just_lemmas = [i[0] for i in lemmas]
for lemma_num, score in scores:
	lemma = just_lemmas[lemma_num]


useful_lemmas = [i[0] for i in sorted(scores, key = lambda i:i[1], reverse = True)[:num_features]]

y4 = [just_lemmas[i] for i in useful_lemmas]


new_val = {i+1:useful_lemmas[i] for i in range(0, len(useful_lemmas))}

new_vals = {v:k for k,v in new_val.items()}

feature_num = []
for i in range(10000):
	if rev_lemmas[i] in useful_lemmas:
		feature_num.append(new_vals[rev_lemmas[i]])
	else:
		feature_num.append(0)




f = open('include/most_useful_words.csv', 'w+')
f.write('\n'.join(map(str, feature_num)))
f.close()
