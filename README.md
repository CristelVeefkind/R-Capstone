# R-Capstone

## Coursera Data Science Capstone Project
The Coursera Data Science Specialization Capstone project from Johns Hopkins University (JHU) allows 
students to create a usable public data product that can show their skills to potential 
employers. Projects are drawn from real-world problems and are conducted with industry, government, 
and academic partners. In this part of course JHU is partnering with SwiftKey 
(https://swiftkey.com/) to apply data science in the area of natural language processing.

## Next word prediction app (using N-gram models)
- based on N-gram model with "Stupid Backoff" ([Brants et al 2007](http://www.cs.columbia.edu/~smaskey/CS6998-0412/supportmaterial/langmodel_mapreduce.pdf))
- checks if highest-order (in this case, n=4) n-gram has been seen. If not "degrades" to a lower-order model (n=3, 2);

### The project consisted on several parts:
  1. Getting and cleaning the data
  2. Exploratory Data Analysis
  3. Building n-gram model
  4. Building predictive model
  5. Evaluating the model
  6. Building shiny app
  
### How to run the code:
Before running the shiny app server, you need to build your prediction model first. In order to do this just go to the "scripts" folder, configure "config.r" and run "run.r"
**@need_to_update**

### Additional information
All R scripts, files, presentations etc. in this repository are materials for the capstone project of the Coursera Data Science specialization held by professors of the Johns Hopkins University and in cooperation with SwiftKey.


- The next word prediction app is hosted on shinyapps.io: @todo
- The same app is also hosted on my private shiny server: @todo
- The whole code of this application, as well as all related scripts, milestone report and this presentation can be found in my Github repo: 
[https://github.com/Scitator/R-Capstone](https://github.com/Scitator/R-Capstone)
- This pitch deck with a short presentation for the capstone application is located here: @todo
- Learn more about the Coursera Data Science Specialization: [https://www.coursera.org/specialization/jhudatascience](https://www.coursera.org/specialization/jhudatascience)