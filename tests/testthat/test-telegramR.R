
test_that("multiplication works", {
  html2df("~/Downloads/Telegram Desktop/ChatExport_2023-12-16/messages.html") |>
  testthat::expect_s3_class("data.frame")
})
