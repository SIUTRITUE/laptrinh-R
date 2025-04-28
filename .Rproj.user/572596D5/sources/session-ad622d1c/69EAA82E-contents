ui <- navbarPage(
  title = "PHÂN TÍCH DỮ LIỆU",
  theme = shinythemes::shinytheme("flatly"),
  
  # Tab Đăng nhập
  tabPanel("Đăng nhập",
           fluidPage(
             textInput("username", "Tài khoản:"),
             passwordInput("password", "Mật khẩu:"),
             actionButton("login", "Đăng nhập"),
             textOutput("login_message")
           )
  ),
  
  # Tab Vẽ Biểu Đồ (Ẩn khi chưa đăng nhập)
  tabPanel("Vẽ Biểu Đồ", 
           fluidPage(
             sidebarLayout(
               sidebarPanel(
                 selectInput("plotType", "Chọn loại biểu đồ:",
                             choices = c("Scatter Plot", "Residual Plot", "Histogram")),
                 actionButton("draw", "Vẽ Biểu Đồ")
               ),
               mainPanel(
                 plotOutput("plotOutput")
               )
             )
           ),
           value = "plot"  # Tab này chỉ hoạt động khi đăng nhập thành công
  ),
  
  # Tab Xem & Quản lý Dữ liệu (Ẩn khi chưa đăng nhập)
  tabPanel("Xem & Quản lý Dữ liệu", 
           fluidPage(
             h4("Bảng dữ liệu từ file CSV:"),
             actionButton("addRow", "➕ Thêm dòng mới"),
             actionButton("deleteRow", "🗑️ Xóa dòng đã chọn"),
             actionButton("saveData", "💾 Lưu dữ liệu"),
             br(), br(),
             DT::dataTableOutput("dataTable")
           ),
           value = "data"
  ),
  
  # Tab Xem Lịch Sử (Ẩn khi chưa đăng nhập)
  tabPanel("📜 Xem Lịch Sử",
           fluidPage(
             h4("Lịch sử chỉnh sửa dữ liệu:"),
             actionButton("clearHistory", "🗑️ Xóa toàn bộ lịch sử"),
             br(), br(),
             DT::dataTableOutput("historyTable")
           ),
           value = "history"
  )
)
