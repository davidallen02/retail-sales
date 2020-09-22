key <- pamngr::get_data("key") %>%
  dplyr::select(security, LONG_COMP_NAME) %>%
  dplyr::mutate(
    variable = security,
    name = LONG_COMP_NAME %>% stringr::str_remove_all("Adjusted Retail Sales ")
  ) %>%
  dplyr::select(variable, name)

dat <- pamngr::join_sheets(c("rsbaauto",
                             # "rsbafurn",
                             # "rsbaelec",
                             # "rsbabuil",
                             "rsbafood",
                             # "rsbahlth",
                             # "rsbagas",
                             # "rsbaclot",
                             # "rsbaspor",
                             "rsbagenl",
                             # "rsbamisc",
                             "rsbanons"
                             # "rsbafdsv"
                             )) %>%
  reshape2::melt(id.vars = "dates") %>%
  pamngr::pchange(k = 1) %>%
  dplyr::slice_max(dates, n = 4*12) %>%
  dplyr::left_join(key, by = "variable")

p <- dat %>%
  pamngr::barplot(x = "dates", y = "value", fill = "name") %>%
  pamngr::pam_plot(
    plot_title = "Retail Sales",
    plot_subtitle = "Monthly Percent Change",
    show_legend = FALSE
  )

p <- p + ggplot2::facet_wrap(. ~ name, nrow = 2, scales = "free_y")

p %>% pamngr::all_output("major-categories-monthly-pchange")