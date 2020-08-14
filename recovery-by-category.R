percent_from_earliest <- function(x){
  
  start_value <- x[1]
  y <- (x/start_value) - 1
  y <- y * 100
  
  return(y)
}

key <- readRDS("data/key.RDS")

# rename_columns <- function(x){ 
#   data.frame(security = x) %>%
#     dplyr::left_join(readxl::read_xlsx("data.xlsx", sheet = "key"), by = "security") %>%
#     dplyr::select(name) %>%
#     dplyr::pull() %>% 
#     as.character() %>%
#     stringr::str_remove_all("Adjusted Retail Sales ") %>%
#     stringr::str_remove_all("and Clothing Accessories") %>%
#     stringr::str_remove_all("and Garden Supplies") %>%
#     stringr::str_remove_all(" Dealers") %>%
#     stringr::str_remove_all("Retailers") %>%
#     stringr::str_remove_all("Stores") %>%
#     stringr::str_remove_all("Store") %>%
#     stringr::str_trim() %>%
#     stringr::str_replace_all(" ", "-") %>%
#     stringr::str_to_lower()
# }

dat <- pamngr::join_sheets(c("rsbaauto",
                           # "rsbafelc",
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
  dplyr::filter(dates >= as.POSIXct("2020-01-01")) %>%
  pamngr::pchange(k = 6)
  dplyr::slice_max(dates, n = 1)
  # reshape2::melt(id.vars = "dates") %>%
  # dplyr::mutate(names = variable %>% 
  #                 stringr::str_replace_all("-", " ") %>% 
  #                 stringr::str_to_title())

p <- dat %>%  
  pamngr::barplot(x = "names", y  = "value", fill = "dates") %>%
  pamngr::pam_plot(
    plot_title = "Retail Sales",
    plot_subtitle = "Percent Change From January 2020"
  ) %>%
  ggplot2::coord_flip()
  # ggplot2::ggplot(ggplot2::aes(names, value)) +
  # ggplot2::geom_bar(stat = "identity", fill = "#850237") +
  # ggplot2::coord_flip() 

p %>% pamngr::all_output("category-recovery")

