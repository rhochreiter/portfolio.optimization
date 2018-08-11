### 1. Data

# Use daily-based (crude) weekly return data from the S&P 100 in 2017
data(sp100w17)

# Only use 30 assets with the highest average trading volume during 2017
sort.by.volume <- sort(sp100w17av, index.return=TRUE, decreasing = TRUE)
top30.volume <- sort(sort.by.volume$ix[1:30])

# Create the scenario set with those
scenario.set <- sp100w17[, top30.volume]
rm(sp100w17, sp100w17av, sort.by.volume, top30.volume)

### 2. Optimization with default parameters (Long-only Markowitz)

# One-Liner
model <- optimal.portfolio(scenario.set)

# Plot the result
barplot(model)

### 3. Repeat optimization but explicitely create a model

model <- portfolio.model(scenario.set)
markowitz <- optimal.portfolio(model)

### 4. Compute a long-only MAD portfolio

# We do so by changing one parameter of the model, i.e. the specification
# of the objective function and repeat the optimization

mad <- optimal.portfolio(objective(model, "mad"))

### 5. Plot portfolio differences between Markowitz and MAD

barplot(matrix(c(x(markowitz), x(mad)), nrow=2, byrow=TRUE), 
        beside=TRUE, las=3, names.arg=names(data), 
        col=topo.colors(2), legend=c("Markowitz", "MAD"))
