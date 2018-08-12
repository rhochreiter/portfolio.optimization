### 1. Data

# Use daily-based (crude) weekly return data from the S&P 100 in 2017
data(sp100w17)

# Only use 30 assets with the highest average trading volume during 2017
sort.by.volume <- sort(sp100w17av, index.return=TRUE, decreasing = TRUE)
top30.volume <- sort(sort.by.volume$ix[1:30])

# Create the scenario set with those
scenario.set <- sp100w17[, top30.volume]
rm(sp100w17, sp100w17av, sort.by.volume, top30.volume)

### 2. Calculate optimal portfolios with different risk measures

# 2a. Markowitz
markowitz <- model <- optimal.portfolio(scenario.set)

# 2b. Expected Shortfall/CVaR with alpha=95% and alpha=90%
cvar95 <- optimal.portfolio(objective(model, "expected.shortfall"))
cvar90 <- optimal.portfolio(alpha(model, 0.1))

# 2c. Mean Absolute Deviation (MAD)
mad <- optimal.portfolio(objective(model, "mad"))

### 3. Plot Comparison

compare <- matrix(c(x(markowitz), x(mad), x(cvar95), x(cvar90)), 
                  nrow=model$assets, byrow=FALSE)
barplot(t(compare), beside=TRUE, col=rainbow(4), las=3, names.arg=names(data), 
        legend=c("Markowitz", "MAD", "CVaR (95%)", "CVaR (90%)"))

### 4. Add upper bounds (0.15) and repeat optimizations

markowitz <- model <- optimal.portfolio(upper.bound(portfolio.model(scenario.set), 0.15))
cvar95 <- optimal.portfolio(objective(model, "expected.shortfall"))
cvar90 <- optimal.portfolio(alpha(model, 0.1))
mad <- optimal.portfolio(objective(model, "mad"))

compare <- matrix(c(x(markowitz), x(mad), x(cvar95), x(cvar90)), 
                  nrow=model$assets, byrow=FALSE)
barplot(t(compare), beside=TRUE, col=rainbow(4), las=3, names.arg=names(data), 
        legend=c("Markowitz", "MAD", "CVaR (95%)", "CVaR (90%)"))
