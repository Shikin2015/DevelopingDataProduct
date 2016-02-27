library(ggplot2)
library(data.table)

function(input, output) {
  dt_dengue <- read.csv("Dengue.csv")
  
  output$data_table <- renderTable({
      ddat <- as.data.table(dt_dengue)
      dyear <- as.character(input$datayear)
      
      if (dyear == "2012"){ 
        # Return first 20 rows
        ddat <- ddat[ddat$Year =="2012"]
        head(ddat, 20)}
      else if (dyear == "2013"){
        ddat <- ddat[ddat$Year =="2013"]
        head(ddat, 20)}
      else if (dyear == "2014"){
        ddat <- ddat[ddat$Year =="2014"]
        head(ddat, 20)}
      else{
        ddat <- ddat[ddat$Year =="2015"]
        head(ddat, 20)}
    })
    
    output$data_plot <- renderPlot({
      ddat <- as.data.table(dt_dengue)
      dgraf <- as.character(input$grafA)
      
      if (dgraf == "By Year"){ 
        ddat.by.year <- ddat[,sum(Total_Cases),by=Year]
        names(ddat.by.year) <- c('Year','Total_Cases')
        grafA <- barplot(ddat.by.year$Total_Cases,names.arg=ddat.by.year$Year, main="Total Dengue Cases By Year", xlab="Year", ylab="Total Cases", ylim=c(0,250000),col="green")
        text(x = grafA, y = ddat.by.year$Total_Cases, label = ddat.by.year$Total_Cases, pos = 3, cex = 0.8, col = "blue")
      }
      else if (dgraf == "Top 10 States"){
        #data by state - top 10 state
        ddat.by.state <- ddat[,sum(Total_Cases),by=State]
        names(ddat.by.state) <- c('State','Total_Cases')
        ddat.top.10 <-  head(ddat.by.state[order(ddat.by.state$Total_Cases, decreasing = TRUE)], 10)
        
        grafB <- barplot(ddat.top.10$Total_Cases,names.arg=ddat.top.10$State, main="Top 10 Dengue Cases By States", xlab="State", ylab="Total Cases", ylim=c(0,250000),col="blue")
        ## Add text at top of bars
        text(x = grafB, y = ddat.top.10$Total_Cases, label = ddat.top.10$Total_Cases, pos = 3, cex = 0.8, col = "blue")
      }
      else {
        ddat.by.state <- ddat[,sum(Total_Cases),by=Year]
        ddat.state<-ddat[ddat$State=="Perlis" | ddat$State=="Sarawak" | ddat$State=="Terengganu" |ddat$State=="Johor"]
        ddat.state.count <- ddat.state[,sum(Total_Cases),by="Year,State"]
        names(ddat.state.count) <- c('year','state','total')
        
        ggplot(data=ddat.state.count, aes(x=factor(year), y=total, fill=state))+geom_bar(stat="identity",position="dodge")+labs(title="Comparison of Dengue Cases in 4 States", x="Year",y="Total Cases", fill="State")+theme_bw()
        
        }
    })
}