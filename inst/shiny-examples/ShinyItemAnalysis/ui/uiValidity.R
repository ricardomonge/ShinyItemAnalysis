uiValidity <- 
  navbarMenu("Validity",
             # * CORRELATION STRUCTURE ####
             tabPanel("Correlation structure",
                      h3("Correlation structure"),
                      h4("Correlation heat map"),
                      p("Correlation heat map displays selected type of",
                        HTML("<b>correlations</b>"), "between items. The size and shade of circles indicate how much the
                        items are correlated (larger and darker circle mean larger correlations).
                        The color of circles indicates in which way the items are correlated - blue
                        color mean possitive correlation and red color mean negative correlation.
                        Correlation heat map can be reordered using hierarchical",
                        HTML("<b>clustering method</b>"), "selected below. With", HTML("<b>number  of clusters</b>"), "larger than 1, the rectangles representing
                        clusters are drawn. The values of correlation heatmap may be displayed and also downloaded."),
                      fluidRow(div(style = "display: inline-block; vertical-align: top; width: 5%;"),
                               column(3, selectInput(inputId = "type_of_corr",
                                                     label    = "Choose correlation",
                                                     choices  = c("Pearson"    = "pearson",
                                                                  "Spearman"   = "spearman",
                                                                  "Polychoric" = "polychoric"),
                                                     selected = 'polychoric')),
                               column(3, div(class = "input-box",
                                             selectInput(inputId = 'corr_plot_clustmethod',
                                                         label = 'Clustering method',
                                                         choices = list("None" = "none",
                                                                        "Ward's"  = "ward.D",
                                                                        "Ward's n. 2" = "ward.D2",
                                                                        "Single" = "single",
                                                                        "Complete" = "complete",
                                                                        "Average" = "average",
                                                                        "McQuitty" = "mcquitty",
                                                                        "Median" = "median",
                                                                        "Centroid" = "centroid"),
                                                         selected = "none"))),
                               column(3, div(class = "input-box",
                                             numericInput(inputId = 'corr_plot_clust',
                                                          label = 'Number of clusters',
                                                          value = 1,
                                                          min = 1,
                                                          max = 1))),
                               column(3, actionButton(inputId = 'show_corr',
                                                      label = 'Display correlation values',
                                                      class = 'btn btn-primary'))),
                      conditionalPanel(condition = "input.type_of_corr == 'pearson'",
                                       p(HTML('<b>Pearson correlation coefficient</b>'), 'describes linear correlation between
                                         two random variables \\(X\\) and \\(Y\\). It is given by formula'),
                                       withMathJax(),
                                       ('$$\\rho = \\frac{cov(X,Y)}{\\sqrt{var(X)}\\sqrt{var(Y)}}.$$'),
                                       p('Sample Pearson corelation coefficient may be calculated as'),
                                       withMathJax(),
                                       ('$$ r = \\frac{\\sum_{i = 1}^{n}(x_{i} - \\bar{x})(y_{i} - \\bar{y})}{\\sqrt{\\sum_{i = 1}^{n}(x_{i} - \\bar{x})^2}\\sqrt{\\sum_{i = 1}^{n}(y_{i} - \\bar{y})^2}}$$'),
                                       p('Pearson correlation coefficient has a value between -1 and +1. Sample correlation of -1 and +1 correspond to all data points lying exactly on a line
                                         (decreasing in case of negative linear correlation -1 and increasing for +1). If coefficient is
                                         equal to 0 it implies no linear correlation between the variables.')),
                      conditionalPanel(condition = "input.type_of_corr == 'polychoric'",
                                       p(HTML("<b>Polychoric/tetrachoric correlation</b>"), "between two ordinal/binary variables is calculated from their contingency table,
                                         under the assumption that the ordinal variables dissect continuous latent variables that are bivariate normal.")),
                      conditionalPanel(condition = "input.type_of_corr == 'spearman'",
                                       p(HTML("<b>Spearman's rank correlation coefficient</b>"), 'describes strength and direction of monotonic relationship between random variables \\(X\\)
                                         and \\(Y\\), i.e. dependence between the rankings of two variables. It is given by formula'),
                                       withMathJax(),
                                       ('$$\\rho = \\frac{cov(rg_{X},rg_{Y})}{\\sqrt{var(rg_{X})}\\sqrt{var(rg_{Y})}},$$'),
                                       p('where \\(rg_{X}\\) and \\(rg_{Y}\\) are transformed random variables \\(X\\) and \\(Y\\) into ranks, i.e Spearman correlation coefficient is the Pearson correlation coefficient between the ranked variables.'),
                                       p('Sample Spearman correlation is calculated by converting \\(X\\) and \\(Y\\) to ranks (average ranks are used in case of ties) and by applying Pearson correlation formula. If both \\(X\\) and \\(Y\\) have \\(n\\) unique ranks, i.e. there are no ties, then sample correlation coefficient is given by formula'),
                                       withMathJax(),
                                       ('$$ r = 1 - \\frac{6\\sum_{i = 1}^{n}d_i^{2}}{n(n-1)}$$'),
                                       p('where \\(d = rg_{X} - rg_{Y}\\) is the difference between two ranks and \\(n\\) is size of \\(X\\) and \\(Y\\).
                                         Spearman rank correlation coefficient has value between -1 and 1, where 1  means perfect increasing relationship
                                         between variables and -1 means decreasing relationship between the two variables.
                                         In case of no repeated values, Spearman correlation of +1 or -1 means all data points lying exactly on some monotone line.
                                         If coefficient is equal to 0, it means, there is no tendency for \\(Y\\) to either increase or decrease with \\(X\\) increasing.')),
                      p(HTML("<b>Clustering methods.</b>"),
                        "Ward's method aims at finding compact clusters based on minimizing the within-cluster
                        sum of squares.
                        Ward's n. 2 method uses squared disimilarities.
                        Single method connects clusters with the nearest neighbours, i.e. the distance between
                        two clusters is calculated as the minimum of distances of observations in one cluster and
                        observations in the other clusters.
                        Complete linkage with farthest neighbours on the other hand uses maximum of distances.
                        Average linkage method uses the distance based on weighted average of the individual distances.
                        McQuitty method uses unweighted average.
                        Median linkage calculates the distance as the median of distances between an observation
                        in one cluster and observation in the other cluster.
                        Centroid method uses distance between centroids of clusters. "),
                      br(),
                      plotOutput('corr_plot'),
                      br(),
                      downloadButton(outputId = "DB_corr_plot", label = "Download figure"),
                      # download correlation matrix button
                      tags$style(HTML('#corr_matrix { margin: 10px }')),
                      downloadButton(outputId = "corr_matrix",  label = "Download matrix"),
                      br(),
                      conditionalPanel(condition = "input.corr_plot_clustmethod != 'none'",
                                       h4("Dendrogram"),
                                       plotOutput('dendrogram_plot'),
                                       downloadButton(outputId = "DB_dendrogram", label = "Download figure")),
                      h4("Scree plot"),
                      p('A scree plot displays the eigenvalues associated with an component or a factor in descending order
                        versus the number of the component or factor. Location of a bend (an elbow) suggests a suitable number of factors.'),
                      plotOutput('scree_plot'),
                      downloadButton(outputId = "DB_scree_plot", label = "Download figure"),
                      h4("Selected R code"),
                      div(code(HTML("library(corrplot)&nbsp;<br>library(ggdendro)<br>library(difNLR)&nbsp;<br>library(psych)<br><br>#&nbsp;loading&nbsp;data<br>data(GMAT)&nbsp;<br>data&nbsp;<-&nbsp;GMAT[,&nbsp;1:20]&nbsp;<br><br>#&nbsp;calculation&nbsp;of&nbsp;correlation<br>###&nbsp;Pearson<br>corP&nbsp;<-&nbsp;cor(data,&nbsp;method&nbsp;=&nbsp;\"pearson\")<br>###&nbsp;Spearman<br>corP&nbsp;<-&nbsp;cor(data,&nbsp;method&nbsp;=&nbsp;\"spearman\")<br>###&nbsp;Polychoric<br>corP&nbsp;<-&nbsp;polychoric(data)&nbsp;<br>corP$rho&nbsp;<br><br>#&nbsp;correlation&nbsp;heat&nbsp;map&nbsp;<br>corrplot(corP$rho)&nbsp;#&nbsp;correlation&nbsp;plot&nbsp;<br>corrplot(corP$rho,&nbsp;order&nbsp;=&nbsp;\"hclust\",&nbsp;hclust.method&nbsp;=&nbsp;\"ward.D\",&nbsp;addrect&nbsp;=&nbsp;3)&nbsp;#&nbsp;correlation&nbsp;plot&nbsp;with&nbsp;3&nbsp;clusters&nbsp;using&nbsp;Ward&nbsp;method<br><br>#&nbsp;dendrogram<br>hc&nbsp;<-&nbsp;hclust(as.dist(1&nbsp;-&nbsp;corP$rho),&nbsp;method&nbsp;=&nbsp;\"ward.D\")&nbsp;#&nbsp;hierarchical&nbsp;clustering&nbsp;<br>ggdendrogram(hc)&nbsp;#&nbsp;dendrogram<br><br>library(difNLR)&nbsp;<br>library(psych)<br><br>#&nbsp;loading&nbsp;data<br>data(GMAT)&nbsp;<br>data&nbsp;<-&nbsp;GMAT[,&nbsp;1:20]&nbsp;<br><br>#&nbsp;scree&nbsp;plot&nbsp;<br>ev&nbsp;<-&nbsp;eigen(corP$rho)$values&nbsp;#&nbsp;eigen&nbsp;values<br>df&nbsp;<-&nbsp;data.frame(comp&nbsp;=&nbsp;1:length(ev),&nbsp;ev)<br><br>ggplot(df,&nbsp;aes(x&nbsp;=&nbsp;comp,&nbsp;y&nbsp;=&nbsp;ev))&nbsp;+&nbsp;<br>&nbsp;&nbsp;geom_point()&nbsp;+&nbsp;<br>&nbsp;&nbsp;geom_line()&nbsp;+&nbsp;<br>&nbsp;&nbsp;ylab(\"Eigen&nbsp;value\")&nbsp;+&nbsp;<br>&nbsp;&nbsp;xlab(\"Component&nbsp;number\")&nbsp;+<br>&nbsp;&nbsp;theme_app()"))),
                      br()
                      ),
             # # * FACTOR ANALYSIS ####
             # tabPanel("Factor analysis",
             #          h3("Factor analysis"),
             #          h4("Scree plot"),
             #          p('A scree plot displays the eigenvalues associated with an component or a factor in descending order
             #            versus the number of the component or factor. Location of a bend (an elbow) suggests a suitable number of factors.'),
             #          plotOutput('scree_plot'),
             #          downloadButton(outputId = "DB_scree_plot", label = "Download figure"),
             #          h4("Selected R code"),
             #          div(code(HTML("library(difNLR)&nbsp;<br>library(psych)<br><br>#&nbsp;loading&nbsp;data<br>data(GMAT)&nbsp;<br>data&nbsp;<-&nbsp;GMAT[,&nbsp;1:20]&nbsp;<br><br>#&nbsp;scree&nbsp;plot&nbsp;<br>ev&nbsp;<-&nbsp;eigen(corP$rho)$values&nbsp;#&nbsp;eigen&nbsp;values<br>df&nbsp;<-&nbsp;data.frame(comp&nbsp;=&nbsp;1:length(ev),&nbsp;ev)<br><br>ggplot(df,&nbsp;aes(x&nbsp;=&nbsp;comp,&nbsp;y&nbsp;=&nbsp;ev))&nbsp;+&nbsp;<br>&nbsp;&nbsp;geom_point()&nbsp;+&nbsp;<br>&nbsp;&nbsp;geom_line()&nbsp;+&nbsp;<br>&nbsp;&nbsp;ylab(\"Eigen&nbsp;value\")&nbsp;+&nbsp;<br>&nbsp;&nbsp;xlab(\"Component&nbsp;number\")&nbsp;+<br>&nbsp;&nbsp;theme_app()"))),
             #          br()
             #          ),
             # * PREDICTIVE VALIDITY ####
             tabPanel('Criterion validity',
                      tabsetPanel(
                        # ** Summary ####
                        tabPanel('Summary',
                                 h3('Criterion validity'),
                                 p('This section requires criterion variable (e.g. future study success or future GPA in case
                                   of admission tests) which should correlate with the measurement. Criterion variable
                                   can be uploaded in ', strong('Data'), 'section.'),
                                 h4('Descriptive plots of criterion variable on total score'),
                                 p('Total scores are plotted according to criterion variable. Boxplot or scatterplot is displayed
                                   depending on the type of criterion variable - whether it is discrete or continuous. Scatterplot is
                                   provided with red linear regression line. '),
                                 plotOutput('validity_plot'),
                                 downloadButton(outputId = "DB_validity_plot", label = "Download figure"),
                                 h4('Correlation of criterion variable and total score'),
                                 p('Test for association between total score and criterion variable is based on Spearman`s \\(\\rho\\).
                                   This rank-based measure has been recommended if bivariate normal distribution is not guaranteed.
                                   The null hypothesis is that correlation is 0. '),
                                 tableOutput('validity_table'),
                                 htmlOutput('validity_table_interpretation'),
                                 h4("Selected R code"),
                                 div(code(HTML("library(ShinyItemAnalysis)&nbsp;<br>library(difNLR)&nbsp;<br><br>#&nbsp;loading&nbsp;data<br>data(GMAT)&nbsp;<br>data01&nbsp;<-&nbsp;GMAT[,&nbsp;1:20]&nbsp;<br>#&nbsp;total&nbsp;score&nbsp;calculation<br>score&nbsp;<-&nbsp;apply(data01,&nbsp;1,&nbsp;sum)&nbsp;<br>#&nbsp;criterion&nbsp;variable<br>criterion&nbsp;<-&nbsp;GMAT[,&nbsp;\"criterion\"]&nbsp;<br>#&nbsp;number&nbsp;of&nbsp;respondents&nbsp;in&nbsp;each&nbsp;criterion&nbsp;level<br>size&nbsp;<-&nbsp;as.factor(criterion)<br>levels(size)&nbsp;<-&nbsp;table(as.factor(criterion))<br>size&nbsp;<-&nbsp;as.numeric(paste(size))<br>df&nbsp;<-&nbsp;data.frame(score,&nbsp;criterion,&nbsp;size)<br><br>#&nbsp;descriptive&nbsp;plots&nbsp;<br>###&nbsp;boxplot,&nbsp;for&nbsp;discrete&nbsp;criterion<br>ggplot(df,&nbsp;aes(y&nbsp;=&nbsp;score,&nbsp;x&nbsp;=&nbsp;as.factor(criterion),&nbsp;fill&nbsp;=&nbsp;as.factor(criterion)))&nbsp;+<br>&nbsp;&nbsp;geom_boxplot()&nbsp;+<br>&nbsp;&nbsp;geom_jitter(shape&nbsp;=&nbsp;16,&nbsp;position&nbsp;=&nbsp;position_jitter(0.2))&nbsp;+<br>&nbsp;&nbsp;scale_fill_brewer(palette&nbsp;=&nbsp;\"Blues\")&nbsp;+<br>&nbsp;&nbsp;xlab(\"Criterion&nbsp;group\")&nbsp;+<br>&nbsp;&nbsp;ylab(\"Total&nbsp;score\")&nbsp;+<br>&nbsp;&nbsp;coord_flip()&nbsp;+<br>&nbsp;&nbsp;theme_app()<br><br>###&nbsp;scatterplot,&nbsp;for&nbsp;continuous&nbsp;criterion<br>ggplot(df,&nbsp;aes(x&nbsp;=&nbsp;score,&nbsp;y&nbsp;=&nbsp;criterion))&nbsp;+&nbsp;<br>&nbsp;&nbsp;geom_point()&nbsp;+&nbsp;<br>&nbsp;&nbsp;ylab(\"Criterion&nbsp;variable\")&nbsp;+&nbsp;<br>&nbsp;&nbsp;xlab(\"Total&nbsp;score\")&nbsp;+&nbsp;<br>&nbsp;&nbsp;geom_smooth(method&nbsp;=&nbsp;lm,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;se&nbsp;=&nbsp;FALSE,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;color&nbsp;=&nbsp;\"red\")&nbsp;+&nbsp;<br>&nbsp;&nbsp;theme_app()<br><br>#&nbsp;correlation&nbsp;<br>cor.test(criterion,&nbsp;score,&nbsp;method&nbsp;=&nbsp;\"spearman\",&nbsp;exact&nbsp;=&nbsp;FALSE)"))),
                                 br()
                                 ),
                        # ** Items ####
                        tabPanel('Items',
                                 h3('Criterion validity'),
                                 p('This section requires criterion variable (e.g. future study success or future GPA in case
                                   of admission tests) which should correlate with the measurement. Criterion variable
                                   can be uploaded in ', strong('Data'), 'section. Here you can explore how the criterion correlates with individual items. '),
                                 p('In distractor analysis based on criterion variable, we are interested in how test takers
                                   select the correct answer and how the distractors (wrong answers) with respect to group based
                                   on criterion variable.'),
                                 h4('Distractor plot'),
                                 htmlOutput("validity_distractor_text"),
                                 p('With option ', strong('Combinations'), 'all item selection patterns are plotted (e.g. AB, ACD, BC). With
                                   option', strong('Distractors'), 'answers are splitted into distractors (e.g. A, B, C, D).'),
                                 fluidPage(div(class = "input-slider",
                                               sliderInput(inputId = 'validity_group',
                                                           label = 'Number of groups:',
                                                           min   = 1,
                                                           max   = 5,
                                                           value = 3)),
                                           div(style = "display: inline-block; vertical-align: top; width: 5%; "),
                                           div(class = "input-radio",
                                               radioButtons(inputId = 'type_validity_combinations_distractor',
                                                            label = 'Type',
                                                            choices = list("Combinations", "Distractors"))),
                                           div(style = "display: inline-block; vertical-align: top; width: 5%; "),
                                           div(class = "input-slider",
                                               sliderInput(inputId = "validitydistractorSlider",
                                                           label = "Item",
                                                           min = 1,
                                                           value = 1,
                                                           max = 10,
                                                           step = 1,
                                                           animate = animationOptions(interval = 1200)))),
                                 plotOutput('validity_distractor_plot'),
                                 downloadButton(outputId = "DB_validity_distractor_plot", label = "Download figure"),
                                 h4('Correlation of criterion variable and scored item'),
                                 p('Test for association between total score and criterion variable is based on Spearman`s \\(\\rho\\).
                                   This rank-based measure has been recommended if bivariate normal distribution is not guaranteed.
                                   The null hypothesis is that correlation is 0. '),
                                 tableOutput('validity_table_item'),
                                 htmlOutput('validity_table_item_interpretation'),
                                 h4("Selected R code"),
                                 div(code(HTML("library(ShinyItemAnalysis)&nbsp;<br>library(difNLR)&nbsp;<br><br>#&nbsp;loading&nbsp;data<br>data(\"GMAT\",&nbsp;\"GMATtest\",&nbsp;\"GMATkey\")&nbsp;<br>data&nbsp;<-&nbsp;GMATtest[,&nbsp;1:20]&nbsp;<br>data01&nbsp;<-&nbsp;GMAT[,&nbsp;1:20]&nbsp;<br>key&nbsp;<-&nbsp;GMATkey&nbsp;<br>criterion&nbsp;<-&nbsp;GMAT[,&nbsp;\"criterion\"]&nbsp;<br><br>#&nbsp;distractor&nbsp;plot&nbsp;for&nbsp;item&nbsp;1&nbsp;and&nbsp;3&nbsp;groups&nbsp;<br>plotDistractorAnalysis(data,&nbsp;key,&nbsp;num.groups&nbsp;=&nbsp;3,&nbsp;item&nbsp;=&nbsp;1,&nbsp;matching&nbsp;=&nbsp;criterion)&nbsp;<br><br>#&nbsp;correlation&nbsp;for&nbsp;item&nbsp;1&nbsp;<br>cor.test(criterion,&nbsp;data01[,&nbsp;1],&nbsp;method&nbsp;=&nbsp;\"spearman\",&nbsp;exact&nbsp;=&nbsp;F)"))),
                                 br()
                                 )
                                 )))