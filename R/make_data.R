
make.data <- function(filename, chunksize, ...)
{
  conn <- NULL
  col_names <- NULL
  function(reset = FALSE) {
    if (reset) {
      if (!is.null(conn)) close(conn)
      conn <<- file(filename, open = "r")
      chunk <- read.csv(conn, nrows = chunksize, header = TRUE, ...)
      col_names <<- names(chunk)
      return(chunk)
    } else {
      rval <- read.csv(conn, nrows = chunksize, header = FALSE, ...)
      if (nrow(rval) == 0) {
        close(conn)
        conn <<- NULL
        rval <<- NULL
      } else {
        names(rval) <- col_names
      }
      return(rval)
    }
  }
}
