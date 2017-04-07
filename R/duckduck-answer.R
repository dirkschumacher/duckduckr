#' DuckDuckGo's Instant Answer API
#'
#' Makes a synchronous API call.
#'
#' @param query the query string
#' @param no_redirect TRUE to skip HTTP redirects (for !bang commands)
#' @param no_html TRUE to remove html from results
#' @param skip_disambig TRUE to to skip disambiguation (D) Type.
#' @param app_name the appname used to identify your application. This is optional.
#'
#' If the JSON cannot be parsed then this function throws an error.
#' If you want to be safe, try to catch those errors.
#'
#' @return Always returns a list with at least the slot `status`.
#'         If the status is `OK`, then the result of the query is in the `result` slot.
#'         If the status is `error`, then additional information is in the `error` slot.
#' @export
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
  client <- crul::HttpClient$new(url = "https://api.duckduckgo.com")
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
    list(
      status = "OK",
      result = jsonlite::fromJSON(suppressMessages(result$parse("UTF-8"))),
      source = result$url
    )
  } else {
    list(
      status = "error",
      error = list(
        "message" = "HTTP get call failed",
        "http_status" = http_status
      ),
      source = result$url
    )
  }
}
