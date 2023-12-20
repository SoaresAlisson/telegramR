#' convert the the HTML into tibble/dataframe
#'
#' @details from html file of the exported chats of telegram, get a dataframe with chat name, message id, date time, user name, text and link to audio/video`
#'
#' @param html_file the HTML file path
#' @export
#' @examples
#' html2df("~/Downloads/Telegram Desktop/ChatExport_2023-12-16/messages.html")
#'
html2df <- function(html_file){
  HTMLpage <- rvest::read_html(html_file)
  #nome_grupo <- HTMLpage  %>% html_element('.text.bold') %>% html_text %>% stringr::str_squish()
  ChatName <- HTMLpage  |> rvest::html_element('.page_header .text') |> rvest::html_text() |> stringr::str_squish()

  #posts <- html_elements(HTMLpage, '.body')
  posts <- rvest::html_elements(HTMLpage, '.clearfix')
  msgId <- HTMLpage|> rvest::html_elements(".clearfix") |> rvest::html_attr("id") |> gsub2("message(.*)", "\\1")
  post.nome <- rvest::html_element(posts, ".from_name") |> rvest::html_text() |> stringr::str_squish()
  # retirando os encaminhados, para evitar duplicação na tabela)
  #post.text <- rvest::html_text(posts) %>% stringr::str_squish() TODO- aqui ha mais info do que na linha abaixo. recuperar esta info em nova coluna
  post.text <- posts |> rvest::html_element(".body .text") |> rvest::html_text2() %>% stringr::str_squish()
  #post.text <- ifelse(!is.na(html_element(posts, ".forwarded.body")),
  #          "<forwarded content>", # se o post encaminhar conteudo de outro, terá este valor
  #         post.text <- html_text(posts) %>% stringr::str_squish())
  #post.imagens.thumb <- html_element(posts, ".clearfix") %>% html_element(".photo") %>% html_attr("src")
  #post.audioVideoImg <- html_element(posts, ".clearfix.pull_left") %>% html_attr("href")
  rvest::html_element(posts,".details")
  post.audioVideoImg <- ifelse(!is.na(rvest::html_element(posts, ".forwarded.body")),
                               "<forwarded content>", # se o post encaminhar conteudo de outro, terá este valor
                               rvest::html_element(posts, ".clearfix.pull_left") |> rvest::html_attr("href")
  )
  post.dataHora <- rvest::html_element(posts, ".date") |> rvest::html_attr("title") |> lubridate::dmy_hms()

   tibble::tibble(
      Chat_Name = ChatName,
      msg_Id = msgId,
      date_time = post.dataHora,
      user_name = post.nome,
      text = post.text,
      Audio_Video_image = post.audioVideoImg
    ) %>%
     #filter( is.na(user_name)) %>%
    return()
  }



#' read files from a path and converts all its HTML into one tibble
#'
#' @details given a folder, reads all the HTML files and returns a single tibble
#'
#' @param folder CHAR. The directory/folder/path to the HTML files
#' @param recursive BOOL. Will the . Default = TRUE
#' @export
#' @examples
#' dir2df( "~/Downloads/Telegram Desktop/ChatExport_2023-12-16 (1)" )
dir2df <- function(folder, recursive = TRUE){
  allfiles <- list.files(folder, pattern = "html$", full.names = TRUE, recursive = recursive)
  lapply(allfiles, html2df) |> dplyr::bind_rows() %>%
    return()
}
