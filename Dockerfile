# Base image có R + Shiny
FROM rocker/shiny:latest

# Cài thêm package cần thiết trong R (nếu chưa có)
RUN R -e "install.packages(c('shiny', 'shinythemes', 'ggplot2', 'DT', 'dplyr'), repos='https://cloud.r-project.org')"

# Tạo thư mục cho app
WORKDIR /srv/shiny-server/app

# Copy tất cả file vào container
COPY . .

# Mở port 3838 cho Shiny Server
EXPOSE 3838

# Chạy app Shiny
CMD ["R", "-e", "shiny::runApp('/srv/shiny-server/app', host='0.0.0.0', port=3838)"]
