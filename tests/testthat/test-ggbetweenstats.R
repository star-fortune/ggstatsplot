# checking labels and data from plot -------------------------------------

testthat::test_that(
  desc = "checking labels and data from plot",
  code = {
    testthat::skip_on_cran()

    # creating the plot
    set.seed(123)
    p <-
      ggstatsplot::ggbetweenstats(
        data = ggplot2::msleep,
        x = vore,
        y = brainwt,
        title = "mammalian sleep",
        caption = "From ggplot2 package",
        xlab = "vore",
        ylab = "brain weight",
        pairwise.comparisons = TRUE,
        ggstatsplot.layer = FALSE,
        outlier.tagging = TRUE,
        outlier.label = name,
        outlier.label.args = list(color = "darkgreen"),
        conf.level = 0.99,
        k = 5,
        bf.message = TRUE,
        messages = TRUE
      )

    # subtitle
    set.seed(123)
    p_subtitle <-
      statsExpressions::expr_anova_parametric(
        data = ggplot2::msleep,
        x = vore,
        y = brainwt,
        k = 5,
        messages = FALSE,
        conf.level = 0.99
      )

    # plot build
    pb <- ggplot2::ggplot_build(p)

    # dataframe used for visualization
    testthat::expect_equal(length(pb$data), 6L)
    testthat::expect_equal(dim(pb$data[[1]]), c(44L, 13L))
    testthat::expect_equal(dim(pb$data[[2]]), c(4L, 26L))
    testthat::expect_equal(dim(pb$data[[3]]), c(2048L, 21L))
    testthat::expect_equal(dim(pb$data[[5]]), c(4L, 13L))

    # data from difference layers
    testthat::expect_equal(length(pb$data), 6L)
    testthat::expect_equal(pb$data[[5]]$x, c(1L, 2L, 3L, 4L))
    testthat::expect_equal(pb$data[[5]]$y,
      c(0.07925556, 0.62159750, 0.02155000, 0.14573118),
      tolerance = 0.001
    )

    # checking displayed outlier labels
    testthat::expect_equal(
      pb$data[[4]],
      structure(
        list(
          x = c(2L, 2L, 1L, 4L, 2L, 1L, 3L),
          y = c(
            4.603,
            0.655, 0.325, 1.32, 5.712, 0.157, 0.081
          ),
          label = c(
            "Asian elephant",
            "Horse",
            "Gray seal",
            "Human",
            "African elephant",
            "Jaguar",
            "Giant armadillo"
          ),
          PANEL = structure(c(1L, 1L, 1L, 1L, 1L, 1L, 1L), class = "factor", .Label = "1"),
          group = structure(c(2L, 2L, 1L, 4L, 2L, 1L, 3L), n = 4L),
          colour = c(
            "darkgreen",
            "darkgreen",
            "darkgreen",
            "darkgreen",
            "darkgreen",
            "darkgreen",
            "darkgreen"
          ),
          fill = c("white", "white", "white", "white", "white", "white", "white"),
          size = c(3.88, 3.88, 3.88, 3.88, 3.88, 3.88, 3.88),
          angle = c(0, 0, 0, 0, 0, 0, 0),
          alpha = c(NA, NA, NA, NA, NA, NA, NA),
          family = c("", "", "", "", "", "", ""),
          fontface = c(1, 1, 1, 1, 1, 1, 1),
          lineheight = c(1.2, 1.2, 1.2, 1.2, 1.2, 1.2, 1.2),
          hjust = c(0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5),
          vjust = c(0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5)
        ),
        row.names = c(NA, -7L),
        class = "data.frame"
      )
    )

    # range of y variable
    testthat::expect_equal(ggplot2::layer_scales(p)$y$range$range,
      c(0.00014, 5.71200000),
      tolerance = 1e-5
    )

    # checking x-axis sample size labels
    testthat::expect_identical(
      ggplot2::layer_scales(p)$x$labels,
      c(
        "carni\n(n = 9)",
        "herbi\n(n = 20)",
        "insecti\n(n = 5)",
        "omni\n(n = 17)"
      )
    )

    # checking plot labels
    testthat::expect_equal(
      pb$plot$labels,
      list(
        x = "vore",
        y = "brain weight",
        colour = "vore",
        title = "mammalian sleep",
        subtitle =
          ggplot2::expr(
            paste(
              NULL,
              italic("F")["Welch"],
              "(",
              "3",
              ",",
              "24.04746",
              ") = ",
              "2.26528",
              ", ",
              italic("p"),
              " = ",
              "0.10662",
              ", ",
              widehat(omega["p"]^2),
              " = ",
              "0.00349",
              ", CI"["99%"],
              " [",
              "-0.06250",
              ", ",
              "0.07503",
              "]",
              ", ",
              italic("n")["obs"],
              " = ",
              51L
            )
          ),
        caption = ggplot2::expr(atop(
          displaystyle(atop(
            displaystyle("From ggplot2 package"),
            expr = paste(
              "In favor of null: ",
              "log"["e"],
              "(BF"["01"],
              ") = ",
              "1.54274",
              ", ",
              italic("r")["Cauchy"]^"JZS",
              " = ",
              "0.70700"
            )
          )),
          expr = paste(
            "Pairwise comparisons: ",
            bold("Games-Howell test"),
            "; Adjustment (p-value): ",
            bold("Holm")
          )
        )),
        label = "outlier.label"
      )
    )
  }
)

