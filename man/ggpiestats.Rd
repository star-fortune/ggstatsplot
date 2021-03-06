% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ggpiestats.R
\name{ggpiestats}
\alias{ggpiestats}
\title{Pie charts with statistical tests}
\usage{
ggpiestats(
  data,
  main,
  condition = NULL,
  counts = NULL,
  ratio = NULL,
  paired = FALSE,
  results.subtitle = TRUE,
  factor.levels = NULL,
  label = "percentage",
  perc.k = 0,
  label.args = list(alpha = 1, fill = "white"),
  bf.message = TRUE,
  sampling.plan = "indepMulti",
  fixed.margin = "rows",
  prior.concentration = 1,
  title = NULL,
  subtitle = NULL,
  caption = NULL,
  conf.level = 0.95,
  nboot = 100,
  legend.title = NULL,
  k = 2,
  proportion.test = TRUE,
  ggtheme = ggplot2::theme_bw(),
  ggstatsplot.layer = TRUE,
  package = "RColorBrewer",
  palette = "Dark2",
  direction = 1,
  ggplot.component = NULL,
  output = "plot",
  messages = TRUE,
  x = NULL,
  y = NULL,
  ...
)
}
\arguments{
\item{data}{for use with \code{formula}, a data frame containing all the
data}

\item{counts}{A string naming a variable in data containing counts, or \code{NULL}
if each row represents a single observation (Default).}

\item{ratio}{A vector of proportions: the expected proportions for the
proportion test (should sum to 1). Default is \code{NULL}, which means the null
is equal theoretical proportions across the levels of the nominal variable.
This means if there are two levels this will be \code{ratio = c(0.5,0.5)} or if
there are four levels this will be \code{ratio = c(0.25,0.25,0.25,0.25)}, etc.}

\item{paired}{Logical indicating whether data came from a within-subjects or
repeated measures design study (Default: \code{FALSE}). If \code{TRUE}, McNemar's
test subtitle will be returned. If \code{FALSE}, Pearson's chi-square test will
be returned.}

\item{results.subtitle}{Decides whether the results of statistical tests are
to be displayed as a subtitle (Default: \code{TRUE}). If set to \code{FALSE}, only
the plot will be returned.}

\item{factor.levels}{A character vector with labels for factor levels of
\code{main} variable.}

\item{label}{Character decides what information needs to be displayed
on the label in each pie slice. Possible options are \code{"percentage"}
(default), \code{"counts"}, \code{"both"}.}

\item{perc.k}{Numeric that decides number of decimal places for percentage
labels (Default: \code{0}).}

\item{label.args}{Additional aesthetic arguments that will be passed to
\code{geom_label}.}

\item{bf.message}{Logical that decides whether to display a caption with
results from Bayes Factor test in favor of the null hypothesis (default:
\code{FALSE}).}

\item{sampling.plan}{Character describing the sampling plan. Possible options
are \code{"indepMulti"} (independent multinomial; default), \code{"poisson"},
\code{"jointMulti"} (joint multinomial), \code{"hypergeom"} (hypergeometric). For
more, see \code{?BayesFactor::contingencyTableBF()}.}

\item{fixed.margin}{For the independent multinomial sampling plan, which
margin is fixed (\code{"rows"} or \code{"cols"}). Defaults to \code{"rows"}.}

\item{prior.concentration}{Specifies the prior concentration parameter, set
to \code{1} by default. It indexes the expected deviation from the null
hypothesis under the alternative, and corresponds to Gunel and Dickey's
(1974) \code{"a"} parameter.}

\item{title}{The text for the plot title.}

\item{subtitle}{The text for the plot subtitle. Will work only if
\code{results.subtitle = FALSE}.}

\item{caption}{The text for the plot caption.}

\item{conf.level}{Scalar between 0 and 1. If unspecified, the defaults return
\verb{95\%} lower and upper confidence intervals (\code{0.95}).}

\item{nboot}{Number of bootstrap samples for computing confidence interval
for the effect size (Default: \code{100}).}

\item{legend.title}{Title text for the legend.}

\item{k}{Number of digits after decimal point (should be an integer)
(Default: \code{k = 2}).}

\item{proportion.test}{Decides whether proportion test for \code{main} variable is
to be carried out for each level of \code{condition} (Default: \code{TRUE}).}

\item{ggtheme}{A function, \code{ggplot2} theme name. Default value is
\code{ggplot2::theme_bw()}. Any of the \code{ggplot2} themes, or themes from
extension packages are allowed (e.g., \code{ggthemes::theme_fivethirtyeight()},
\code{hrbrthemes::theme_ipsum_ps()}, etc.).}

\item{ggstatsplot.layer}{Logical that decides whether \code{theme_ggstatsplot}
theme elements are to be displayed along with the selected \code{ggtheme}
(Default: \code{TRUE}). \code{theme_ggstatsplot} is an opinionated theme layer that
override some aspects of the selected \code{ggtheme}.}

\item{package}{Name of package from which the palette is desired as string
or symbol.}

\item{palette}{If a character string (e.g., \code{"Set1"}), will use that named
palette. If a number, will index into the list of palettes of appropriate
type. Default palette is \code{"Dark2"}.}

\item{direction}{Either \code{1} or \code{-1}. If \code{-1} the palette will be reversed.}

\item{ggplot.component}{A \code{ggplot} component to be added to the plot prepared
by \code{ggstatsplot}. This argument is primarily helpful for \code{grouped_} variant
of the current function. Default is \code{NULL}. The argument should be entered
as a function.}

\item{output}{Can either be \code{"null"} (or \code{"caption"} or \code{"H0"} or \code{"h0"}),
which will return expression with evidence in favor of the null hypothesis,
or \code{"alternative"} (or \code{"title"} or \code{"H1"} or \code{"h1"}), which will return
expression with evidence in favor of the alternative hypothesis, or
\code{"results"}, which will return a dataframe with results all the details).}

