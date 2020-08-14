
dat <- pamngr::join_sheets(c("rsbanons","rstatotl")) %>%
  dplyr::mutate(share = rsbanons %>% 
                  magrittr::divide_by(rstatotl) %>% 
                  magrittr::multiply_by(100)) %>%
  dplyr::select(dates, share)

p <- dat %>%
  pamngr::lineplot() %>%
  pamngr::pam_plot(
    plot_title = "Nonstore Retail Sales",
    plot_subtitle = "Share of Total Retail Sales"
  )

p %>% pamngr::all_output("nonstore-share")

# nonstore <- readxl::read_excel(path = "./data.xlsx", sheet  = "rsbanons", skip = 2)
# total <- readxl::read_excel(path = "./data.xlsx", sheet = "rstatotl", skip = 2)
# 
# nonstore <- nonstore %>%
#   dplyr::left_join(total, by = "Dates") %>%
#   set_colnames(c("dates", "nonstore","total")) %>%
#   dplyr::mutate(
#     share = nonstore %>% divide_by(total) %>% multiply_by(100)
#   ) %>%
#   dplyr::select(c("dates", "share"))
# 
# p <- nonstore %>%
#   ggplot2::ggplot(ggplot2::aes(dates, share)) +
#   ggplot2::geom_line(size = 2, color = "#850237") +
#   ggplot2::labs(
#     title = "Nonstore Retail Sales",
#     subtitle = "Share of Total Retail Sales"
#   ) +
#   ggplot2::theme(
#     plot.title = ggplot2::element_text(face = "bold", size = ggplot2::rel(3.25)),
#     plot.subtitle = ggplot2::element_text(size = ggplot2::rel(2)),
#     legend.title = ggplot2::element_blank(),
#     legend.text = ggplot2::element_text(size = ggplot2::rel(1.5)),
#     legend.position = "bottom",
#     axis.title = ggplot2::element_blank(),
#     axis.text = ggplot2::element_text(size = ggplot2::rel(1.5))
#   )
# 
# ggplot2::ggsave(
#   filename = "nonstore-share.png",
#   plot     = p,
#   width    = 13.33,
#   height   = 7.5,
#   units    = 'in'
# )