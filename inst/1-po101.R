# Libraries
library(portfolio.optimization)
library(xts)

# 1. Load demo data
data(sp100w17)

sort.by.volume <- sort(sp100w17av, index.return=TRUE, decreasing = TRUE)
top30.volume <- sort(sort.by.volume$ix[1:30])

scenario.set <- sp100w17[, top30.volume]

# 2. Conduct an optimization with default parameters (Long-only Markowitz)
model <- optimal.portfolio(data)
barplot(model)

# 3. Similar optimization, but explicitely create a model
model <- portfolio.model(data)
markowitz <- optimal.portfolio(model)

# 4. Change one parameter of the model (objective function and repeat optimization)
mad <- optimal.portfolio(objective(model, "mad"))

# 5. Plot differences between Markowitz and MAD
barplot(matrix(c(x(markowitz), x(mad)), nrow=2, byrow=TRUE), beside=TRUE, las=3, names.arg=names(data), col=topo.colors(2), legend=c("Markowitz", "MAD"))
