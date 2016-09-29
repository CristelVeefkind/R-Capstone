Next Word Prediction App
========================================================
author: Kolesnikov Sergey
date: 29.09.2016
autosize: true

### COURSERA - Data Science Specialization Capstone.

### APP LINKS:

* [Next Word Prediction Shiny App](https://scitator.shinyapps.io/NextWordPredictionApp/)
* [GitHub url](https://github.com/Scitator/R-Capstone)

1. Introduction
========================================================

Natural Language Processing or
[NLP](https://en.wikipedia.org/wiki/Natural_language_processing)
is a field of computer science with the interaction between computers and human
languages.
One on the oldest NLP problem related with computer word prediction is
[Claude Shannon's](https://en.wikipedia.org/wiki/Claude_Shannon)
problem of assigning a probability to a word, _Shannon_ used
[n-grams](https://en.wikipedia.org/wiki/N-gram),
defined as a contiguous sequence of `n` items, from a given sequence of text or
speech, to compute probabilities of English sentences.

Markov assumption states that the probability of a word depends only on
the most recent $n-1$ tokens, thus `n-grams` can be used to predict next word
probability. 

***

In a given text or corpus the conditional probability of seen a word $w_n$ using
_Maximum Likelihood Estimation_ (MLE) is:

$$P(w_n | w_1...w_{n-1}) = \frac{c(w_1...w_n)}{c(w_1...w_{n-1})}$$

There are several smoothing algorithms that uses precomputed probabilities
and back-off weights, the _Stupid Backoff_ method is suitable for web applications
and does not calculates normalized probabilities but relative frequencies.

2. Text Preprocess and n-grams
========================================================
### 2.1 DATA:

The dataset for this word prediction app was gathered from three sources:

* Blogs
* News
* Twitter

The original english corpus combined over 580 MB of language information. Which summed up to over half a billion characters. After processing the data our model consists out of **millions of ngram tokens**.

Data was preprocessed and tokenized with *quanteda* library.

***

### 2.2 N-GRAMS

All `n-grams` tables have four columns: 
- `sentence`
- `prediction`
- `frequency` (from corpus statistics)
- `probability` (from mle model)

### 2.3 DICTIONARY

`N-gram` tables are parsed with dictionary [cracklib-small](https://github.com/cracklib/cracklib/blob/master/src/dicts/cracklib-small). Words not in the dictionary are sustituted by `UNK`. This step compacts `n-gram` tables and improve app
speed. All `n-gram` table with `UNK` in predicted column are deleted.


3. Algorithm
========================================================

Predicted word is found using a simplified version of
[Stupid Backoff algorithm](https://lagunita.stanford.edu/c4x/Engineering/CS-224N/asset/slp4.pdf),
where probabilities are not calculated, but the more frequent `n-gram` of higher
order found, is used for prediction.

If no `n-gram` is found prediction function
returns the most probable unigram: `the`.

***

For additional prediction accuracy were also used:
- Good-Turing Smoothing
- MLE
- linear-regression
- linguistic tweaks


4. How it works and future work
========================================================

## How it works

- Enter  your sentence without the final word to be predicted,
inside `Text Area` that can be found in the `Prediction` tab.
Copy and paste is allowed. The entered sentence is parsed and cleaned and the
predicted word is automatically displayed.

- Press one of `Prediction` button to append predicted word to text area an do further
predictions.

- Press `Clear` to clear the text area.

***

## Future work

Test the code with other languages distict than English. 

Dictionaries of russian, german and finnish are needed but the code has a functional aproach
that must work with these other corpus.


