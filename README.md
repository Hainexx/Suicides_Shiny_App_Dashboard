# Suicides Over the World Control Dashboard 
The App is reachable at https://hainexx.shinyapps.io/Suicides_Shiny_App_Dashboard-master/.

Alternatively this Shiny App can be launched by installing the Shiny library on R typing in your console the following comands: 

`install.packages("shiny")`\
`library(shiny)` \
`runGitHub(repo = "Hainexx/Suicides_Shiny_App_Dashboard")`

Beware that every needed library will be automatically installed in your system without any further notice and loaded. The list of the needed packages can be found in *sessionInfo.txt*.

**Make sure** you've installed the latest version of *R == 4.0.5 (2021-03-31) -- "Shake and Throw"* or the code won't run.

## File Descprition
***main.R***: 
Here you can find the corpus of the code where all the data manipulation on the data set is done and a linear regression and its results are provided. An user-defined function is provided and the Rcpp function is implemented to speed up the code.

***app.R***: 
This is the core of the app containing the ui and server applications. All of the plots are directly written in the server function using the dataset created in *main.R*. 

***enlist.cpp***:
This is a C++ function that I implemented through the Rcpp library in my script to speed up my code.

***master.csv***:
the used dataset. Further references are provided below.

***about.md***: last page of the app directly written in md. 

***sessionInfo.txt***: information about loaded libraries and system specs.


## Getting Help

**Suicide Hotlines:**

To find suicide hotlines for your country, please view:

* https://en.wikipedia.org/wiki/List_of_suicide_crisis_lines 

Per l'Italia:
* [Telefonoamico](https://www.telefonoamico.it/prevenzione-suicidio/): 02 2327 2327 

If you are in the U.S. you can take use of the following prevention lines which are all *free*, *available 24/7*, and *confidential*:

* [National suicide prevention lifeline](https://suicidepreventionlifeline.org): 1-800-273-8255
* [Crisis text line](https://www.crisistextline.org): Text HOME to 741741
* [Lifeline web chat](https://suicidepreventionlifeline.org/chat/)



**References:**  

The data set used to create the dashboard can be found at:   

* https://www.kaggle.com/russellyates88/suicide-rates-overview-1985-to-2016 

and was compiled from data from the following sources: 

* United Nations Development Program. (2018). Human development index (HDI). Retrieved from http://hdr.undp.org/en/indicators/137506

* World Bank. (2018). World development indicators: GDP (current US$) by country: 1985 to 2016. Retrieved from http://databank.worldbank.org/data/source/world-development-indicators#

* [Szamil]. (2017). Suicide in the Twenty-First Century [dataset]. Retrieved from https://www.kaggle.com/szamil/suicide-in-the-twenty-first-century/notebook

* World Health Organization. (2018). Suicide prevention. Retrieved from http://www.who.int/mental_health/suicide-prevention/en/
