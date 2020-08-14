
dat <- pamngr::join_sheets(c("rsbanons","rstatotl")) %>%
  dplyr::mutate(share = rsbanons %>% 
                  magrittr::divide_by(rstatotl) %>% 
                  magrittr::multiply_by(100)) %>%
  dplyr::select(dates, share) %>%
  reshape2::melt(id.vars = "dates")

p <- dat %>%
  pamngr::lineplot() %>%
  pamngr::pam_plot(
    plot_title = "Nonstore Retail Sales",
    plot_subtitle = "Share of Total Retail Sales",
    show_legend = FALSE
  )

p %>% pamngr::all_output("nonstore-share")