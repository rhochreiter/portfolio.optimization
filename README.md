# Contemporary Portfolio Optimization with R

This package tries to implement something along the lines of a tidy portfolio optimization framework. However as the author is not affiliated with the RStudio group that advocates Tidy Packages he abstained from calling the package that way.

## Main Motivation

The main motivation was something that provides instant gratification, i.e. 
risk measure and optimization method agnostic

```
# Load the package
library(portfolio.optimization)

# Use any scenario data, e.g. the one provided with the package
data(sp100w17av30s)

# Do a portfolio optimization
weights(optimal.portfolio(scenario.set))

# Create a model for plotting and comparison
model <- optimal.portfolio(scenario.set)
barplot(model)
```

Furthermore, everything should be pipeable and such is the design of the package, i.e.

```
# The above initial portfolio optimization can be piped as follows 

scenario.set %>% 
  optimal.portfolio %>% 
  weights

# Of course, this is interesting if you change lots of parameters and keeps your
# portfolio models readable

scenario.set %>% 
  portfolio.model %>% 
  objective("expected.shortfall") %>% 
  alpha(0.1) %>% 
  upper.bound(0.2) %>%
  optimal.portfolio %>% 
  weights
```

## Further examples

There are some tutorials built into the package, which you may e.g. open with the following commands

```
file.edit(po.tutorial("101"))
file.edit(po.tutorial("compare"))
```
