% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/combine_plots2.R
\name{combine_plots2}
\alias{combine_plots2}
\title{Simpler way to combine and arrange multiple plots in a grid}
\usage{
combine_plots2(
  plotlist,
  plotgrid.args = list(),
  title.text = NULL,
  title.args = list(size = 16, fontface = "bold"),
  caption.text = NULL,
  caption.args = list(size = 10),
  sub.text = NULL,
  sub.args = list(size = 12),
  title.rel.heights = c(0.1, 1.2),
  caption.rel.heights = c(1.2, 0.1),
  title.caption.rel.heights = c(0.1, 1.2, 0.1),
  ...
)
}
\arguments{
\item{plotlist}{A list of plots to display.}

\item{plotgrid.args}{A list of additional arguments to \code{cowplot::plot_grid}.}

\item{title.text}{String or plotmath expression to be drawn as title for the
\emph{combined plot}.}

\item{title.args, caption.args, sub.args}{A list of additional arguments
provided to \code{title}, \code{caption} and \code{sub}, resp.}

\item{caption.text}{String or plotmath expression to be drawn as the caption
for the \emph{combined plot}.}

\item{sub.text}{The label with which the \emph{combined plot} should be annotated.
Can be a plotmath expression.}

\item{title.rel.heights}{Numerical vector of relative columns heights while
combining (title, plot).}

\item{caption.rel.heights}{Numerical vector of relative columns heights while
combining (plot, caption).}

\item{title.caption.rel.heights}{Numerical vector of relative columns heights
while combining (title, plot, caption).}

\item{...}{Currently ignored.}
}
\value{
Combined plot with title and/or caption and/or annotation label
}
\description{
Wrapper around \code{cowplot::plot_grid} that will return a plotgrid
along with a combination of title, caption, and annotation label. This is a
simpler version of the \code{combine_plots} function in this package.
}
\examples{
# loading the necessary libraries
library(ggplot2)

# preparing the first plot
p1 <-
  ggplot2::ggplot(
    data = subset(iris, iris$Species == "setosa"),
    aes(x = Sepal.Length, y = Sepal.Width)
  ) +
  geom_point() +
  labs(title = "setosa")

# preparing the second plot
p2 <-
  ggplot2::ggplot(
    data = subset(iris, iris$Species == "versicolor"),
    aes(x = Sepal.Length, y = Sepal.Width)
  ) +
  geom_point() +
  labs(title = "versicolor")

# combining the plot with a title and a caption
combine_plots2(
  plotlist = list(p1, p2),
  plotlist.args = list(labels = c("(a)", "(b)")),
  title.text = "Dataset: Iris Flower dataset",
  caption.text = "Note: Only two species of flower are displayed",
  title.args = list(color = "red"),
  caption.args = list(color = "blue")
)
}
\references{
\url{https://indrajeetpatil.github.io/ggstatsplot/articles/web_only/combine_plots.html}
}
