###
#
###

setwd(paste0(dirname(parent.frame(2)$ofile), "/.."))

library(quanteda)
library(stringr)

source("scripts/config.r")
source("scripts/dict.r")

nrams_freq_df <- function(tokens, ngram) {
  tokens <- ngrams(tokens, n = ngram, concatenator = "_")
  data_ngram <- dfm(tokens, ngrams = ngram, toLower = F, verbose = T)
  
  df_freq <- sort(colSums(data_ngram), decreasing = T)
  
  df_freq  <- data.frame(names(df_freq), df_freq)
  names(df_freq) <- c("words", "frequency")
  
  if (ngram > 1) {
    df_freq$sentence <- word(df_freq$words, -ngram, -2, sep = fixed("_"))
    df_freq$prediction <- word(df_freq$words, -1, sep = fixed("_"))
    df_freq <- df_freq[!df_freq$sentence == "",]
    df_freq <- df_freq[!df_freq$prediction == UNK,]
    df_freq$words <- NULL
    df_freq  <- df_freq[c("sentence", "prediction", "frequency")]
  }
  rownames(df_freq) <- c(1:nrow(df_freq))
  df_freq  <- df_freq[complete.cases(df_freq),]
  df_freq
}

print("creating ngram data splits")

if (!file.exists(sprintf("%s/%s.rds", model_data_dir, "data_train_tetragram"))) {
  for (src in c(#"blogs", 
                #"news", 
                #"twitter", 
                "data")) {
    for (x in list(
                   #c("unigram", 1), # cause 'the' is always most frequent
                   c("bigram", 2),
                   c("trigram", 3),
                   c("tetragram", 4))) {
      ngram_type <- as.character(x[1])
      ngram <- as.numeric(x[2])
      
      txt_file <- sprintf("%s/%s_train.rds", data_clean_dir, src)
      txt <- readRDS(txt_file)
      
      print(sprintf("creating %s for %s", ngram_type, src))
      
      t <- system.time(data_ngram <- nrams_freq_df(txt, ngram))
      
      rds_file <- sprintf("%s/%s_%s.rds", model_data_dir, src, ngram_type)
      saveRDS(data_ngram, rds_file)
      
      print(sprintf("%s for %s created in %.3f s", ngram_type, src, t[3]))
      
      rm(txt, data_ngram)
      gc()
    }
    print("ngram data splits created")
  }  
} else {
  print("ngram data splits already exists")
}


rm(src, x, ngram_type, ngram, txt_file, txt, data_ngram, t, rds_file)
gc()