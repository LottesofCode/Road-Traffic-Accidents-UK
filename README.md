# Road-Traffic-Accidents-UK


## Project 

A look into the effect of day, time, year and gender on the severity of road accidents in the UK between 2016 to 2020.  

## Method

Sorted and analysed data using Excel and MS SQL Server.  
Code can be viewed [here](https://github.com/LottesofCode/Road-Traffic-Accidents-UK/blob/main/SQLCarAccidents.sql)

## Results

A selection of results are displayed in this [Tableau dashboard](https://public.tableau.com/views/UKRoadTrafficAccidentsSeverity2016-2020/Dashboard1?:language=en-US&publish=yes&:display_count=n&:origin=viz_share_link). 


-  Men are twice as likely to have a fatal accident and 1.25 times more likely to be involved in a serious collision compared to women. 
-  The majority of mild and severe accidents occur at 30 mph - whereas both 30 mph and 60 mph account for the majority of fatal accidents. 73% of accidents take place on single carriageway roads - where there is no central barrier between the lanes, meaning accidents can easily become severe/fatal at the national speed limit of 60mph. 
-  Both mild and severe accidents have peaks at 08:00 and 17:00 hours, Monday to Friday which correlates to the peak commuting hours. Fatal accidents do not have a bimodal distribution, instead having a peak around 17:00 hours - likely caused by weary/impatient commuters.    
-  There are fewer mild/severe accidents on a Saturday and Sunday, due to a lack of commuter traffic during the weekend. Interestingly, there is no decrease in fatal accidents on a Saturday and Sunday. In fact, the peak number of fatal accidents occur on a Sunday at 14:00 hours. 
-  Overall there are a greater number of accidents in the summer months. However there are a larger number of commuter hour accidents in the winter, in which the darker light conditions may play a role. 
-  The greatest number of accidents occur on the A38, followed by the A23, A4 and A1.  The M25 has the largest amount of accidents for motorways, which could be explained by the large volume of traffic frequenting the M25. 
- There was too much data missing/null about the age group of drivers involved in the accidents. 

## Further work

There is a wealth of data included in this dataset, with much more insight available. Further investigations could look at:
- Which gender of driver is most likely to have a crash on a motorway or A road. 
- Which road details influence the severity of an accident, i.e. junctions, pedestrian crossing, traffic lights etc.
- How big of a role do carriageway obstructions play in causing severe or fatal accidents. 

## Data

Data obtained from [UK Gov Road Safety Data](https://www.data.gov.uk/dataset/cb7ae6f0-4be6-4935-9277-47e5ce24a11f/road-safety-data)
