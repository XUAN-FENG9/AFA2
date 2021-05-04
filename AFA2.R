#AFA group assignment
library('tidyverse')

complaint<-read.csv('D:/complaints.csv') #download the database
complaint<-complaint[!is.na(complaint$Complaint.ID),] 
#delete NAs in the ID column (only 3 observations without state information, so useless)
complaint<-complaint[,-17] #delete the 'Consumer disputed?' column because all values are NAs
complaint$samedate<-ifelse(complaint$Date.received==complaint$Date.sent.to.company,1,0) 
#create a new variable that equals 1 if the complaint is received in the same date as the complaint sent, 0 not (means delay)
company<-as.data.frame(table(complaint$Company))
names(company)<-c('company','company_frequency')
complaint$Company<-factor(complaint$Company)
complaint<-merge(complaint,company,by.x = 'Company',by.y = 'company')
 
