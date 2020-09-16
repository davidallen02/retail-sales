key <- readRDS("data/key.RDS")

dat <- pamngr::join_sheets(c("rsbaauto",
                           "rsbafurn",
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
  dplyr::mutate(security = variable) %>%
  dplyr::left_join(key, by = "security") %>%
  dplyr::mutate(
    label = LONG_COMP_NAME %>%
      stringr::str_remove_all("Adjusted Retail Sales ") %>%
      stringr::str_remove_all("and Clothing Accessories") %>%
      stringr::str_remove_all("and Garden Supplies") %>%
      stringr::str_remove_all(" Dealers") %>%
      stringr::str_remove_all("Retailers") %>%
      stringr::str_remove_all("Stores") %>%
      stringr::str_remove_all("Store") %>%
      stringr::str_trim()
  ) %>%
  dplyr::select(dates, variable, value, label) %>%
  pamngr::pchange(k = 6) %>%
  dplyr::slice_max(dates, n = 1) %>%
  dplyr::mutate(dates = dates %>% as.character())

p <- dat %>%
  pamngr::barplot(x = "label", y  = "value", fill = "dates") %>%
  pamngr::pam_plot(
    plot_title = "Retail Sales",
    plot_subtitle = "Percent Change From January 2020",
    show_legend = FALSE
  ) 

p <- p + ggplot2::coord_flip()

p %>% pamngr::all_output("category-recovery")

