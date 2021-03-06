% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/helpers_ggcoefstats_graphics.R
\name{ggcoefstats_label_maker}
\alias{ggcoefstats_label_maker}
\title{Create labels with statistical details for \code{ggcoefstats}}
\usage{
ggcoefstats_label_maker(
  tidy_df,
  glance_df = NULL,
  statistic = NULL,
  k = 2,
  effsize = "eta",
  partial = TRUE,
  ...
)
}
\arguments{
\item{tidy_df}{A tidy dataframe.}

\item{glance_df}{A tidy model summary dataframe (default: \code{NULL}). If
provided, this dataframe will be used to write \code{caption} for the final
plot.}

\item{statistic}{Which statistic is to be displayed (either \code{"t"} or \code{"f"}or
\code{"z"}) in the label. This is especially important if the \code{x} argument in
\code{ggcoefstats} is a dataframe in which case the function wouldn't know what
kind of model it is dealing with.}

\item{k}{Number of decimal places expected for results displayed in labels
(Default : \code{k = 2}).}

\item{effsize}{Character describing the effect size to be displayed: \code{"eta"}
(default) or \code{"omega"}. This argument is relevant
only for models objects of class \code{aov}, \code{anova}, and \code{aovlist}.}

\item{partial}{Logical that decides if partial eta-squared or omega-squared
are returned (Default: \code{TRUE}). If \code{FALSE}, eta-squared or omega-squared
will be returned. Valid only for objects of class \code{aov}, \code{anova}, or
\code{aovlist}.}

\item{...}{Currently ignored.}
}
\description{
Create labels with statistical details for \code{ggcoefstats}
}
\keyword{internal}
