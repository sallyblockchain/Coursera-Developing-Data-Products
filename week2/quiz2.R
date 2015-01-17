## Quiz 2.
# Problem 1.
# In the slidify YAML text. Changing the framework from 
# io2012 to shower does what?
# It changes the html5 framework thus changing the style of 
# the slides.

# Problem 2.
```{r}
fit <- lm(y ~ x1 + x2 + x3)
summary(fit)
```



```{r, echo=TRUE, results='hide'}
# only shows the scripts
sum(1:10)
10 * 11 / 2
```

```
# not executes
1+1
```
# hide the results: Add a results = 'hide' option in the {r} 
# call of the code chunk

# Problem 3.
```{r, echo=FALSE}
# only shows the output results
sum(1:10)
10 * 11 / 2
```
# display the results, but not the actual code:
# Add a echo = FALSE option in the {r} call of the code chunk

# Problem 4.
# R studio presentation tool does what?
# Creates HTML5 slides using a generalized markdown format 
# having an extention Rpres and creates reproducible presentations
# by embedding and running the R code from within the presentation 
# document.

# Problem 5.
# don't want the code to be evaluated: eval=FALSE
```{r, echo=TRUE, eval=FALSE}
# only shows the scripts
sum(1:10)
10 * 11 / 2
```

# Problem 6.
# When presenting data analysis to a broad audience, 
# which of the following should be done?
# Make the figure axes readable.
# Explain why each step was necessary.