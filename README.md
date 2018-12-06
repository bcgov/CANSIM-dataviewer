# CANSIM-dataviewer

This repo contains the code for the extraction, tabulation, and visualisation of data from Statistics Canada's CANSIM database.

The data presented here are tailored for users in British Columbia.

The repo contains the code, written in [R](https://cran.r-project.org/), including for applications using the [Shiny package](https://shiny.rstudio.com/).


---

### Data series

These pages contain links to data sources and related reference materials at Statistics Canada, and to the R scripts developed for extracting, tabulating, and viewing those data.

* [Consumer Price Index (CPI)](doc/CPI-datasources.md)

* [Labour Force Survey (LFS)](doc/LFS-datasources.md)

* [Manufacturing (Monthly Survey of Manufacturing)](doc/Manufacturing.md)

* [New Housing Price Index (NHPI)](doc/NHPI-datasources.md)

* [Survey of Employment, Payrolls, and Hours (SEPH)](doc/SEPH-datasources.md) 

* [Wholesale Trade](doc/WholesaleTrade-datasources.md)




---

### more about CANSIM

CANSIM was the name of Statistics Canada's data repository; old habits die hard and we continue to refer to the socio-economic data that Statistics Canada disseminates through the portal as "CANSIM".

The database contains a wide variety of data series, from the familiar ([unemployment rates from the Labour Force Survey](https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=1410028703)) and the [Consumer Price Index](https://www150.statcan.gc.ca/n1/en/type/data?text=cpi)) to more obscure topics ([total sales by vending machine operators; vector v101256214](https://www150.statcan.gc.ca/t1/tbl1/en/sbv.action?vectorNumbers=v101256214&searchOption=2&latestN=1)).


**CANSIM tutorials**

_Note: these may not reflect the latest changes to Statistics Canada's website_

- Statistics Canada has a [short step-by-step tutorial](http://www.statcan.gc.ca/about-apercu/video/cansim-trans-eng.html) on finding and saving data from CANSIM.

- The University of Toronto Map & Data Library has created a [CANSIM guide](http://data.library.utoronto.ca/cansim-guide), helping you navigate through the system to find the series you are seeking.




---

### CANSIM meets R

- [doc/interactiveDataVisual.Rmd](interactiveDataVisual.Rmd) & [doc/interactiveDataVisual.nb.html](interactiveDataVisual.nb.html) -- R Notebook and HTML file detailing the code in the `LFS_UR` script file.

View the HTML file online [here](https://cdn.rawgit.com/bcgov/CANSIM-data-viewer/6d049cf9e919912f8fd185dc4b8e025671d61ae3/interactiveDataVisual.nb.html).

- ** `cansim` **

* Some scripts rely on the [`cansim`](https://github.com/mountainMath/cansim) R package


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


happy Wednesday!
