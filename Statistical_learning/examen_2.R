# Cargar las librerías necesarias
library(ISLR)
library(glmnet)

# Cargar y preparar los datos
data(Hitters)
Hitters <- na.omit(Hitters)
X <- model.matrix(Salary ~ . - League - Division - NewLeague, Hitters)[,-1]
y <- Hitters$Salary

# Dividir los datos en entrenamiento y prueba
set.seed(123) # Para reproducibilidad
train_index <- 1:200
X_train <- X[train_index,]
y_train <- y[train_index]
X_test <- X[-train_index,]
y_test <- y[-train_index]

# Modelo de regresión lineal múltiple
lm_model <- lm(Salary ~ ., data = Hitters, subset = train_index)
lm_pred <- predict(lm_model, newdata = Hitters[-train_index,])
lm_rss <- sum((lm_pred - y_test)^2)

# Modelo Ridge
set.seed(123)
cv_ridge <- cv.glmnet(X_train, y_train, alpha = 0)
ridge_model <- glmnet(X_train, y_train, alpha = 0, lambda = cv_ridge$lambda.min)
ridge_pred <- predict(ridge_model, s = cv_ridge$lambda.min, newx = X_test)
ridge_rss <- sum((ridge_pred - y_test)^2)

# Modelo Lasso
set.seed(123)
cv_lasso <- cv.glmnet(X_train, y_train, alpha = 1)
lasso_model <- glmnet(X_train, y_train, alpha = 1, lambda = cv_lasso$lambda.min)
lasso_pred <- predict(lasso_model, s = cv_lasso$lambda.min, newx = X_test)
lasso_rss <- sum((lasso_pred - y_test)^2)

# Comparar modelos
print(paste("RSS Lineal Múltiple:", lm_rss))
print(paste("RSS Ridge:", ridge_rss))
print(paste("RSS Lasso:", lasso_rss))

# Load the ISLR library
library(ISLR)

# Load the Hitters dataset
data(Hitters)

# Remove observations withHitters <- na.omit(Hitters)

# Set seed for reproducibility
set.seed(123)

# Split data into training and test sets
train <- Hitters[1:200, ]
test <- Hitters[201:nrow(Hitters), ]

# Fit a multiple linear regression model
lm.fit <- lm(Salary ~ ., data = train)
summary(lm.fit)

# Fit a ridge regression model
library(glmnet)
x <- model.matrix(Salary ~ ., data = train)
y <- train$Salary
cv.ridge.fit <- cv.glmnet(x, y, alpha = 0, nfolds = 10)
best.lambda.ridge <- cv.ridge.fit$lambda.min
ridge.fit <- glmnet(x, y, alpha = 0, lambda = best.lambda.ridge)
summary(ridge.fit)

# Fit a lasso regression model
cv.lasso.fit <- cv.glmnet(x, y, alpha = 1, nfolds = 10)
best.lambda.lasso <- cv.lasso.fit$lambda.min
lasso.fit <- glmnet(x, y, alpha = 1, lambda = best.lambda.lasso)
summary(lasso.fit)

# Predict on test set
x.test <- model.matrix(Salary ~ ., data = test)
y.test <- test$Salary
lm.pred <- predict(lm.fit, newdata = x.test)
ridge.pred <- predict(ridge.fit, newdata = x.test)
lasso.pred <- predict(lasso.fit, newdata = x.test)

# Calculate sum of squared residuals
lm.ssr <- sum((lm.pred - y.test)^2)
ridge.ssr <- sum((ridge.pred - y.test)^2)
lasso.ssr <- sum((lasso.pred - y.test)^2)

# Print sum of squared residuals for each model
cat("Multiple linear regression sum of squared residuals:", lm.ssr, "\n")
cat("Ridge regression sum of squared residuals (lambda =", best.lambda.ridge, "):", ridge.ssr, "\n")
cat("Lasso regression sum of squared residuals (lambda =", best.lambda.lasso, "):", lasso.ssr, "\n")