# mean labelling tests work ------------------------------------------

testthat::test_that(
  desc = "checking mean labels are working",
  code = {
    testthat::skip_on_cran()

    # creating the plot
    set.seed(123)
    p <-
      ggstatsplot::ggbetweenstats(
        data = tibble::as_tibble(mtcars, rownames = "name") %>%
          dplyr::rename(.data = ., n = wt),
        x = "cyl",
        y = "n",
        type = "np",
        mean.ci = TRUE,
        k = 2L,
        conf.level = 0.90,
        outlier.tagging = TRUE,
        outlier.label = "name",
        outlier.coef = 2.5,
        nboot = 5,
        results.subtitle = FALSE,
        messages = FALSE
      ) +
      ggplot2::coord_cartesian(ylim = c(1, 6)) +
      ggplot2::scale_y_continuous(limits = c(1, 6), breaks = seq(1, 6, 1))

    # plot build
    pb <- ggplot2::ggplot_build(p)

    # checking dimensions of data for `geom_point`
    # since there are outliers, there should be 3 less no. of points than sample
    # size (which is 32L here)
    testthat::expect_equal(dim(pb$data[[1]]), c(29L, 13L))

    # checking displayed mean labels
    testthat::expect_identical(
      pb$data[[4]]$label,
      c(
        "Cadillac Fleetwood",
        "Lincoln Continental",
        "Chrysler Imperial"
      )
    )

    # check if the y-axis labels have changed
    testthat::expect_identical(
      pb$layout$panel_params[[1]]$x$scale$labels,
      c("4\n(n = 11)", "6\n(n = 7)", "8\n(n = 14)")
    )

    testthat::expect_identical(
      pb$layout$panel_params[[1]]$y$breaks,
      c(1, 2, 3, 4, 5, 6)
    )

    # edge case
    a <- data.frame(
      mean.a = c(1.1, 0.9, 0.94, 1.58, 1.2, 1.4),
      group = c("a", "a", "a", "b", "b", "b")
    )

    # plot
    p <-
      ggstatsplot::ggbetweenstats(
        data = a,
        x = "group",
        y = "mean.a",
        results.subtitle = FALSE,
        messages = FALSE
      )

    # build
    pb <- ggplot2::ggplot_build(p)

    testthat::expect_identical(
      pb$data[[6]]$label,
      c("list(~italic(widehat(mu))== 0.98 )", "list(~italic(widehat(mu))== 1.39 )")
    )
  }
)

# checking if plot.type argument works --------------------------------------

