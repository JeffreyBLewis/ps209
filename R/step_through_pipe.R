library(rlang)
library(tidyverse)

#' Make pretty printout of piped code block string.
#'
#' @param ptext string of pipe-separated commands.
#'
#' @return pretty version of code string.
#'
#' @import stringr
#' @import magrittr
pprintp <- function(ptext) {
   ptext %>%
     str_replace_all("%>%", "%>%\n  ") %>%
     str_replace("%>%\n  ", "%>%")
}

#' Make a string of separator characters to use in print outs.
#'
#' @param char Character to use.
#' @param line_length Number of characters in the string.
#'
#' @return Separator string.
#'
#'
#' @import stringr
#' @import magrittr

sepline <- function(char="-", line_length=60) {
  paste0(paste0(rep(char,line_length), collapse=""),"\n")
}

#' Display intermediate results of blocks of piped expressions.
#'
#' @param expr Block of dplyr or other piped commands.
#'
#' @return Result of evaluating \eqn{expr}.
#'
#' @importFrom magrittr `%>%``
#' @importFrom rlang eval
#'
#' @examples
#' library(tidyverse)
#' step_through_pipes({
#'    starwars %>%
#'       mutate(bmi=mass/((height/100)^2)) %>%
#'       select(name:mass, bmi) %>%
#'       filter(bmi<22) %>%
#'       gather(feature, value, -name) %>%
#'       arrange(name, feature)
#' })
#'
step_through_pipes <- function(expr) {
  cat("\nStepping through pipes:\n")
  le <- env(`%>%` = function(lhs, rhs) {
                      pcall <- paste0(expr(lhs),
                                " %>% ",
                                deparse(substitute(rhs)),"\n")
                      res <- eval(parse(text=pcall))
                      pretty_pcall <- pprintp(pcall %>% str_replace_all("lhs","."))
                      sepline_len <- max(sapply(str_split(pretty_pcall,"\\n"), nchar)) + 3
                      cat(sepline("=", sepline_len))
                      cat(pretty_pcall)
                      cat(sepline("=", sepline_len))
                      print(head(res))
                      cat("\n")
                      res
                      })
  res <- eval(enexpr(expr), le)
  cat("Pipes completed!\n\n")
}

