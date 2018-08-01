# AWS KMS Client Package.

**aws.kms** is a package for the [AWS KMS Service](https://aws.amazon.com/kms/).

To use the package, you will need an AWS account and to enter your credentials into R. Your keypair can be generated on the [IAM Management Console](https://aws.amazon.com/) under the heading *Access Keys*. Note that you only have access to your secret key once. After it is generated, you need to save it in a secure location. New keypairs can be generated at any time if yours has been lost, stolen, or forgotten. The [**aws.iam** package](https://github.com/cloudyr/aws.iam) profiles tools for working with IAM, including creating roles, users, groups, and credentials programmatically; it is not needed to *use* IAM credentials.

By default, all **cloudyr** packages for AWS services allow the use of credentials specified in a number of ways, beginning with:

 1. User-supplied values passed directly to functions.
 2. Environment variables, which can alternatively be set on the command line prior to starting R or via an `Renviron.site` or `.Renviron` file, which are used to set environment variables in R during startup (see `? Startup`). Or they can be set within R:
 
    ```R
    Sys.setenv("AWS_ACCESS_KEY_ID" = "mykey",
               "AWS_SECRET_ACCESS_KEY" = "mysecretkey",
               "AWS_DEFAULT_REGION" = "us-east-1",
               "AWS_SESSION_TOKEN" = "mytoken")
    ```
 3. If R is running an EC2 instance, the role profile credentials provided by [**aws.ec2metadata**](https://cran.r-project.org/package=aws.ec2metadata).
 4. Profiles saved in a `/.aws/credentials` "dot file" in the current working directory. The `"default" profile is assumed if none is specified.
 5. [A centralized `~/.aws/credentials` file](https://blogs.aws.amazon.com/security/post/Tx3D6U6WSFGOK2H/A-New-and-Standardized-Way-to-Manage-Credentials-in-the-AWS-SDKs), containing credentials for multiple accounts. The `"default" profile is assumed if none is specified.

Profiles stored locally or in a centralized location (e.g., `~/.aws/credentials`) can also be invoked via:

```R
# use your 'default' account credentials
aws.signature::use_credentials()

# use an alternative credentials profile
aws.signature::use_credentials(profile = "bob")
```

Temporary session tokens are stored in environment variable `AWS_SESSION_TOKEN` (and will be stored there by the `use_credentials()` function). The [aws.iam package](https://github.com/cloudyr/aws.iam/) provides an R interface to IAM roles and the generation of temporary session tokens via the security token service (STS).


## Code Examples

The core function in **aws.kms** is `create_kms_key()` which generates a KMS encryption key.

```R
library("aws.kms")

# create key
k <- create_kms_key(description = "example")
# get key
get_kms_key(k)
```

With a key, it is possible to do arbitrary encryption:

```R
# encrypt
tmp <- tempfile()
cat("example test", file = tmp)
(etext <- encrypt(tmp, k))

# decrypt
(dtext <- decrypt(etext, k, encode = FALSE))
if (require("base64enc")) {
    rawToChar(base64enc::base64decode(dtext))
}
```


## Installation

[![CRAN](https://www.r-pkg.org/badges/version/aws.kms)](https://cran.r-project.org/package=aws.kms)
![Downloads](https://cranlogs.r-pkg.org/badges/aws.kms)
[![Travis Build Status](https://travis-ci.org/cloudyr/aws.kms.png?branch=master)](https://travis-ci.org/cloudyr/aws.kms)
[![Appveyor Build Status](https://ci.appveyor.com/api/projects/status/PROJECTNUMBER?svg=true)](https://ci.appveyor.com/project/cloudyr/aws.kms)
[![codecov.io](https://codecov.io/github/cloudyr/aws.kms/coverage.svg?branch=master)](https://codecov.io/github/cloudyr/aws.kms?branch=master)

This package is not yet on CRAN. To install the latest development version you can install from the cloudyr drat repository:

```R
# latest stable version
install.packages("aws.kms", repos = c(cloudyr = "http://cloudyr.github.io/drat", getOption("repos")))
```

Or, to pull a potentially unstable version directly from GitHub:

```R
if (!require("remotes")) {
    install.packages("remotes")
}
remotes::install_github("cloudyr/aws.kms")
```


---
[![cloudyr project logo](https://i.imgur.com/JHS98Y7.png)](https://github.com/cloudyr)