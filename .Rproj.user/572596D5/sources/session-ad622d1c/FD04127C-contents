server <- function(input, output, session) {
  
  rv <- reactiveVal(data)
  triggerHistoryReload <- reactiveVal(0)  # để reload bảng lịch sử khi cần
  
  plotData <- eventReactive(input$draw, {
    rv()
  })
  
  output$plotOutput <- renderPlot({
    req(plotData())
    df <- plotData()
    
    if (input$plotType == "Scatter Plot") {
      ggplot(df, aes(x = tenure, y = MonthlyCharges)) +
        geom_point(color = "red") +
        geom_smooth(method = "lm", se = FALSE, color = "blue") +
        theme_minimal()
      
    } else if (input$plotType == "Residual Plot") {
      model <- lm(MonthlyCharges ~ tenure, data = df)
      residuals <- resid(model)
      fitted <- fitted(model)
      
      ggplot(data.frame(fitted, residuals), aes(x = fitted, y = residuals)) +
        geom_point(color = "green") +
        geom_hline(yintercept = 0, linetype = "dashed") +
        theme_minimal()
      
    } else if (input$plotType == "Histogram") {
      ggplot(df, aes(x = tenure)) +
        geom_histogram(fill = "skyblue", bins = 30, color = "black") +
        theme_minimal()
    }
  })
  observeEvent(input$clearHistory, {
    # Ghi đè file lịch sử thành file trống (chỉ còn header)
    write.csv(data.frame(Time = character(), Action = character(), Detail = character()),
              "history_log.csv", row.names = FALSE)
    
    triggerHistoryReload(triggerHistoryReload() + 1)  # cập nhật bảng
    
    showModal(modalDialog(
      title = "Đã xóa lịch sử",
      "Toàn bộ lịch sử đã được xóa thành công!",
      easyClose = TRUE
    ))
  })
  
  output$dataTable <- DT::renderDataTable({
    DT::datatable(rv(),
                  options = list(pageLength = 10, selection = 'single'),
                  rownames = FALSE,
                  editable = TRUE)
  }, server = FALSE)
  
  # Ghi log
  writeLog <- function(action, detail) {
    log_entry <- data.frame(Time = Sys.time(), Action = action, Detail = detail)
    write.table(log_entry, "history_log.csv", sep = ",", append = TRUE, col.names = FALSE, row.names = FALSE)
    triggerHistoryReload(triggerHistoryReload() + 1)  # reload bảng lịch sử
  }
  
  # Sửa dữ liệu
  observeEvent(input$dataTable_cell_edit, {
    info <- input$dataTable_cell_edit
    df <- rv()
    old_value <- df[info$row, info$col]
    df[info$row, info$col] <- info$value
    rv(df)
    
    # Ghi log
    detail <- paste0("Sửa dòng ", info$row, ", cột ", names(df)[info$col],
                     ": từ '", old_value, "' thành '", info$value, "'")
    writeLog("Sửa ô", detail)
  })
  
  # Thêm dòng
  observeEvent(input$addRow, {
    df <- rv()
    new_row <- as.list(rep(NA, ncol(df)))
    df <- rbind(df, new_row)
    rv(df)
    
    # Ghi log
    detail <- paste0("Thêm dòng mới ở vị trí ", nrow(df))
    writeLog("Thêm dòng", detail)
  })
  
  # Xóa dòng
  observeEvent(input$deleteRow, {
    selected <- input$dataTable_rows_selected
    if (length(selected)) {
      df <- rv()
      deleted_rows <- selected
      df <- df[-selected, ]
      rv(df)
      
      # Ghi log
      detail <- paste0("Xóa dòng số ", paste(deleted_rows, collapse = ", "))
      writeLog("Xóa dòng", detail)
    }
  })
  
  # Lưu dữ liệu
  observeEvent(input$saveData, {
    write.csv(rv(), "Updated_Telco-Customer-Churn.csv", row.names = FALSE)
    showModal(modalDialog(
      title = "Thông báo",
      "Dữ liệu đã được lưu vào file 'Updated_Telco-Customer-Churn.csv'!",
      easyClose = TRUE
    ))
    
    # Ghi log
    writeLog("Lưu dữ liệu", "Lưu toàn bộ dữ liệu ra file 'Updated_Telco-Customer-Churn.csv'")
  })
  
  # Hiển thị bảng lịch sử
  output$historyTable <- DT::renderDataTable({
    triggerHistoryReload()  # để lắng nghe thay đổi
    history <- read.csv("history_log.csv", stringsAsFactors = FALSE)
    
    DT::datatable(history,
                  options = list(pageLength = 10),
                  rownames = FALSE)
  })
  observeEvent(input$clearHistory, {
    # Ghi đè file lịch sử thành file trống (chỉ còn header)
    write.csv(data.frame(Time = character(), Action = character(), Detail = character()),
              "history_log.csv", row.names = FALSE)
    
    triggerHistoryReload(triggerHistoryReload() + 1)  # cập nhật bảng
    
    showModal(modalDialog(
      title = "Đã xóa lịch sử",
      "Toàn bộ lịch sử đã được xóa thành công!",
      easyClose = TRUE
    ))
  })
  
}
