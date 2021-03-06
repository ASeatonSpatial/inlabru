% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/bru.inference.R
\name{generate}
\alias{generate}
\alias{generate.bru}
\title{Generate samples from fitted bru models}
\usage{
generate(object, ...)

\method{generate}{bru}(
  object,
  data = NULL,
  formula = NULL,
  n.samples = 100,
  seed = 0L,
  num.threads = NULL,
  include = NULL,
  exclude = NULL,
  ...
)
}
\arguments{
\item{object}{A \code{bru} object obtained by calling \link{bru}.}

\item{...}{additional, unused arguments.}

\item{data}{A data.frame or SpatialPointsDataFrame of covariates needed for
sampling.}

\item{formula}{A formula determining which effects to sample from and how to
combine them analytically.}

\item{n.samples}{Integer setting the number of samples to draw in order to
calculate the posterior statistics.
The default, 100, is rather low but provides a quick approximate result.}

\item{seed}{Random number generator seed passed on to \code{INLA::inla.posterior.sample}}

\item{num.threads}{Specification of desired number of threads for parallel
computations. Default NULL, leaves it up to INLA.
When seed != 0, overridden to "1:1"}

\item{include}{Character vector of component labels that are needed by the
predictor expression; Default: NULL (include all components that are not
explicitly excluded)}

\item{exclude}{Character vector of component labels that are not used by the
predictor expression. The exclusion list is applied to the list
as determined by the \code{include} parameter; Default: NULL (do not remove
any components from the inclusion list)}
}
\value{
The form of the value returned by gg depends on the class of its
argument. See the documentation of the particular methods for details of
what is produced by that method.

List of generated samples
}
\description{
Generic function for sampling for fitted models. The function invokes
particular methods which depend on the class of the first argument.

Takes a fitted \code{bru} object produced by the function \url{bru} and produces
samples given a new set of values for the model covariates or the original
values used for the model fit. The samples can be based on any R expression
that is valid given these values/covariates and the joint
posterior of the estimated random effects.
}
\examples{
\donttest{
if (bru_safe_inla()) {
  
# Generate data for a simple linear model

input.df <- data.frame(x=cos(1:10))
input.df <- within(input.df, y <- 5 + 2*cos(1:10) + rnorm(10, mean=0, sd=0.1))

# Fit the model

fit <- bru(y ~ xeff(main = x, model = "linear"),
           family = "gaussian", data = input.df)
summary(fit)

# Generate samples for some predefined x

df = data.frame(x = seq(-4, 4, by = 0.1))
smp = generate(fit, df, ~ xeff + Intercept, n.samples = 10)

# Plot the resulting realizations

plot(df$x, smp[,1], type = "l")
for (k in 2:ncol(smp)) points(df$x, smp[,k], type = "l")

# We can also draw samples form the joint posterior

df = data.frame(x = 1)
smp = generate(fit, df, ~ data.frame(xeff, Intercept), n.samples = 10)
smp[[1]]

# ... and plot them

plot(do.call(rbind, smp))

}
}
\donttest{
if (bru_safe_inla()) {
  
# Generate data for a simple linear model

input.df <- data.frame(x=cos(1:10))
input.df <- within(input.df, y <- 5 + 2*cos(1:10) + rnorm(10, mean=0, sd=0.1))

# Fit the model

fit <- bru(y ~ xeff(main = x, model = "linear"),
           family = "gaussian", data = input.df)
summary(fit)

# Generate samples for some predefined x

df = data.frame(x = seq(-4, 4, by = 0.1))
smp = generate(fit, df, ~ xeff + Intercept, n.samples = 10)

# Plot the resulting realizations

plot(df$x, smp[,1], type = "l")
for (k in 2:ncol(smp)) points(df$x, smp[,k], type = "l")

# We can also draw samples form the joint posterior

df = data.frame(x = 1)
smp = generate(fit, df, ~ data.frame(xeff, Intercept), n.samples = 10)
smp[[1]]

# ... and plot them

plot(do.call(rbind, smp))

}
}
}
\seealso{
\link{predict.bru}
}
\concept{sample generators}
