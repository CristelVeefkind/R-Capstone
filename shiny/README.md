# NEXT WORD PREDICTION APP
## Coursera - Data Science Specialization Capstone
* Author:  Kolesnikov Sergey
* Date: 29.09.2016  
* [Email](mailto:scitator@gmail.com)  
* [GitHub url](https://github.com/Scitator/R-Capstone)
* [Presentation url](http://rpubs.com/Scitator/NextWordPredictionApp)

## Coursera Data Science Capstone Project
The Coursera Data Science Specialization Capstone project from Johns Hopkins University (JHU) allows 
students to create a usable public data product that can show their skills to potential 
employers. Projects are drawn from real-world problems and are conducted with industry, government, 
and academic partners. In this part of course JHU is partnering with SwiftKey 
(https://swiftkey.com/) to apply data science in the area of natural language processing.

## Next word prediction app (using N-gram models)
- based on N-gram model with "Stupid Backoff" ([Brants et al 2007](http://www.cs.columbia.edu/~smaskey/CS6998-0412/supportmaterial/langmodel_mapreduce.pdf));
- checks if highest-order (in this case, n=4) n-gram has been seen. If not "degrades" to a lower-order model (n=3, 2);
- build on `cracklib-small` dictionary.

For additional prediction accuracy we also used:
- Good-Turing Smoothing
- MLE
- linear-regression
- linguistic tweaks

## Dataset
The underlying dataset for this word prediction app was gathered from three sources:

* Blogs
* News
* Twitter

The original english corpus combined over 580 MB of language information. Which summed up to over half a billion characters. After processing the data our model consists out of **millions of ngram tokens**.

## Prediction App:

### Text Area:

Enter the sentence without the final word to be predicted. `Text Area`
allows copy and paste. Text is not case sensitive.

### Clear button:

Delete `Text Area`

### Prediction buttons:

When one of `Prediction` buttons is pressed it merges predicted word to `Text Area` sentence, to do further predictions.  

## N-grams tables:

Select from `unigrams`, `bigrams`, `trigrams` and `tetragrams` to display desired table.

All N-grams tables have four columns: `sentence`, `prediction`, `frequency` and `probability`.

## N-grams plot

Select from `unigrams`, `bigrams`, `trigrams` and `tetragrams` to display
n-grams barplot ordered by `probability`.

## About:
Shows this page.

## Links:

### Packages:

* [Getting Started with quanteda](https://cran.rstudio.com/web/packages/quanteda/vignettes/quickstart.html)
* [Quanteda docs](https://cran.r-project.org/web/packages/quanteda/quanteda.pdf)

### Dictionaries:

* [cracklib-small](https://github.com/cracklib/cracklib/blob/master/src/dicts/cracklib-small)
