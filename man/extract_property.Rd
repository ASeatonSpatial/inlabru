% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/inla.R
\name{extract_property}
\alias{extract_property}
\title{Extract a summary property from all results of an inla result}
\usage{
extract_property(result, property)
}
\arguments{
\item{result}{an \code{inla} result object}

\item{property}{character;}
}
\value{
named list for each estimated fixed effect coefficient,
random effect vector, and hyperparameter. The hyperparameter names are
standardised with \code{\link[=bru_standardise_names]{bru_standardise_names()}}
}
\description{
Extract a summary property from all results of an inla result
}
\keyword{internal}
