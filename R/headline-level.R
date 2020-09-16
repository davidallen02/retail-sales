pamngr::get_data("rstatotl") %>%
  reshape2::melt(id.vars = "dates") %>%
  dplyr::slice_max(dates, n = 36) %>%
  pamngr::lineplot() %>%
  pamngr::pam_plot(
    plot_title = "Retail Sales",
    plot_subtitle = "Billions of USD",
    show_legend = FALSE
  ) %>%
  pamngr::all_output("headline-level")


