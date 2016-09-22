
#create a matrix ids representation of the lines in chunks
ids_matrix <- function(num_lines, chunk_size) {
  num_chunks <- round(num_lines / chunk_size)
  chunks <- 1:num_chunks
  idx <- matrix(1:(chunk_size * num_chunks), 
                nrow = num_chunks, 
                ncol = chunk_size, 
                byrow = T)
  
  if((num_lines / chunk_size) > num_chunks) {
    lastIds <- ((num_lines / chunk_size) - num_chunks) * chunk_size
    
    lastRow <- rep(NA, chunk_size)
    lastRow[1:lastIds] <- (chunk_size * num_chunks) + (1:lastIds)
    idx <- rbind(idx, lastRow)
  }
  
  idx
}
