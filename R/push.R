# Create push function
#' Send push.
#'
#' Push a message through Pushover.
#' @param token (required) application API token as string.
#' @param user (required) user key or group key as string.
#' @param title (required) message title as string.
#' @param message (required) message as string.
#' @param url URL to show with your message as string.
#' @param url_title title for the `url` as string.
#' @param device name of device as string.
#' @param priority value of -2, -1, 0 (default), 1, or 2.
#' @param sound name of a supported sound (see https://pushover.net/api#sounds) as string.
#' @param timestamp Unix timestamp of a time to display instead of when the API received it.
#' @param ttl number of seconds that the message will live, before being deleted automatically, as integer.
#' @param attachment_base64 base64-encoded image attachment to send with the message.
#' @param attachment_type MIME type of the `attachment_base64`. Usually, "image/jpeg".
#' @param retry how often in seconds to retry (required if `priority` = 2).
#' @param expire how many seconds to retry (required if `priority` = 2).
#' @examples
#' \dontrun{
#' send_push(
#' title = "Test push", message = "Hello from pushoveR.",
#' token = Sys.getenv("PO_R_KEY"), user = Sys.getenv("PO_U_KEY")
#' )
#' }
#' @export
send_push <- function(
    token,
    user,
    title,
    message,
    url = NULL,
    url_title = NULL,
    device = NULL,
    priority = 0,
    sound = NULL,
    timestamp = NULL,
    ttl = NULL,
    attachment_base64 = NULL,
    attachment_type = NULL,
    retry = NULL,
    expire = NULL
) {
  # Checks
  checkmate::assert_string(x = token, na.ok = FALSE, null.ok = FALSE)
  checkmate::assert_string(x = user, na.ok = FALSE, null.ok = FALSE)
  checkmate::assert_string(x = title, min.chars = 1, max.chars = 250)

  if (priority == 2){
    checkmate::assert_double(x = retry, lower = 30, null.ok = FALSE)
    checkmate::assert_double(x = expire, upper = 10800, null.ok = FALSE)
  }

  if (is.null(attachment_base64) == FALSE) {
    checkmate::assert_string(x = attachment_type, na.ok = FALSE, null.ok = FALSE)
  }

  # Push body
  request_body <- list(
    token = token,
    user = user,
    message = message,
    attachment_base64 = attachment_base64,
    attachment_type = attachment_type,
    title = title,
    priority = priority,
    url = url,
    url_title = url_title,
    sound = sound,
    device = paste0(device, collapse = ","),
    html = 1,
    timestamp = timestamp,
    ttl = ttl,
    retry = retry,
    expire = expire
  )

  # Remove NULL elements from request body
  request_body <- Filter(Negate(is.null), request_body)

  # Convert to dataframe
  request_body <- as.data.frame(request_body)

  # Path
  path_push <- "https://api.pushover.net/1/messages.json"

  # Send using httr2
  httr2::request(base_url = path_push) |>
    httr2::req_headers("Host" = "api.pushover.net") |>
    httr2::req_headers("Content-Type" = "application/json") |>
    httr2::req_body_raw(body = jsonlite::toJSON(x = jsonlite::unbox(request_body))) |>
    httr2::req_throttle(rate = 1 / 1) |>
    httr2::req_perform()
}
