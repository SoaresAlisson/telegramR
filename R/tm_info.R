#' returns a dataframe with general info
#'
#' @details insert on folder with html from exported chats of telegram and recieve a dataframe with info such as first date and last date of each html
#' @param file CHAR. The folder where html exported from Telegram are located
#' @examples
#' get_data("~/Downloads/Telegram Desktop/ChatExport_2023-12-16/messages.html")
#'
get_data <- function(file){
  # message("Processing: \"", file,"\" ")
  typeof(file)
  html.page <- file |> rvest::read_html()

  name <- html.page |> rvest::html_elements( ".text.bold") |> rvest::html_text() %>% gsub("\\n","",.)  %>% gsub("^( )+|( )+$", "",.)
  userpic <- html.page %>% rvest::html_elements(css = ".userpic") %>% rvest::html_attr('src') %>% sort %>% paste(., collapse = " ")
  details <- html.page %>% rvest::html_elements(".details") %>% rvest::html_text() %>% gsub("\\n","",.)   %>% gsub("\\n|\\t","",.) %>% gsub("^( )+|( )+$", "",.)
  dates <- details %>% grep("\\d{1,2} [A-Z][a-z]+ \\d{4}", ., value = T) %>%
    readr::parse_date(., format = "%d %B %Y", na = c("", "NA"),
                      locale = readr::locale("en"), trim_ws = TRUE)
  FirstDate <- range(dates)[1]
  LastDate <- range(dates)[2]

  #df2 <- data.frame(HTMLName = file , name, UserPics = userpic, FirstDate, LastDate)
  df2 <- tibble::tibble(HTMLName = file , name, UserPics = userpic, FirstDate, LastDate)

  return(df2)
}



#' return general information
#'
#' @param folders CHAR. a folder or vector of folders with telegram exported HTML files
#' @export
#' @example
#' tm_info("path/to/folder/")
#'
tm_info <- function(folders){

DF <- tibble::tibble()

		for (i_folder in folders){
		  #  i_folder = "~/Documentos/Programação/data/politica/poder360/ChatExport_2024-05-08_poder360"
		  # if the path did not contain the final bar
		  if(!grepl("\\/$", i_folder)) i_folder <- paste0(i_folder, "/")
      if (! file.exists(i_folder)) {
        paste("The folder/path did not exists:", i_folder) |> stop()
        }

		  HTMLFiles <- list.files(i_folder, pattern = "*.html", recursive = T)
		  temp_file_name <- paste0(i_folder, HTMLFiles)
  			  for (i_file in temp_file_name){
  				DF = dplyr::bind_rows(DF, get_data(i_file))
  			  }
		  DF <- dplyr::arrange(DF, name, FirstDate)
		}

		return(DF)
}


#' filter dataframe to show only the last exports of each chat/group
#'
#' @param DF the tibble/dataframe generated with `tm_info()` or `dir2df()` functions
#'
#' @export
#' @examples
#' tm_info("~/Downloads/Telegram Desktop/") |> filter_last_export()
filter_last_export <- function(DF){
  testColumnName <- names(DF) %in% "Chat_Name" |> any()

  if (testColumnName) {
    # if from dir2df
    DF |> dplyr::group_by(Chat_Name) |>
      subset(!is.na(date_time)) |>
      dplyr::summarise(LastDate = last(date_time))
  } else{
    # if from tm_info()
    DF |> dplyr::group_by(name) |>
      dplyr::summarise(LastDate = max(LastDate))
  }
}
