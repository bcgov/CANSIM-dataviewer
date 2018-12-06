<!--
Copyright 2018 Province of British Columbia

This work is licensed under the Creative Commons Attribution 4.0 International License.
To view a copy of this license, visit http://creativecommons.org/licenses/by/4.0/.
-->

# SEPH data sources

## Survey of Employment, Payrolls, and Hours (SEPH)

[SEPH documentation](http://www23.statcan.gc.ca/imdb/p2SV.pl?Function=getSurvey&SDDS=2612)


> The Survey of Employment, Payrolls and Hours (SEPH) provides a monthly portrait of the amount of earnings, as well as the number of jobs (i.e., occupied positions) and hours worked by detailed industry at the national, provincial and territorial levels.
>
> SEPH data provide the principal input to labour income estimates; they also serve as a proxy output measure for about 15% of real gross domestic product and 'nominal' gross domestic product. SEPH data are also used by the Canada Revenue Agency (CRA), to revise the maximum pensionable earnings and retirement savings plan contribution limits, and by the private sector, for contract escalations and wage rate determinations.
>
> Monthly survey estimates are produced by a combination of a census of payroll deductions, provided by the Canada Revenue Agency, and the Business Payrolls Survey (BPS), which collects data from a sample of 15,000 businesses. The BPS also collects information about job vacancies, supplemental to the SEPH (see Job Vacancy Statistics, record number 5202).


### Data tables

full search : [employment payroll hours](https://www150.statcan.gc.ca/n1/en/type/data?sourcecode=2612)


There are multiple (13) data tables associated with the SEPH:
https://www150.statcan.gc.ca/n1/daily-quotidien/181025/dq181025a-cansim-eng.htm

The principal tables used here are:

* Employment and average weekly earnings (including overtime) for all employees by province and territory, monthly, seasonally adjusted

  - Table: 14-10-0223-01 (formerly CANSIM  281-0063)
  
  - https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=1410022301


* Average weekly hours for employees paid by the hour, by industry, monthly, unadjusted for seasonality

  - Table: 14-10-0255-01 (formerly CANSIM  281-0032)

  - https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=1410025501


### Scripts

* [SEPH](scr/SEPH.Rmd)
