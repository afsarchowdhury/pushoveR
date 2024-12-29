
<!-- README.md is generated from README.Rmd. Please edit that file -->

# pushoveR

<!-- badges: start -->
<!-- badges: end -->

{pushoveR} is an `R` API wrapper for [Pushover](https://pushover.net/)
notifications. Note: API keys are needed to send push messages.

I made this a while back for my workflow in a school-setting. As a
result, some features are missing as I had no need for them.

## Installation

Install the development version using {devtools}.

``` r
# Install devtools if needed
install.packages("devtools")

# Install pushoveR using devtools
devtools::install_github("afsarchowdhury/pushoveR")
```

A [CRAN](https://cran.r-project.org/) version is unavailable at this
time.

## Storing API keys

Store your API keys as environment variables in `.Renviron`. That way,
you can call them in `R` using `Sys.getenv()`.

Step 1: store your user key in `.Renviron` as, for example, `PO_U_KEY`.

``` r
Sys.setenv("PO_U_KEY" = "thisISyourUSERkeyITlooksLIKEaLONGstringOFlettersANDnumbers")
```

Step 2: store your application key in `.Renviron` as, for example,
`PO_R_KEY`.

``` r
Sys.setenv("PO_R_KEY" = "thisISyourAPPLICATIONkeyITlooksLIKEaLONGstringOFlettersANDnumbers")
```

Step 3: restart your `R` session and check to make sure the keys have
been added using the commands

``` r
Sys.getenv("PO_U_KEY")
Sys.getenv("PO_R_KEY")
```

You should see your keys printed in the console.

Beware: if you are using version control, you do not want to commit the
`.Renviron` file in your local directory. Either edit your global
`.Renviron` file, or make sure that `.Renviron` is added to your
`.gitignore` file.

## Sending push messages

### Normal push message

``` r
pushoveR::send_push(
  token = Sys.getenv("PO_R_KEY"),
  user = Sys.getenv("PO_U_KEY"),
  title = "Normal",
  message = "This is a normal test message from pushoveR."
)
```

### Emergency push message

Emergency push messages are where `priority = 2`. These messages require
`retry` and `expire` parameters.

``` r
pushoveR::send_push(
  token = Sys.getenv("PO_R_KEY"),
  user = Sys.getenv("PO_U_KEY"),
  title = "Emergency",
  message = "This is an urgent test message from pushoveR.",
  priority = 2, # priority 2 is emergency priority
  retry = 30, # retry every 30 seconds
  expire = 300 # keep retrying for 300 seconds
)
```

### Self-expiring push message

Self-expiring push messages have a non-zero, integer `ttl` value for the
number of seconds the message should be kept alive before being deleted.

``` r
pushoveR::send_push(
  token = Sys.getenv("PO_R_KEY"),
  user = Sys.getenv("PO_U_KEY"),
  title = "Expire",
  message = "This is an expiring test message from pushoveR.",
  ttl = 300 # number of seconds to live
)
```

### Base64 image push message

``` r
pushoveR::send_push(
  token = Sys.getenv("PO_R_KEY"),
  user = Sys.getenv("PO_U_KEY"),
  title = "Image",
  message = "This is a base64 image test message from pushoveR.",
  attachment_base64 = substr(df$Image, 24, nchar(df$Image)),
  attachment_type = "image/jpeg"
)
```

## License

{pushoveR} is released on a [GPL-3
license](https://www.gnu.org/licenses/gpl-3.0.en.html).
