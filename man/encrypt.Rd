% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/encrypt.R
\name{encrypt}
\alias{encrypt}
\alias{decrypt}
\alias{reencrypt}
\title{Perform encryption/decryption}
\usage{
encrypt(text, key, encode = TRUE, ...)

decrypt(text, key, encode = TRUE, ...)

reencrypt(text, key, encode = TRUE, ...)
}
\arguments{
\item{text}{For \code{encrypt}, a character string specifying up to 4 kilobytes of data to be encrypted using the specified key. For \code{decrypt}, ciphertext of maximum 6144 bytes.}

\item{key}{A character string specifying a key ID, Amazon Resource Name (ARN), alias name, or alias ARN. When using an alias name, prefix it with \dQuote{alias/}.}

\item{encode}{A logical specifying whether to base 64 encode \code{text}.}

\item{\dots}{Additional arguments passed to \code{\link{kmsHTTP}}.}
}
\value{
\code{encrypt} returns a base64-encoded binary object as a character string.
}
\description{
Encrypt plain text into ciphertext, or the reverse
}
\details{
\code{encrypt} encrypts source text using a KMS key. \code{decrypt} reverses this process using the same key. \code{reencrypt} reencrypts an (encrypted) ciphertext using a new key. The purpose of these functions, according to AWS, to is encrypt and decrypt data keys (of the source created with \code{\link{generate_data_key}}) rather than general purpose encryption given the relatively low upper limit on the size of \code{text}.
}
\examples{
\dontrun{
  # create a key
  k <- create_kms_key()
  
  # encrypt
  tmp <- tempfile()
  cat("example test", file = tmp)
  (etext <- encrypt(tmp, k))
  
  # decrypt
  (dtext <- decrypt(etext, k, encode = FALSE))
  if (require("base64enc")) {
    rawToChar(base64enc::base64decode(dtext))
  }
  
  # cleanup
  delete_kms_key(k)
}
}
\seealso{
\code{\link{create_kms_key}}, \code{\link{generate_data_key}}, \code{\link{generate_blob}}
}
