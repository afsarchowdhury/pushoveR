
<!-- README.md is generated from README.Rmd. Please edit that file -->

# pushoveR

<!-- badges: start -->
<!-- badges: end -->

{pushoveR} is an R API wrapper for [Pushover](https://pushover.net/).
API keys are needed to send push messages.

## Installation

Install the development version from [GitHub](https://github.com/).

``` r
# Install devtools if needed
#install.packages("devtools")

# Install g4sr using devtools
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

Step 3: restart your `R` session and test to make sure the keys have
been added using the command

``` r
Sys.getenv("PO_U_KEY")
```

You should see your user key printed in the console.

Be aware: if you are using version control, you do not want to commit
the `.Renviron` file in your local directory. Either edit your global
`.Renviron` file, or make sure that `.Renviron` is added to your
`.gitignore` file.

## Sending push messages

A normal push message:

``` r
pushoveR::send_push(
  token = Sys.getenv("PO_R_KEY"),
  user = Sys.getenv("PO_U_KEY"),
  title = "Hello",
  message = "This is a test message from pushoveR."
)
```

An emergency push message:

``` r
pushoveR::send_push(
  token = Sys.getenv("PO_R_KEY"),
  user = Sys.getenv("PO_U_KEY"),
  title = "Hello",
  message = "This is a test message from pushoveR.",
  priority = 2, # priority 2 is emergency priority
  retry = 30, # retry every 30 seconds
  expire = 300 # keep retrying for 300 seconds
)
```

## License

{pushoveR} is released on a [GPL-3
license](https://www.gnu.org/licenses/gpl-3.0.en.html).