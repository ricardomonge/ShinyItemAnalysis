#------------------------------------------------------------------------------------#
# DICHOTOMOUS MODELS ####
#------------------------------------------------------------------------------------#
uiDIRT <- tabPanel("Dichotomous models",

                 #------------------------------------------------------------------------------------#
                 # Dichotomous models ####
                 #------------------------------------------------------------------------------------#
                 h3("Dichotomous models"),
                 p("Dichotomous models are used for modelling items producing a simple binary response
                   (i.e., true/false). Most complex unidimensional dichotomous IRT model described here
                   is 4PL IRT model. Rasch model (Rasch, 1960) assumes discrimination fixed to \\(a = 1\\)
                   guessing fixed to \\(c = 0\\) and innatention to \\(d = 1\\). Similarly, other restricted
                   models (1PL, 2PL and 3PL models)  can be obtained by fixing appropriate parameters in
                   4PL model."),
                 p("In this section, you can explore behavior of two item characteristic curves
                   \\(\\mathrm{P}\\left(\\theta\\right)\\) and their item information functions
                   \\(\\mathrm{I}\\left(\\theta\\right)\\) in 4PL IRT model. "),

                 #------------------------------------------------------------------------------------#
                 # Parameters ####
                 #------------------------------------------------------------------------------------#
                 h4("Parameters"),
                 p("Select parameters ", strong("\\(a\\)"), "(discrimination), ", strong("\\(b\\)"),
                   "(difficulty), ", strong("\\(c\\)"), "(guessing) and ", strong("\\(d\\)"), "(inattention).
                   By constraining \\(a = 1\\), \\(c = 0\\), \\(d = 1\\) you get Rasch model. With option
                   \\(c = 0\\) and \\(d = 1\\) you get 2PL model and with option \\(d = 1\\) 3PL model."),
                 p("When different curve parameters describe properties of the same item but for different groups of respondents, this phenomenon is called Differential
                   Item Functioning (DIF). See further section for more information. "),
                 fluidRow(
                   splitLayout(
                     cellWidths = c("20%", "5%", "20%", "5%", "20%", "5%", "20%", "5%"),
                     tags$div(class = "js-irs-red",
                              sliderInput("ccIRTSlider_a1", "\\(a\\) - discrimination",
                                          min = -4, max = 4, value = 1, step = 0.1)),
                     "",
                     tags$div(class = "js-irs-red",
                              sliderInput("ccIRTSlider_b1", "\\(b\\) - difficulty",
                                          min = -4, max = 4, value = 0, step = 0.1)),
                     "",
                     tags$div(class = "js-irs-red",
                              sliderInput("ccIRTSlider_c1", "\\(c\\) - guessing",
                                          min = 0, max = 1, value = 0, step = 0.1)),
                     "",
                     tags$div(class = "js-irs-red",
                              sliderInput("ccIRTSlider_d1", "\\(d\\) - inattention",
                                          min = 0, max = 1, value = 1, step = 0.1)),
                     "")),
                 fluidRow(
                   splitLayout(
                     cellWidths = c("20%", "5%", "20%", "5%", "20%", "5%", "20%", "5%"),
                     tags$div(class = "js-irs-blue",
                              sliderInput("ccIRTSlider_a2", "\\(a\\) - discrimination",
                                          min = -4, max = 4, value = 2, step = 0.1)),
                     "",
                     tags$div(class = "js-irs-blue",
                              sliderInput("ccIRTSlider_b2", "\\(b\\) - difficulty",
                                          min = -4, max = 4, value = 0.5, step = 0.1)),
                     "",
                     tags$div(class = "js-irs-blue",
                              sliderInput("ccIRTSlider_c2", "\\(c\\) - guessing",
                                          min = 0, max = 1, value = 0, step = 0.1)),
                     "",
                     tags$div(class = "js-irs-blue",
                              sliderInput("ccIRTSlider_d2", "\\(d\\) - inattention",
                                          min = 0, max = 1, value = 1, step = 0.1)),
                     "")),
                 p("Select also the value of latent ability \\(\\theta\\) to see the interpretation of the item
                   characteristic curves. "),
                 fluidRow(
                   splitLayout(
                     cellWidths = c("20%", "5%", "75"),
                     tags$div(class = "js-irs-gray",
                              sliderInput("ccIRTSlider_theta", "\\(\\theta\\) - latent ability",
                                          min = -4, max = 4, value = 0, step = 0.1)),
                     "")),

                 #------------------------------------------------------------------------------------#
                 # Equations ####
                 #------------------------------------------------------------------------------------#
                 h4("Equations"),
                 ('$$\\mathrm{P}\\left(\\theta \\vert a, b, c, d \\right) = c + \\left(d - c\\right) \\cdot \\frac{e^{a\\left(\\theta-b\\right) }}{1+e^{a\\left(\\theta-b\\right) }} $$'),
                 ('$$\\mathrm{I}\\left(\\theta \\vert a, b, c, d \\right) = a \\cdot \\left(d - c\\right) \\cdot \\frac{e^{a\\left(\\theta-b\\right) }}{\\left[1+e^{a\\left(\\theta-b\\right)}\\right]^2} $$'),

                 #------------------------------------------------------------------------------------#
                 # Interpretation ####
                 #------------------------------------------------------------------------------------#
                 uiOutput("ccIRT_interpretation"),
                 br(),

                 #------------------------------------------------------------------------------------#
                 # Plots ####
                 #------------------------------------------------------------------------------------#
                 splitLayout(cellWidths = c("50%", "50%"),
                             plotlyOutput('ccIRT_plot'),
                             plotlyOutput('iccIRT_plot')),
                 splitLayout(cellWidths = c("50%", "50%"),
                             downloadButton("DB_ccIRT", label = "Download figure"),
                             downloadButton("DB_iccIRT", label = "Download figure")),
                 br(),

                 #------------------------------------------------------------------------------------#
                 # Exercise 1 ####
                 #------------------------------------------------------------------------------------#
                 h4("Exercise 1"),
                 p("Consider the following 2PL items with parameters", br(),
                   strong("Item 1:"), "\\(a = 2.5, b = -0.5\\)", br(),
                   strong("Item 2:"), "\\(a = 1.5, b = 0\\)", br(),
                   "For these items fill the following exercises with an accuracy of up to 0.05.
                   Then click on ", strong("Submit answers"), "button.
                   If you need a hint, click on blue button with question mark."),
                 tags$ul(
                   tags$li("Sketch item characteristic and information curves.",
                           bsButton(inputId = "irt_training_dich1_1_help",
                                    label = "", icon = icon("question"),
                                    style = "info", size = "extra-small"),
                           bsPopover(id = "irt_training_dich1_1_help", title = "Help",
                                     content = "Set item parameters by red and blue sliders above.",
                                     placement = "right",
                                     trigger = "hover",
                                     options = list(container = "body")),
                           htmlOutput("irt_training_dich1_1_answer", inline = T)),
                   tags$li("Calculate probability of correct answer for latent abilities
                           \\(\\theta  = -2, -1, 0, 1, 2\\).",
                           bsButton(inputId = "irt_training_dich1_2_help",
                                    label = "", icon = icon("question"),
                                    style = "info", size = "extra-small"),
                           bsPopover(id = "irt_training_dich1_2_help",
                                     title = "Help",
                                     content = "Set &theta; to desired value by gray slider above.",
                                     placement = "right",
                                     trigger = "hover",
                                     options = list(container = "body")),
                           splitLayout(
                             cellWidths = c("7%", "7%", "4%", "7%", "4%", "7%", "4%", "7%", "4%", "7%", "4%", "38%"),
                             strong("Item 1: "),
                             numericInput(inputId = "irt_training_dich1_1_2a",
                                          label = "\\(\\theta = -2\\)", value = 0),
                             htmlOutput("irt_training_dich1_2a_1_answer"),
                             numericInput(inputId = "irt_training_dich1_1_2b",
                                          label = "\\(\\theta = -1\\)", value = 0),
                             htmlOutput("irt_training_dich1_2b_1_answer"),
                             numericInput(inputId = "irt_training_dich1_1_2c",
                                          label = "\\(\\theta = 0\\)", value = 0),
                             htmlOutput("irt_training_dich1_2c_1_answer"),
                             numericInput(inputId = "irt_training_dich1_1_2d",
                                          label = "\\(\\theta = 1\\)", value = 0),
                             htmlOutput("irt_training_dich1_2d_1_answer"),
                             numericInput(inputId = "irt_training_dich1_1_2e",
                                          label = "\\(\\theta = 2\\)", value = 0),
                             htmlOutput("irt_training_dich1_2e_1_answer"), ""),
                           splitLayout(
                             cellWidths = c("7%", "7%", "4%", "7%", "4%", "7%", "4%", "7%", "4%", "7%", "4%", "38%"),
                             strong("Item 2: "),
                             numericInput(inputId = "irt_training_dich1_2_2a",
                                          label = "\\(\\theta = -2\\)", value = 0),
                             htmlOutput("irt_training_dich1_2a_2_answer"),
                             numericInput(inputId = "irt_training_dich1_2_2b",
                                          label = "\\(\\theta = -1\\)", value = 0),
                             htmlOutput("irt_training_dich1_2b_2_answer"),
                             numericInput(inputId = "irt_training_dich1_2_2c",
                                          label = "\\(\\theta = 0\\)", value = 0),
                             htmlOutput("irt_training_dich1_2c_2_answer"),
                             numericInput(inputId = "irt_training_dich1_2_2d",
                                          label = "\\(\\theta = 1\\)", value = 0),
                             htmlOutput("irt_training_dich1_2d_2_answer"),
                             numericInput(inputId = "irt_training_dich1_2_2e",
                                          label = "\\(\\theta = 2\\)", value = 0),
                             htmlOutput("irt_training_dich1_2e_2_answer"), "")),
                   tags$li("For what level of ability \\(\\theta\\) are the probabilities equal?",
                           bsButton(inputId = "irt_training_dich1_3_help",
                                    label = "", icon = icon("question"),
                                    style = "info", size = "extra-small"),
                           bsPopover(id = "irt_training_dich1_3_help",
                                     title = "Help",
                                     content = "You can find this value at the left figure. Alternatively, you need to find &theta; satisfying P<sub>1</sub>(&theta;) = P<sub>2</sub>(&theta;), that is a<sub>1</sub>(&theta; - b<sub>1</sub>) = a<sub>2</sub>(&theta; - b<sub>2</sub>).",
                                     placement = "right",
                                     trigger = "hover",
                                     options = list(container = "body")),
                           splitLayout(
                             cellWidths = c("7%", "4%", "89%"),
                             numericInput(inputId = "irt_training_dich1_3",
                                          label = "\\(\\theta\\) = ?", value = 0),
                             uiOutput("irt_training_dich1_3_answer"), "")),
                   tags$li("Which item provides more information for weak (\\(\\theta = -2\\)), average (\\(\\theta = 0\\))
                           and strong (\\(\\theta = 2\\)) students?",
                           bsButton(inputId = "irt_training_dich1_4_help",
                                    label = "", icon = icon("question"),
                                    style = "info", size = "extra-small"),
                           bsPopover(id = "irt_training_dich1_4_help",
                                     title = "Help",
                                     content = "Look at the figure on the right side. Which curve does have larger value for desired level of ability &theta;?",
                                     placement = "right",
                                     trigger = "hover",
                                     options = list(container = "body")),
                           splitLayout(
                             cellWidths = c("7%", "14%", "4%", "75%"),
                             HTML("\\(\\theta = -2\\)"),
                             radioButtons(inputId = "irt_training_dich1_4a",
                                          label = NULL,
                                          choices = list("Item 1" = 1, "Item 2" = 2),
                                          inline = T),
                             uiOutput("irt_training_dich1_4a_answer"), ""),
                           splitLayout(
                             cellWidths = c("7%", "14%", "4%", "75%"),
                             HTML("\\(\\theta = 0\\)"),
                             radioButtons(inputId = "irt_training_dich1_4b",
                                          label = NULL,
                                          choices = list("Item 1" = 1, "Item 2" = 2),
                                          inline = T),
                             uiOutput("irt_training_dich1_4b_answer"), ""),
                           splitLayout(
                             cellWidths = c("7%", "14%", "4%", "75%"),
                             HTML("\\(\\theta = 2\\)"),
                             radioButtons(inputId = "irt_training_dich1_4c",
                                          label = NULL,
                                          choices = list("Item 1" = 1, "Item 2" = 2),
                                          inline = T),
                             uiOutput("irt_training_dich1_4c_answer"),
                             div(style = "display: inline-block; float: right; width: 200px;",
                                 htmlOutput("irt_training_dich1_answer"),
                                 actionButton(inputId = "irt_training_dich1_submit",
                                              label = "Submit answers", width = "80%"))))),
                 br(),

                 #------------------------------------------------------------------------------------#
                 # Exercise 2 ####
                 #------------------------------------------------------------------------------------#
                 h4("Exercise 2"),
                 p("Consider now 2 items with following parameters", br(),
                   strong("Item 1:"), "\\(a = 1.5, b = 0, c = 0, d = 1\\)", br(),
                   strong("Item 2:"), "\\(a = 1.5, b = 0, c = 0.2, d = 1\\)", br(),
                   "For these items fill the following exercises with an accuracy of up to 0.05.
                   Then click on ", strong("Submit answers"), "button."),
                 tags$ul(
                   tags$li("What is the lower asymptote for items?",
                           bsButton(inputId = "irt_training_dich2_1_help",
                                    label = "", icon = icon("question"),
                                    style = "info", size = "extra-small"),
                           bsPopover(id = "irt_training_dich2_1_help", title = "Help",
                                     content = "Lower asymptote is determined by parameter c.",
                                     placement = "right",
                                     trigger = "hover",
                                     options = list(container = "body")),
                           splitLayout(
                             cellWidths = c("7%", "7%", "4%", "82%"),
                             strong("Item 1:"),
                             numericInput("irt_training_dich2_1a", label = NULL, value = 0),
                             uiOutput("irt_training_dich2_1a_answer"), ""),
                           splitLayout(
                             cellWidths = c("7%", "7%", "4%", "82%"),
                             strong("Item 2:"),
                             numericInput("irt_training_dich2_1b", label = NULL, value = 0),
                             uiOutput("irt_training_dich2_1b_answer"), "")),
                   tags$li("What is the probability of correct answer for latent ability \\(\\theta = b\\)?",
                           bsButton(inputId = "irt_training_dich2_2_help",
                                    label = "", icon = icon("question"),
                                    style = "info", size = "extra-small"),
                           bsPopover(id = "irt_training_dich2_2_help", title = "Help",
                                     content = "You can find this value at the left figure. Alternatively, you can calculate the value by formula for P(&theta;), where you can use the fact that exp(0) = 1.",
                                     placement = "right",
                                     trigger = "hover",
                                     options = list(container = "body")),
                           splitLayout(
                             cellWidths = c("7%", "7%", "4%", "82%"),
                             strong("Item 1:"),
                             numericInput("irt_training_dich2_2a", label = NULL, value = 0),
                             uiOutput("irt_training_dich2_2a_answer"), ""),
                           splitLayout(
                             cellWidths = c("7%", "7%", "4%", "82%"),
                             strong("Item 2:"),
                             numericInput("irt_training_dich2_2b", label = NULL, value = 0),
                             uiOutput("irt_training_dich2_2b_answer"), "")),
                   tags$li("Which item is more informative?",
                           bsButton(inputId = "irt_training_dich2_3_help",
                                    label = "", icon = icon("question"),
                                    style = "info", size = "extra-small"),
                           bsPopover(id = "irt_training_dich2_3_help", title = "Help",
                                     content = "Compare the curves at the right figure. Alternatively, you can compare formulas for information function.",
                                     placement = "right",
                                     trigger = "hover",
                                     options = list(container = "body")),
                           splitLayout(
                             cellWidths = c("21%", "4%", "75%"),
                             radioButtons("irt_training_dich2_3", label = NULL,
                                          choices = list("Depends on level of \\(\\theta\\)" = 12,
                                                         "Item 1 for all levels of \\(\\theta\\)" = 1,
                                                         "Item 2 for all levels of \\(\\theta\\)" = 2)),
                             uiOutput("irt_training_dich2_3_answer"),
                             div(style = "display: inline-block; float: right; width: 200px;",
                                 htmlOutput("irt_training_dich2_answer"),
                                 actionButton(inputId = "irt_training_dich2_submit",
                                              label = "Submit answers", width = "80%"))))),
                 br(),

                 #------------------------------------------------------------------------------------#
                 # Exercise 3 ####
                 #------------------------------------------------------------------------------------#
                 h4("Exercise 3"),
                 p("Consider now 2 items with following parameters", br(),
                   strong("Item 1:"), "\\(a = 1.5, b = 0, c = 0, d = 0.9\\)", br(),
                   strong("Item 2:"), "\\(a = 1.5, b = 0, c = 0, d = 1\\)", br(),
                   "For these items fill the following exercises with an accuracy of up to 0.05. Then click on ", strong("Submit answers"), "button."),
                 tags$ul(
                   tags$li("What is the upper asymptote for items?",
                           bsButton(inputId = "irt_training_dich3_1_help",
                                    label = "", icon = icon("question"),
                                    style = "info", size = "extra-small"),
                           bsPopover(id = "irt_training_dich3_1_help", title = "Help",
                                     content = "Upper asymptote is determined by parameter d.",
                                     placement = "right",
                                     trigger = "hover",
                                     options = list(container = "body")),
                           splitLayout(
                             cellWidths = c("7%", "7%", "4%", "82%"),
                             strong("Item 1:"),
                             numericInput("irt_training_dich3_1a", label = NULL, value = 0),
                             uiOutput("irt_training_dich3_1a_answer"), ""),
                           splitLayout(
                             cellWidths = c("7%", "7%", "4%", "82%"),
                             strong("Item 2:"),
                             numericInput("irt_training_dich3_1b", label = NULL, value = 0),
                             uiOutput("irt_training_dich3_1b_answer"), "")),
                   tags$li("What is the probability of correct answer for latent ability \\(\\theta = b\\)?",
                           bsButton(inputId = "irt_training_dich3_2_help",
                                    label = "", icon = icon("question"),
                                    style = "info", size = "extra-small"),
                           bsPopover(id = "irt_training_dich3_2_help", title = "Help",
                                     content = "You can find this value at the left figure. Alternatively, you can calculate the value by formula for P(&theta;), where you can use the fact that exp(0) = 1.",
                                     placement = "right",
                                     trigger = "hover",
                                     options = list(container = "body")),
                           splitLayout(
                             cellWidths = c("7%", "7%", "4%", "82%"),
                             strong("Item 1:"),
                             numericInput("irt_training_dich3_2a", label = NULL, value = 0),
                             uiOutput("irt_training_dich3_2a_answer"), ""),
                           splitLayout(
                             cellWidths = c("7%", "7%", "4%", "82%"),
                             strong("Item 2:"),
                             numericInput("irt_training_dich3_2b", label = NULL, value = 0),
                             uiOutput("irt_training_dich3_2b_answer"), "")),
                   tags$li("Which item is more informative?",
                           bsButton(inputId = "irt_training_dich3_3_help",
                                    label = "", icon = icon("question"),
                                    style = "info", size = "extra-small"),
                           bsPopover(id = "irt_training_dich3_3_help", title = "Help",
                                     content = "Compare the curves at the right figure. Alternatively, you can compare formulas for information function.",
                                     placement = "right",
                                     trigger = "hover",
                                     options = list(container = "body")),
                           splitLayout(
                             cellWidths = c("21%", "4%", "75%"),
                             radioButtons("irt_training_dich3_3", label = NULL,
                                          choices = list("Depends on level of \\(\\theta\\)" = 12,
                                                         "Item 1 for all levels of \\(\\theta\\)" = 1,
                                                         "Item 2 for all levels of \\(\\theta\\)" = 2)),
                             uiOutput("irt_training_dich3_3_answer"),
                             div(style = "display: inline-block; float: right; width: 200px;",
                                 htmlOutput("irt_training_dich3_answer"),
                                 actionButton(inputId = "irt_training_dich3_submit", label = "Submit answers", width = "80%"))))),
                 br(),
                 br(),

                 #------------------------------------------------------------------------------------#
                 # Selected R code ####
                 #------------------------------------------------------------------------------------#
                 h4("Selected R code"),
                 div(code(HTML("library(ggplot2)<br>library(data.table)<br><br>#&nbsp;parameters&nbsp;<br>a1&nbsp;<-&nbsp;1;&nbsp;b1&nbsp;<-&nbsp;0;&nbsp;c1&nbsp;<-&nbsp;0;&nbsp;d1&nbsp;<-&nbsp;1&nbsp;<br>a2&nbsp;<-&nbsp;2;&nbsp;b2&nbsp;<-&nbsp;0.5;&nbsp;c2&nbsp;<-&nbsp;0;&nbsp;d2&nbsp;<-&nbsp;1&nbsp;<br><br>#&nbsp;latent&nbsp;ability&nbsp;<br>theta&nbsp;<-&nbsp;seq(-4,&nbsp;4,&nbsp;0.01)<br>#&nbsp;latent&nbsp;ability&nbsp;level<br>theta0&nbsp;<-&nbsp;0<br><br>#&nbsp;function&nbsp;for&nbsp;IRT&nbsp;characteristic&nbsp;curve&nbsp;<br>icc_irt&nbsp;<-&nbsp;function(theta,&nbsp;a,&nbsp;b,&nbsp;c,&nbsp;d){&nbsp;return(c&nbsp;+&nbsp;(d&nbsp;-&nbsp;c)/(1&nbsp;+&nbsp;exp(-a*(theta&nbsp;-&nbsp;b))))&nbsp;}&nbsp;<br><br>#&nbsp;calculation&nbsp;of&nbsp;characteristic&nbsp;curves<br>df&nbsp;<-&nbsp;data.frame(theta,&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\"icc1\"&nbsp;=&nbsp;icc_irt(theta,&nbsp;a1,&nbsp;b1,&nbsp;c1,&nbsp;d1),<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\"icc2\"&nbsp;=&nbsp;icc_irt(theta,&nbsp;a2,&nbsp;b2,&nbsp;c2,&nbsp;d2))<br>df&nbsp;<-&nbsp;melt(df,&nbsp;id.vars&nbsp;=&nbsp;\"theta\")<br><br>#&nbsp;plot&nbsp;for&nbsp;characteristic&nbsp;curves&nbsp;<br>ggplot(df,&nbsp;aes(x&nbsp;=&nbsp;theta,&nbsp;y&nbsp;=&nbsp;value,&nbsp;color&nbsp;=&nbsp;variable))&nbsp;+&nbsp;<br>&nbsp;&nbsp;geom_line()&nbsp;+&nbsp;<br>&nbsp;&nbsp;geom_segment(aes(y&nbsp;=&nbsp;icc_irt(theta0,&nbsp;a&nbsp;=&nbsp;a1,&nbsp;b&nbsp;=&nbsp;b1,&nbsp;c&nbsp;=&nbsp;c1,&nbsp;d&nbsp;=&nbsp;d1),&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;yend&nbsp;=&nbsp;icc_irt(theta0,&nbsp;a&nbsp;=&nbsp;a1,&nbsp;b&nbsp;=&nbsp;b1,&nbsp;c&nbsp;=&nbsp;c1,&nbsp;d&nbsp;=&nbsp;d1),&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;x&nbsp;=&nbsp;-4,&nbsp;xend&nbsp;=&nbsp;theta0),&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;color&nbsp;=&nbsp;\"gray\",&nbsp;linetype&nbsp;=&nbsp;\"dashed\")&nbsp;+&nbsp;<br>&nbsp;&nbsp;geom_segment(aes(y&nbsp;=&nbsp;icc_irt(theta0,&nbsp;a&nbsp;=&nbsp;a2,&nbsp;b&nbsp;=&nbsp;b2,&nbsp;c&nbsp;=&nbsp;c2,&nbsp;d&nbsp;=&nbsp;d2),&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;yend&nbsp;=&nbsp;icc_irt(theta0,&nbsp;a&nbsp;=&nbsp;a2,&nbsp;b&nbsp;=&nbsp;b2,&nbsp;c&nbsp;=&nbsp;c2,&nbsp;d&nbsp;=&nbsp;d2),&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;x&nbsp;=&nbsp;-4,&nbsp;xend&nbsp;=&nbsp;theta0),&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;color&nbsp;=&nbsp;\"gray\",&nbsp;linetype&nbsp;=&nbsp;\"dashed\")&nbsp;+&nbsp;<br>&nbsp;&nbsp;geom_segment(aes(y&nbsp;=&nbsp;0,&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;yend&nbsp;=&nbsp;max(icc_irt(theta0,&nbsp;a&nbsp;=&nbsp;a1,&nbsp;b&nbsp;=&nbsp;b1,&nbsp;c&nbsp;=&nbsp;c1,&nbsp;d&nbsp;=&nbsp;d1),&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;icc_irt(theta0,&nbsp;a&nbsp;=&nbsp;a2,&nbsp;b&nbsp;=&nbsp;b2,&nbsp;c&nbsp;=&nbsp;c2,&nbsp;d&nbsp;=&nbsp;d2)),&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;x&nbsp;=&nbsp;theta0,&nbsp;xend&nbsp;=&nbsp;theta0),<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;color&nbsp;=&nbsp;\"gray\",&nbsp;linetype&nbsp;=&nbsp;\"dashed\")&nbsp;+&nbsp;<br>&nbsp;&nbsp;xlim(-4,&nbsp;4)&nbsp;+&nbsp;<br>&nbsp;&nbsp;xlab(\"Ability\")&nbsp;+&nbsp;<br>&nbsp;&nbsp;ylab(\"Probability&nbsp;of&nbsp;correct&nbsp;answer\")&nbsp;+&nbsp;<br>&nbsp;&nbsp;theme_bw()&nbsp;+&nbsp;<br>&nbsp;&nbsp;ylim(0,&nbsp;1)&nbsp;+&nbsp;<br>&nbsp;&nbsp;theme(axis.line&nbsp;=&nbsp;element_line(colour&nbsp;=&nbsp;\"black\"),&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;panel.grid.major&nbsp;=&nbsp;element_blank(),&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;panel.grid.minor&nbsp;=&nbsp;element_blank())&nbsp;+&nbsp;<br>&nbsp;&nbsp;ggtitle(\"Item&nbsp;characteristic&nbsp;curve\")&nbsp;<br><br>#&nbsp;function&nbsp;for&nbsp;IRT&nbsp;information&nbsp;function&nbsp;<br>iic_irt&nbsp;<-&nbsp;function(theta,&nbsp;a,&nbsp;b,&nbsp;c,&nbsp;d){&nbsp;return(a^2*(d-c)*exp(a*(theta-b))/(1&nbsp;+&nbsp;exp(a*(theta-b)))^2)&nbsp;}&nbsp;<br><br>#&nbsp;calculation&nbsp;of&nbsp;information&nbsp;curves<br>df&nbsp;<-&nbsp;data.frame(theta,&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\"iic1\"&nbsp;=&nbsp;iic_irt(theta,&nbsp;a1,&nbsp;b1,&nbsp;c1,&nbsp;d1),<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\"iic2\"&nbsp;=&nbsp;iic_irt(theta,&nbsp;a2,&nbsp;b2,&nbsp;c2,&nbsp;d2))<br>df&nbsp;<-&nbsp;melt(df,&nbsp;id.vars&nbsp;=&nbsp;\"theta\")<br><br>#&nbsp;plot&nbsp;for&nbsp;information&nbsp;curves&nbsp;<br>ggplot(df,&nbsp;aes(x&nbsp;=&nbsp;theta,&nbsp;y&nbsp;=&nbsp;value,&nbsp;color&nbsp;=&nbsp;variable))&nbsp;+&nbsp;<br>&nbsp;&nbsp;geom_line()&nbsp;+&nbsp;<br>&nbsp;&nbsp;xlim(-4,&nbsp;4)&nbsp;+&nbsp;<br>&nbsp;&nbsp;xlab(\"Ability\")&nbsp;+&nbsp;<br>&nbsp;&nbsp;ylab(\"Information\")&nbsp;+&nbsp;<br>&nbsp;&nbsp;theme_bw()&nbsp;+&nbsp;<br>&nbsp;&nbsp;ylim(0,&nbsp;4)&nbsp;+&nbsp;<br>&nbsp;&nbsp;theme(axis.line&nbsp;=&nbsp;element_line(colour&nbsp;=&nbsp;\"black\"),&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;panel.grid.major&nbsp;=&nbsp;element_blank(),&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;panel.grid.minor&nbsp;=&nbsp;element_blank())&nbsp;+&nbsp;<br>&nbsp;&nbsp;ggtitle(\"Item&nbsp;information&nbsp;curve\")&nbsp;"))),
                 br())
