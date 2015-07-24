
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(leaflet)


shinyUI(
  navbarPage("Mountaintop Mining",theme="bootstrap.css",
             tabPanel('Introduction',
                      fluidRow(titlePanel('Mountaintop Mining Impacts on Landscapes')
                      ),
                      fluidRow(column(7,
                                      img(src="CoalSpoil.png",height="100%",width="100%")
                      ),
                      column(5,p("Mountaintop Mining is the most extensive land use impact in Central Appalachia
                        and one of the most intensive disturbances in the world. This form of surface mining
                       involves removing forests, soil, and bedrock with draglines and explosives to access
                       shallow coal seams which can be nearly 200m deep. Yet the extent of these effects are relatively 
                        unknown. This application details work that aims to better understand these 
                        impacts at the regional watershed scale (10-100 km2). This image shows excess bedrock (spoil) being deposited 
                                 onto a ridge."), 
                             radioButtons("q1","Which resource is currently the most dominant in US electricity production?", choices=c("Natural Gas", "Coal","Petroleum","Hydroelectric"), selected = F),
                             h5(textOutput("a1"),style="color:darkred"),
                             radioButtons("q2","Does mountaintop mining affect the landscape less than pit mining or deep mining?", choices=c("Yes","No"), selected = F),
                             h5(textOutput("a2"), style="color:darkred"),
                             radioButtons("q3","Is mountaintop mining less detrimental to humans than pit mining or deep mining?",choices=c("Yes","No"), selected = F),
                             h5(textOutput("a3"), style="color:darkred"),
                             conditionalPanel("output.q3=='Correct, nearly all mining tragedies occur in pit or deep mines'", 
                                              h3("Continue to the Mining Impact Explorer tab above")
                             )
                      )
                      
                      )
             ),
             tabPanel('Mining Impact Explorer',
                      sidebarLayout(
                        sidebarPanel(p("This application shows how mining has changed the slope and elevaiton,
                                       profiles of landscapes in West Virginia, along with providing an estimate of
                                       total spoil volume deposited into headwater valleys as a result of mining"),
                                     radioButtons("ES",label='Choose Data to Explore',
                                                  choices=list('Changes in slope'=1,
                                                               'Changes in elevation'=2),selected=1),
                                     leafletOutput("MapMine",height=350),width=4),
                        mainPanel(width=8,
                                  tabsetPanel(
                                    tabPanel("Map View",fluidRow(column(6,
                                             checkboxInput("PrePost",
                                                           label='Toggle pre- or post-mining data',
                                                           value=T)
                                                                ),
                                             column(6,
                                             checkboxInput('Diff',label='Toggle elevation change map',
                                                           value=F))),
                                             uiOutput('ID'),
                                             imageOutput('rastplots')),
                                    tabPanel("Plot View",plotOutput('gplots')),
                                    tabPanel("Volume of Spoil",plotOutput('barplot',height="350px"),
                                             plotOutput('secondbar',height="250px"))
                                  )
                        )
                      )
             )
  )
)

