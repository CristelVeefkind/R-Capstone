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
source("./scripts/preprocess.r")

print("creating clean data splits")

if (!file.exists(sprintf("%s/%s.rds", data_clean_dir, "data_train"))) {
  data_clean = c()
  
  for (src in c("blogs_train", "news_train", "twitter_train")) {
    chunk_size <- 10000 # data processed in chunks of 10,000 lines each
    
    raw_txt <- readRDS(sprintf("%s/%s.rds", data_raw_dir, src))
    num_lines <- length(raw_txt)
    
    t <- system.time(clean_txt <- clean_data(raw_txt, num_lines, chunk_size))
    printf("%s text preprocessing completed in %.3f s", src, t[3])
    
    rds_file <- sprintf("%s/%s.rds", data_clean_dir, src)
    saveRDS(clean_txt, rds_file)
    print(sprintf("%s created", rds_file))
    
    data_clean = c(data_clean, clean_txt)
  }
  
  rds_file <- sprintf("%s/%s.rds", data_clean_dir, "data_train")
  saveRDS(data_clean, rds_file)
  print(sprintf("%s created", rds_file))
  
  rm(chunk_size, raw_txt, num_lines, clean_txt, t, rds_file, data, src)
  
  print("clean data splits created")
} else {
  print("clean data splits already exists")
}

