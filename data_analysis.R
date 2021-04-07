#library(lmtest) # required for coefci and coeftest
library(sandwich)
library(stargazer)

plm_id_fix <- lm(suicides.100k.pop ~ gdp_per_capita.... + sex + age+ country -1, data = data)

#coeftest(plm_id_fix, vcov. = vcovHC, type = "HC1")

# robust standard errors
rob_se_pan <- list(sqrt(diag(vcovHC(plm_id_fix, type = "HC1"))))

res <- stargazer(plm_id_fix,      
          header = FALSE, 
          type = "html",
          omit.table.layout = "n",
          digits = 3,
          dep.var.labels.include = FALSE,
          se = rob_se_pan)

a <- res[1:13] 
res <- append(a, res[320:325])
res

