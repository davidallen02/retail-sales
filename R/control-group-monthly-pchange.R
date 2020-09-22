dat <- pamngr::get_data("rstaxabg") %>%
  reshape2::melt(id.vars = "dates") %>%
  pamngr::pchange(k = 1) %>%
  dplyr::slice_max(dates, n = 36)

p <- dat %>%
  pamngr::barplot(fill = "variable") %>%
  pamngr::pam_plot(
    plot_title = "Retail Sales",
    plot_subtitle = "Control Group Monthly Percent Change",
    show_legend = FALSE
  )

p %>% pamngr::all_output("control-group-monthly-pchange")