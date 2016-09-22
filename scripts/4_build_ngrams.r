###
#
###

setwd(paste0(dirname(parent.frame(2)$ofile), "/.."))

library(quanteda)

source("scripts/config.r")

print("creating ngram data splits")

if (!file.exists(sprintf("%s/%s.rds", model_data_dir, "data"))) {
  for (src in c("blogs", "news", "twitter", "data")) {
    for (x in list(c("bigram", 2),
                   c("trigram", 3),
                   c("tetragram", 4))) {
      ngram_type <- as.character(x[1])
      ngram <- as.numeric(x[2])
      
      txt_file <- sprintf("%s/%s_train.rds", data_clean_dir, src)
      txt <- readRDS(txt_file)
      
      print(sprintf("creating %s for %s", ngram_type, src))
      
      t <- system.time(data_ngram <- dfm(txt, ngrams = ngram, verbose = T))
      
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