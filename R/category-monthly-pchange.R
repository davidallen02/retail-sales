dat <- pamngr::join_sheets(c("rsbaauto",
                             # "rsbafurn",
                             "rsbaelec",
                             "rsbabuil",
                             "rsbafood",
                             "rsbahlth",
                             "rsbagas",
                             "rsbaclot",
                             "rsbaspor",
                             "rsbagenl",
                             "rsbamisc",
                             "rsbanons",
                             "rsbafdsv")) %>%
  reshape2::melt(id.vars = "dates") %>%
  pamngr::pchange(k = 1) %>%
  dplyr::slice_max(dates, k = 18)

p <- dat %>%
  pamngr::barplot(fill = "variable") %>%
  pamngr::pam_plot(
    plot_title = "Retail Sales",
    plot_subtitle = "Monthly Percent Change",
    show_legend = FALSE
  )

p <- p + ggplot2::facet_wrap(. ~ variable, nrow = 4)