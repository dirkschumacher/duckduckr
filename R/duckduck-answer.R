#' Call DuckDuckGo Instant Answer API
#'
#' Makes a synchronous API call to the DuckDuckGo Instant Answer API.
#' Take a look at DuckDuckGo's terms of use (\url{https://api.duckduckgo.com/api}) before using it.
#'
#' @param query the query string
#' @param no_redirect TRUE to skip HTTP redirects (for !bang commands)
#' @param no_html TRUE to remove html from results
#' @param skip_disambig TRUE to to skip disambiguation (D) Type.
#' @param app_name the appname used to identify your application.
#'
#' @seealso \url{https://api.duckduckgo.com/api} for more information on the API and their terms of use.
#'
#' @return Always returns a list. If the API call was successful it contains the response of
#'         the duckduckgo API as parsed by \code{\link[jsonlite]{fromJSON}}. In addition the object's
#'         attributes contain additional meta data. Especially the \code{status} attribute indicates
#'         if something went wrong during the HTTP call or parsing of the JSON text.
#'
#'         In case the call was successful the \code{status} attribute is equal to "OK".
#'
#'         In case something went wrong, the \code{status} attribute is equal to "error" and in the
#'         \code{error} attribute you will find more information. In particular the \code{type}, which is
#'         either "http_error" or "json_parse_error" depending on the error's source.
#'
#'         In case of a "http_error", there is an additional \code{message} and \code{http_status}
#'         element.
#'
#'         In case of "json_parse_error", there is an additional \code{message} element.
#'
#'         In addition there is always a \code{source} element with the URL used to query the data.
#' @export
#' @examples \dontrun{
#' tmp <- duckduck_answer("duckduckgo")
#' tmp$Abstract
#' }
duckduck_answer <- function(query, no_redirect = FALSE,
                            no_html = FALSE, skip_disambig = FALSE,
                            app_name = "duckduckr") {

  # lazy input checks
  stopifnot(length(app_name) == 1)
  stopifnot(length(no_redirect) == 1)
  stopifnot(length(no_html) == 1)
  stopifnot(length(skip_disambig) == 1)
  stopifnot(length(query) == 1)
  stopifnot(is.character(app_name))
  stopifnot(is.character(query))
  stopifnot(nchar(app_name) > 0)
  stopifnot(is.logical(no_redirect))
  stopifnot(is.logical(no_html))
  stopifnot(is.logical(skip_disambig))

  # construct the api call
  client <- crul::HttpClient$new(url = "https://api.duckduckgo.com/")
  query_params <- list(
    q = query,
    no_redirect = as.integer(no_redirect),
    no_html = as.integer(no_html),
    format = "json",
    skip_disambig = as.integer(skip_disambig),
    t = app_name
  )
  result <- client$get("", query_params)

  # format the result
  http_status <- result$status_http()$status_code
  if (http_status == "200") {
    parsed_response <- tryCatch({
      parsed_response <- jsonlite::fromJSON(
        suppressMessages(result$parse("UTF-8")),
        simplifyVector = TRUE,
        simplifyDataFrame = TRUE,
        simplifyMatrix = TRUE,
        flatten = FALSE
      )
      response_names <- names(parsed_response)
      attributes(parsed_response) <- list(
        status = "OK",
        source = result$url
      )
      names(parsed_response) <- response_names
      parsed_response
    }, error = function(e) {
      parsed_response <- list()
      attributes(parsed_response) <- make_error_object(
        result$url,
        list(
          "message" = e$message,
          "type" = "json_parse_error"
        )
      )
      parsed_response
    })
  } else {
    parsed_response <- list()
    attributes(parsed_response) <- make_error_object(
      result$url,
      list(
        "message" = "HTTP get call failed",
        "http_status" = http_status,
        "type" = "http_error"
      )
    )
  }
  parsed_response
}

#' @noRd
make_error_object <- function(url, error) {
  list(
    status = "error",
    error = error,
    source = url
  )
}
