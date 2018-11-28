# LFS data sources


## Labour Force Survey

Canada's primary measure of the labour market, including unemployment rates, total number employed, and labour force participation.



#### BC Stats: LFS reports and tables

* [Labour Market Statistics](http://www2.gov.bc.ca/gov/content/data/statistics/employment-labour/labour-market-statistics)

* [About the Labour Force Survey](http://www2.gov.bc.ca/gov/content/data/statistics/employment-labour/about-labour-force-survey)



#### Statistics Canada: data sources

* [Labour Force Survey: main page](http://www23.statcan.gc.ca/imdb/p2SV.pl?Function=getSurvey&SDDS=3701) -- including links to data, methodology, and questionnaire

* [Labour force survey estimates (LFS), by sex and age group, seasonally adjusted and unadjusted](http://www5.statcan.gc.ca/cansim/a26?id=2820087) -- Table 282-0087

* [Labour force survey, all tables](http://www5.statcan.gc.ca/cansim/a03)



#### Scripts 

- [LFS_UR.R](../scr/LFS_UR.R) -- R script for using `CANSIM2R` package to download CANSIM tables; interactive data visualization with `rCharts`, `dygraphs` and `ggiraph`; and interactive tables using `DT` package.


- [LFS-family-composition](../scr/LFS-family-composition.RMD) -- a variety of R scripts that explore different demographic aspects of the labour force, including women with children.


- [LFS-partrate-by-age](../scr/LFS-partrate-by-age.RMD) -- seniors in the workforce, women and men aged 25-44.


- [LFSScript](../scr/LFSScript.R) -- data wrangling for the LFS Shiny app

