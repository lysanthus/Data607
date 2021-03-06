install.packages("XML")
install.packages("rvest")
library(XML)
library(rvest)
library(dplyr)

## Defining ZipRecruiter target URLs - Searching for Data Scientist JDs for 5 cities (Seattle, NYC, San Francisco, San Jose and Boston)
url_html_SEA <- c("https://www.ziprecruiter.com/candidate/search?search=Data+Scientist&location=Seattle%2C+WA&days=&radius=25&refine_by_salary=&refine_by_tags=&refine_by_title=Data+Scientist&refine_by_org_name=")
url_html_NYC <- c("https://www.ziprecruiter.com/candidate/search?search=Data+Scientist&location=New+York%2C+NY&days=&radius=25&refine_by_salary=&refine_by_tags=&refine_by_title=Data+Scientist&refine_by_org_name=")
url_html_SFO <- c("https://www.ziprecruiter.com/candidate/search?search=Data+Scientist&location=San+Francisco%2C+CA&days=&radius=25&refine_by_salary=&refine_by_tags=&refine_by_title=Data+Scientist&refine_by_org_name=")
url_html_SJO <- c("https://www.ziprecruiter.com/candidate/search?search=Data+Scientist&location=San+Jose%2C+CA&days=&radius=25&refine_by_salary=&refine_by_tags=&refine_by_title=Data+Scientist&refine_by_org_name=")
url_html_BOS <- c("https://www.ziprecruiter.com/candidate/search?search=Data+Scientist&location=Boston%2C+MA&days=&radius=25&refine_by_salary=&refine_by_tags=&refine_by_title=Data+Scientist&refine_by_org_name=")

## Loading target URLs into a vector
url_master <- rbind(url_html_NYC, url_html_SFO, url_html_SJO, url_html_BOS, url_html_SEA)
## Loading target URLs city by city to get around the 410 error generated from ZipRecruiter page after scraping certain number or JDs
url_master <- url_html_NYC
url_master <- url_html_SEA
url_master <- url_html_SFO
url_master <- url_html_SJO
url_master <- url_html_BOS

## Initializing final JD Repository
job_desc_cty_all <- data.frame("","")
colnames(job_desc_cty_all) <- c("job_city","job_desc")

## Defining loop parsing the result target pages and getting the list of corresponding individual JD pages

  for (ii in 1:length(url_master)){
    html_file_master <- read_html(url_master[ii])
    job_links_html <- html_nodes(html_file_master, xpath = '//div/a[@class="job_link t_job_link"]')
    job_links <- html_attr(job_links_html, "href")
  
## Defining the loop parsing the individual JD pages, extracting  and storing the JD details  
    for (i in 1:length(job_links)){
      html_link <- job_links[i]
      html_file <- read_html(html_link)
      job_city_temp <- html_nodes(html_file, xpath = '//meta[@name="geo.placename"]')
      job_city <- html_attr(job_city_temp, "content")
      job_city <- paste(job_city, collapse=" ") ## Accounting for potential null nodes for city
      job_desc_temp <- html_nodes(html_file, xpath = '//div[@class="jobDescriptionSection"]')
      job_desc <- html_text(job_desc_temp)
      job_desc <- paste(job_desc, collapse=" ") ## Accounting for potential null/variable nodes containing the JD
      job_desc_cty <- data.frame(job_city, job_desc)
      job_desc_cty_all <- rbind(job_desc_cty_all, job_desc_cty)
    }
  }

## Number of JDs parsed and stored
nrow(job_desc_cty_all)
## Filtering empty JDs
job_desc_cty_final <- filter(job_desc_cty_all, job_desc!="")
nrow(job_desc_cty_final)
## Writing the results into a file
setwd("C:/DATA/HHP/Personal/Degrees/Ms. Data Science (CUNY)/R Working Dir")
write.csv(job_desc_cty_final, file = "DS_JDs_ZipRecruiter_Upd_City.xls" )