\item{messages}{Decides whether messages references, notes, and warnings are
to be displayed (Default: \code{TRUE}).}

\item{x, main}{The variable to use as the \strong{rows} in the contingency table.}

\item{y, condition}{The variable to use as the \strong{columns} in the contingency
table. Default is \code{NULL}. If \code{NULL}, one-sample proportion test (a goodness
of fit test) will be run for the \code{x} variable. Otherwise an appropriate
association test will be run. This argument can not be \code{NULL} for
\code{ggbarstats} function.}

\item{...}{further arguments to be passed to or from methods.}
}
\value{
Unlike a number of statistical softwares, \code{ggstatsplot} doesn't
provide the option for Yates' correction for the Pearson's chi-squared
statistic. This is due to compelling amount of Monte-Carlo simulation
research which suggests that the Yates' correction is overly conservative,
even in small sample sizes. As such it is recommended that it should not
ever be applied in practice (Camilli & Hopkins, 1978, 1979; Feinberg, 1980;
Larntz, 1978; Thompson, 1988).

For more about how the effect size measures and their confidence intervals
are computed, see \code{?rcompanion::cohenG}, \code{?rcompanion::cramerV}, and
\code{?rcompanion::cramerVFit}.
}
\description{
Pie charts for categorical data with statistical details
included in the plot as a subtitle.
}
\examples{
# for reproducibility
set.seed(123)

# one sample goodness of fit proportion test
ggstatsplot::ggpiestats(
  data = ggplot2::msleep,
  x = vore,
  perc.k = 1
)

# association test (or contingency table analysis)
ggstatsplot::ggpiestats(
  data = mtcars,
  x = vs,
  y = cyl,
  bf.message = TRUE,
  nboot = 10,
  factor.levels = c("0 = V-shaped", "1 = straight"),
  legend.title = "Engine"
)
}
\references{
\url{https://indrajeetpatil.github.io/ggstatsplot/articles/web_only/ggpiestats.html}
}
\seealso{
\code{\link{grouped_ggpiestats}}, \code{\link{ggbarstats}},
\code{\link{grouped_ggbarstats}}
}
