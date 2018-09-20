# CANSIM-dataviewer

This repo contains the code for the extraction, tabulation, and visualisation of data from Statistics Canada's CANSIM database.

The data presented here are tailored for users in British Columbia.

The repo contains the code, written in [R](https://cran.r-project.org/), including for applications using the [Shiny package](https://shiny.rstudio.com/).


---

### Data series

These pages contain links to data sources and related reference materials at Statistics Canada, and to the R scripts developed for extracting, tabulating, and viewing those data.

* [Consumer Price Index](doc/CPI-datasources.Rmd)

* [Labour Force Survey](doc/LFS-datasources.Rmd)

* [Manufacturing (Monthly Survey of Manufacturing)](doc/Manufacturing.Rmd)

* [New Housing Price Index](doc/NHPI-datasources.Rmd)

* [Wholesale Trade](https://github.com/bcgov/CANSIM-dataviewer/blob/master/doc/WholesaleTrade-datasources.Rmd)




---

### more about CANSIM

[CANSIM](http://www5.statcan.gc.ca/cansim/a01?lang=eng) is Statistics Canada's repository of socio-economic data.

* CANSIM [table directory, by subject](http://www5.statcan.gc.ca/cansim/a29?lang=eng&p2=17)


[CANSIM](http://www5.statcan.gc.ca/cansim/a01?lang=eng&p2=1) is the comprehensive database of socio-economic statistics, maintained by Statistics Canada. The database contains a wide variety of data series, from the familiar ([unemployment rates from the Labour Force Survey](http://www5.statcan.gc.ca/cansim/a26?lang=eng&retrLang=eng&id=2820087&&pattern=&stByVal=1&p1=1&p2=31&tabMode=dataTable&csid=) and the [Consumer Price Index](http://www5.statcan.gc.ca/cansim/a26?lang=eng&retrLang=eng&id=3260020&&pattern=&stByVal=1&p1=1&p2=31&tabMode=dataTable&csid=)) to more obscure topics (total sales by vending machine operators; vector v101256214 in Table 080-0028).


**CANSIM tutorials**

- Statistics Canada has a [short step-by-step tutorial](http://www.statcan.gc.ca/about-apercu/video/cansim-trans-eng.html) on finding and saving data from CANSIM.

- The University of Toronto Map & Data Library has created a [CANSIM guide](http://data.library.utoronto.ca/cansim-guide), helping you navigate through the system to find the series you are seeking.




---

### CANSIM meets R

- [doc/interactiveDataVisual.Rmd](interactiveDataVisual.Rmd) & [doc/interactiveDataVisual.nb.html](interactiveDataVisual.nb.html) -- R Notebook and HTML file detailing the code in the `LFS_UR` script file.

View the HTML file online [here](https://cdn.rawgit.com/bcgov/CANSIM-data-viewer/6d049cf9e919912f8fd185dc4b8e025671d61ae3/interactiveDataVisual.nb.html).


- ** `CANSIM2R` **

* Some of these R scripts rely on the [`CANSIM2R`](https://cran.r-project.org/web/packages/CANSIM2R/index.html) package, developed by [Marco Lugo Rodriguez](https://www.linkedin.com/in/marcolugo).




---

### Fork

An original R-Shiny app from @najsaqib [LFSDataViewer](https://github.com/najsaqib/LFSDataViewer)

Shiny application link: https://najsaqib.shinyapps.io/LFSApp/

---

### Project Status

### Getting Help or Reporting an Issue

To report bugs/issues/feature requests, please file an [issue](https://github.com/bcgov/%3Crepo-name%3E/issues/).

### How to Contribute

If you would like to contribute, please see our [CONTRIBUTING](CONTRIBUTING.md) guidelines.

Please note that this project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree to abide by its terms.

### License: Scripts and Applications

    Copyright 2017 Province of British Columbia

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at 

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

### License: Data

Data downloaded and/or saved in this repository is sourced from Statistics Canada, and is covered under the [Statistics Canada Open Licence Agreement](http://www.statcan.gc.ca/eng/reference/licence).

---

This repository is maintained by [BC Stats](http://www.bcstats.gov.bc.ca). Click [here](https://github.com/bcgov/BCStats) for a complete list of our repositories on GitHub.
