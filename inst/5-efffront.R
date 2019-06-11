### 1. Data

# Use daily-based (crude) weekly return data from the S&P 100 in 2017
# This scenario set contains 30 stocks with the highest average trading 
# volume over 2017
data(sp100w17av30s)

# Get the asset means
asset.mean <- colMeans(scenario.set)
asset.sd <- apply(scenario.set, 2, sd)

### 2. Long-only Markowitz Model

model <- optimal.portfolio(scenario.set)

### 3. Compute Efficient Frontier

### Compute efficient frontier
frontier_size <- 20 + 2 # to avoid numerical instabilities
frontier <- seq(min(asset.mean), max(asset.mean), length.out=frontier_size)

# Compute frontier using a loop
frontier_mean <- c()
frontier_sd <- c()
for(i in 2:(length(frontier)-1)) {
  model <- min.mean(model, frontier[i])
  model <- optimal.portfolio(model)
  loss <- scenario.set %*% round(x(model), 2)
  frontier_mean <- c(frontier_mean, mean(loss))
  frontier_sd <- c(frontier_sd, sd(loss))
}

### 4. Plot Efficient Frontier

plot(asset.sd, asset.mean)
text(asset.sd, asset.mean, colnames(scenario.set), pos=1)

plot(frontier_sd, frontier_mean, main="Efficient Frontier", 
     xlab="Risk / Standard Deviation", ylab="Reward / (Expected) Return",
     ylim=c(min(frontier), max(frontier)), xlim=c(min(asset.sd), max(asset.sd)))
grid(lwd=2)
lines(frontier_sd, frontier_mean)
points(asset.sd, asset.mean)
text(asset.sd, asset.mean, colnames(scenario.set), pos=1)
