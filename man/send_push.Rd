% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/push.R
\name{send_push}
\alias{send_push}
\title{Send push.}
\usage{
send_push(
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
)
}
\arguments{
\item{token}{(required) application API token as string.}

\item{user}{(required) user key or group key as string.}

\item{title}{(required) message title as string.}

\item{message}{(required) message as string.}

\item{url}{URL to show with your message as string.}

\item{url_title}{title for the \code{url} as string.}

\item{device}{name of device as string.}

\item{priority}{value of -2, -1, 0 (default), 1, or 2.}

\item{sound}{name of a supported sound (see https://pushover.net/api#sounds) as string.}

\item{timestamp}{Unix timestamp of a time to display instead of when the API received it.}

\item{ttl}{number of seconds that the message will live, before being deleted automatically, as integer.}

\item{attachment_base64}{base64-encoded image attachment to send with the message.}

\item{attachment_type}{MIME type of the \code{attachment_base64}. Usually, "image/jpeg".}

\item{retry}{how often in seconds to retry (required if \code{priority} = 2).}

\item{expire}{how many seconds to retry (required if \code{priority} = 2).}
}
\description{
Push a message through Pushover.
}
\examples{
\dontrun{
send_push(
title = "Test push", message = "Hello from pushoveR.",
token = Sys.getenv("PO_R_KEY"), user = Sys.getenv("PO_U_KEY")
)
}
}