testthat::test_that(
  desc = "checking if plot.type argument works",
  code = {
    testthat::skip_on_cran()

    # boxplot
    set.seed(123)
    p1 <-
      ggstatsplot::ggbetweenstats(
        data = ToothGrowth,
        x = supp,
        y = len,
        type = "bf",
        pairwise.comparisons = TRUE,
        plot.type = "box",
        results.subtitle = FALSE,
        outlier.tagging = TRUE,
        bf.message = TRUE,
        outlier.coef = 0.75,
        outlier.color = "blue",
        mean.point.args = list(size = 5, color = "darkgreen"),
        mean.label.args = list(color = "blue"),
        messages = FALSE
      )

    # violin
    set.seed(123)
    p2 <-
      ggstatsplot::ggbetweenstats(
        data = ToothGrowth,
        x = supp,
        y = len,
        results.subtitle = FALSE,
        effsize.noncentral = FALSE,
        plot.type = "violin",
        outlier.tagging = TRUE,
        outlier.coef = 0.75,
        outlier.color = "blue",
        bf.message = FALSE,
        mean.plotting = FALSE,
        sample.size.label = FALSE,
        package = "wesanderson",
        palette = "Royal1",
        messages = FALSE
      ) +
      ggplot2::scale_y_continuous(breaks = seq(0, 30, 5))

    # build the plots
    pb1 <- ggplot2::ggplot_build(p1)
    pb2 <- ggplot2::ggplot_build(p2)

    # tests for labels
    testthat::expect_null(pb1$plot$labels$subtitle, NULL)
    testthat::expect_null(pb1$plot$labels$caption, NULL)
    testthat::expect_null(pb2$plot$labels$caption, NULL)
    testthat::expect_identical(length(pb1$data), 5L)
    testthat::expect_identical(length(pb1$data), 5L)
    testthat::expect_identical(length(pb2$data), 4L)
    testthat::expect_identical(
      unique(pb1$data[[1]]$colour),
      c("#D95F02FF", "#1B9E77FF")
    )
    testthat::expect_identical(
      unique(pb2$data[[1]]$colour),
      c("#C93312FF", "#899DA4FF")
    )

    # dims for data
    testthat::expect_equal(dim(pb1$data[[1]]), c(58L, 13L))
    testthat::expect_equal(dim(pb1$data[[2]]), c(2L, 26L))
    testthat::expect_equal(dim(pb1$data[[4]]), c(2L, 13L))
    testthat::expect_equal(dim(pb1$data[[2]]), c(2L, 26L))
    testthat::expect_equal(dim(pb1$data[[4]]), c(2L, 13L))
    testthat::expect_equal(dim(pb2$data[[1]]), c(58L, 13L))
    testthat::expect_equal(dim(pb2$data[[2]]), c(2L, 10L))
    testthat::expect_equal(dim(pb2$data[[3]]), c(1024L, 21L))

    # checking geom data
    testthat::expect_equal(
      pb1$data[[2]],
      structure(
        list(
          ymin = c(8.2, 4.2),
          lower = c(15.525, 11.2),
          middle = c(
            22.7,
            16.5
          ),
          upper = c(25.725, 23.1),
          ymax = c(30.9, 29.5),
          outliers = list(numeric(0), c(33.9, 32.5)),
          notchupper = c(
            25.6423655789178,
            19.9327598420707
          ),
          notchlower = c(19.7576344210822, 13.0672401579293),
          x = c(1, 2),
          flipped_aes = c(FALSE, FALSE),
          PANEL = structure(c(
            1L,
            1L
          ), .Label = "1", class = "factor"),
          group = 1:2,
          ymin_final = c(
            8.2,
            4.2
          ),
          ymax_final = c(30.9, 33.9),
          xmin = c(0.85, 1.85),
          xmax = c(
            1.15,
            2.15
          ),
          xid = c(1, 2),
          newx = c(1, 2),
          new_width = c(0.3, 0.3),
          weight = c(1, 1),
          colour = c("grey20", "grey20"),
          fill = c(
            "white",
            "white"
          ),
          size = c(0.5, 0.5),
          alpha = c(0.2, 0.2),
          shape = c(
            19,
            19
          ),
          linetype = c("solid", "solid")
        ),
        row.names = c(NA, -2L),
        class = "data.frame"
      )
    )

    testthat::expect_equal(
      pb1$data[[3]],
      structure(
        list(
          x = c(2L, 2L),
          y = c(33.9, 32.5),
          label = c(
            33.9,
            32.5
          ),
          PANEL = structure(c(1L, 1L), .Label = "1", class = "factor"),
          group = structure(c(1L, 1L), n = 1L),
          colour = c(
            "black",
            "black"
          ),
          fill = c("white", "white"),
          size = c(3, 3),
          angle = c(
            0,
            0
          ),
          alpha = c(NA, NA),
          family = c("", ""),
          fontface = c(
            1,
            1
          ),
          lineheight = c(1.2, 1.2),
          hjust = c(0.5, 0.5),
          vjust = c(
            0.5,
            0.5
          )
        ),
        row.names = c(NA, -2L),
        class = "data.frame"
      )
    )

    testthat::expect_equal(
      pb1$data[[4]],
      structure(
        list(
          x = 1:2,
          group = 1:2,
          y = c(
            20.6633333333333,
            16.9633333333333
          ),
          ymin = c(NA_real_, NA_real_),
          ymax = c(
            NA_real_,
            NA_real_
          ),
          PANEL = structure(c(1L, 1L), .Label = "1", class = "factor"),
          flipped_aes = c(FALSE, FALSE),
          shape = c(19, 19),
          colour = c(
            "darkgreen",
            "darkgreen"
          ),
          size = c(5, 5),
          fill = c(NA, NA),
          alpha = c(
            NA,
            NA
          ),
          stroke = c(0.5, 0.5)
        ),
        row.names = c(NA, -2L),
        class = "data.frame"
      )
    )

    testthat::expect_equal(
      pb1$data[[5]],
      structure(
        list(
          x = 1:2,
          y = c(20.6633333333333, 16.9633333333333),
          label = c(
            "list(~italic(widehat(mu))== 20.66 )",
            "list(~italic(widehat(mu))== 16.96 )"
          ),
          PANEL = structure(c(1L, 1L), class = "factor", .Label = "1"),
          group = structure(1:2, n = 2L),
          colour = c("blue", "blue"),
          fill = c("white", "white"),
          size = c(3.88, 3.88),
          angle = c(0, 0),
          alpha = c(NA, NA),
          family = c("", ""),
          fontface = c(1, 1),
          lineheight = c(1.2, 1.2),
          hjust = c(0.5, 0.5),
          vjust = c(0.5, 0.5)
        ),
        row.names = c(NA, -2L),
        class = "data.frame"
      )
    )

    testthat::expect_equal(
      pb2$data[[2]],
      structure(
        list(
          y = c(33.9, 32.5),
          x = c(2L, 2L),
          PANEL = structure(c(1L, 1L), class = "factor", .Label = "1"),
          group = structure(c(1L, 1L), n = 1L),
          shape = c(19, 19),
          colour = c("blue", "blue"),
          size = c(3, 3),
          fill = c(NA, NA),
          alpha = c(0.7, 0.7),
          stroke = c(0, 0)
        ),
        row.names = c(NA, -2L),
        class = "data.frame"
      )
    )

    testthat::expect_equal(
      pb2$data[[4]],
      structure(
        list(
          y = c(33.9, 32.5),
          x = c(2L, 2L),
          label = c(
            33.9,
            32.5
          ),
          PANEL = structure(c(1L, 1L), class = "factor", .Label = "1"),
          group = structure(c(1L, 1L), n = 1L),
          colour = c("black", "black"),
          fill = c("white", "white"),
          size = c(3, 3),
          angle = c(0, 0),
          alpha = c(NA, NA),
          family = c("", ""),
          fontface = c(1, 1),
          lineheight = c(1.2, 1.2),
          hjust = c(0.5, 0.5),
          vjust = c(0.5, 0.5)
        ),
        row.names = c(NA, -2L),
        class = "data.frame"
      )
    )
  }
)

# ggplot component addition works ------------------------------------------

testthat::test_that(
  desc = "ggplot component addition works",
  code = {
    testthat::skip_on_cran()

    # plot
    p <-
      ggstatsplot::ggbetweenstats(
        data = iris,
        x = Species,
        y = Sepal.Length,
        results.subtitle = FALSE,
        messages = FALSE,
        ggplot.component = ggplot2::labs(y = "SL")
      )

    # build plot
    pb <- ggplot2::ggplot_build(p)

    # test
    testthat::expect_identical(p$labels$y, "SL")
  }
)

# subtitle output works ------------------------------------------------

testthat::test_that(
  desc = "subtitle output works",
  code = {
    testthat::skip_on_cran()

    # plot
    set.seed(123)
    subtitle_exp <-
      ggstatsplot::ggbetweenstats(
        data = mtcars,
        x = am,
        y = wt,
        output = "subtitle",
        messages = FALSE
      )

    set.seed(123)
    sub <-
      statsExpressions::expr_t_parametric(
        data = mtcars,
        x = am,
        y = wt,
        output = "subtitle",
        messages = FALSE
      )

    # test
    testthat::expect_identical(subtitle_exp, sub)
  }
)
