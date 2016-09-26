
library(quanteda)
library(stringr)

source("config.r")

dct <- readLines(dict_dir, encoding = "UTF-8")

bigrams <- readRDS(sprintf("%s/%s.rds", data_dir, "data_bigram"))
trigrams <- readRDS(sprintf("%s/%s.rds", data_dir, "data_trigram"))
tetragrams <- readRDS(sprintf("%s/%s.rds", data_dir, "data_tetragram"))

preprocess_input <- function(txt) {
  txt <- corpus(tolower(txt))
  tokens <- tokenize(txt, 
                     removeURL = T, 
                     removeNumbers = T, 
                     removePunct = T, 
                     removeSymbols = T, 
                     removeSeparators = T, 
                     removeTwitter = T, 
                     removeHyphens = T, 
                     verbose = F)
  
  mask <- tokens[[1]] %in% dct
  tokens[[1]][!mask] <- UNK
  tokens[[1]]
}

ngram_prediction <- function(txt, ngram = 4) {
  ngram <- min(ngram - 1, length(txt))
  
  txt <-tail(txt, ngram)
  txt <- paste(txt, collapse = "_")
  
  res <- list()
  res$bigram <- word(txt, -1, -1, sep = fixed("_"))
  res$trigram <- word(txt, -2, -1, sep = fixed("_"))
  res$tetragram <- word(txt, -3, -1, sep = fixed("_"))
  
  res
}

next_word <- function(txt) {
  txt <- preprocess_input(txt)
  num_words <- length(txt)
  ngrams <- ngram_prediction(txt)
  
  if(num_words >= 3){
    prediction <- tetragrams[tetragrams$sentence == ngrams$tetragram, ]
    print("tetragram prediction:")
    print(head(prediction, min(nrow(prediction), 5)))
    prediction <- head(prediction, 1)$prediction
    if(!identical(prediction, character(0))){
      return(prediction)
    }
  }
  
  if(num_words >= 2){
    prediction <- trigrams[trigrams$sentence == ngrams$trigram, ]
    print("trigram prediction:")
    print(head(prediction, min(nrow(prediction), 5)))
    prediction <- head(prediction, 1)$prediction
    if(!identical(prediction, character(0))){
      return(prediction)
    }
  }
  
  if(num_words >= 1){
    prediction <- bigrams[bigrams$sentence == ngrams$bigram, ]
    print("bigram prediction:")
    print(head(prediction, min(nrow(prediction), 5)))
    prediction <- head(prediction, 1)$prediction
    if(!identical(prediction, character(0))){
      return(prediction)
    }
  }
  
  prediction <- "the"
  print(sprintf("unigram prediction: %s", prediction))
  prediction
  
}