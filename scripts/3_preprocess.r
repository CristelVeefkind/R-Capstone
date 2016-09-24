###
# this script clean data for future work:
# * normalize data
# * removes non ascii characters: apostrophes, quotes, punctuation, etc.
# * introduces end of sentence marks
# * replaces numbers, dates, times, emails, urls, hashtags with special marks
# * removes genitive marks, but let 's for verbs
###

# set working directory to the project root folder
setwd(paste0(dirname(parent.frame(2)$ofile), "/.."))

source("./scripts/config.r")
library(quanteda)

print("creating clean data splits")

if (!file.exists(sprintf("%s/%s.rds", data_clean_dir, "data_train"))) {
  #data_clean = c()
  data_raw = c()
  
  for (src in c("blogs_train", "news_train", "twitter_train")) {

    raw_txt <- readRDS(sprintf("%s/%s.rds", data_raw_dir, src))
    data_raw <- c(data_raw, raw_txt)
    
    t <- system.time(clean_txt <- tokenize(raw_txt, 
                                           removeURL = T, 
                                           removeNumbers = T, 
                                           removePunct = T, 
                                           removeSymbols = T, 
                                           removeSeparators = T, 
                                           removeTwitter = T, 
                                           removeHyphens = T, 
                                           verbose = T))
    print(sprintf("%s text preprocessing completed in %.3f s", src, t[3]))
    
    rds_file <- sprintf("%s/%s.rds", data_clean_dir, src)
    saveRDS(clean_txt, rds_file)
    print(sprintf("%s created", rds_file))
    
    #data_clean <- c(data_clean, clean_txt)
  }
  
  t <- system.time(data_clean <- tokenize(data_raw, 
                                         removeURL = T, 
                                         removeNumbers = T, 
                                         removePunct = T, 
                                         removeSymbols = T, 
                                         removeSeparators = T, 
                                         removeTwitter = T, 
                                         removeHyphens = T, 
                                         verbose = T))
  print(sprintf("%s preprocessing completed in %.3f s", "train data", t[3]))
  
  rds_file <- sprintf("%s/%s.rds", data_clean_dir, "data_train")
  saveRDS(data_clean, rds_file)
  print(sprintf("%s created", rds_file))
  
  rm(data_clean, data_raw, clean_txt, raw_txt, t, rds_file, src)
  gc()
  
  print("clean data splits created")
} else {
  print("clean data splits already exists")
}

