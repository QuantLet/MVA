
# clear all variables
rm(list = ls(all = TRUE))
graphics.off()

x 	= seq(-4, 4, 0.05)  	# generates a sequence on real axis
s1 	= 0.1  			# standard deviation for y1
mu1 	= 0.2  			# mean for y1
s2 	= 0.1  			# square root of variance for y2
mu2 	= -0.6  		# mean for y2

y1 = cbind(x, dnorm(x, mean = mu1, sd = s1))  # density y1
y2 = cbind(x, dnorm(x, mean = mu2, sd = s2))  # density y2

if (mu1 != mu2 & s1 != s2) {
    
    # first discrimination point
    c1 = -(mu2 * s1^2 - mu1 * s2^2)/(s2^2 - s1^2) + sqrt(((mu2 * s1^2 - mu1 * s2^2)/(s2^2 - 
        s1^2))^2 - ((mu1^2 * s2^2 - mu2^2 * s1^2 - 2 * log(s2/s1) * s1^2 * s2^2)/(s2^2 - 
        s1^2)))
    
    # second discrimination point
    c2 = -(mu2 * s1^2 - mu1 * s2^2)/(s2^2 - s1^2) - sqrt(((mu2 * s1^2 - mu1 * s2^2)/(s2^2 - 
        s1^2))^2 - ((mu1^2 * s2^2 - mu2^2 * s1^2 - 2 * log(s2/s1) * s1^2 * s2^2)/(s2^2 - 
        s1^2)))
} else if (mu1 != mu2 & s1 == s2) {
    if (mu2 < 0 & mu1 < 0) {
        c1 = mu2 - (mu2 - mu1)/2
        c2 = c1
    } else if (mu2 < 0 & mu1 >= 0) {
        c1 = mu2 - (mu2 - mu1)/2
        c2 = c1
    } else if (mu2 == 0 & mu1 < 0) {
        c1 = -abs(mu2 - mu1)/2
        c2 = c1
    } else if (mu2 > 0 & mu1 < 0) {
        c1 = mu2 - abs(mu2 - mu1)/2
        c2 = c1
    } else if (mu2 >= 0 & mu1 >= 0) {
        c1 = abs(mu2 - mu1)/2
        c2 = c1
    }
} else if (mu1 == mu2 & s1 == s2) {
    c1 = Inf
    c2 = -Inf
} else if (mu1 == mu2 & s1 != s2) {

    # first discrimination point
    c1 = -(mu2 * s1^2 - mu1 * s2^2)/(s2^2 - s1^2) + sqrt(((mu2 * s1^2 - mu1 * s2^2)/(s2^2 - 
        s1^2))^2 - ((mu1^2 * s2^2 - mu2^2 * s1^2 - 2 * log(s2/s1) * s1^2 * s2^2)/(s2^2 - 
        s1^2)))
    
    # second discrimination point
    c2 = -(mu2 * s1^2 - mu1 * s2^2)/(s2^2 - s1^2) - sqrt(((mu2 * s1^2 - mu1 * s2^2)/(s2^2 - 
        s1^2))^2 - ((mu1^2 * s2^2 - mu2^2 * s1^2 - 2 * log(s2/s1) * s1^2 * s2^2)/(s2^2 - 
        s1^2)))
}

limy = c(0, max(y1[, 2], y2[, 2]))
if (limy[2] < 0.4) {
    limy = c(0, 0.41)
}

# Plot
plot(y2, type = "l", lwd = 2, lty = 2, col = "blue", xlab = "", ylab = "Densities", 
    cex.lab = 1.2, cex.axis = 1.2, ylim = limy)
lines(y1, type = "l", lwd = 2, col = "red")
abline(v = c1, lwd = 3)
abline(v = c2, lwd = 3)

if (c1 == c2 & s1 == s2) {
    if (mu2 < 0) {
        text(c1 - 1, 0.4, "R2", col = "red")
        text(c1 + 1, 0.4, "R1", col = "red")
    } else {
        text(c1 - 1, 0.4, "R1", col = "red")
        text(c1 + 1, 0.4, "R2", col = "red")
    }
} else if (c1 != c2 & s2 > s1) {
    if (mu1 > mu2) {
        if (s1 >= 1) {
            text(c1 - 1, 0.4, "R2", col = "red")
            text(c1 + 0.8, 0.4, "R1", col = "red")
            text(c2 - 0.8, 0.4, "R1", col = "red")
        } else if (s1 >= 0 & s1 < 0.5) {
            text(c1 - s1 - 0.15, 0.4, "R2", col = "red")
            text(c1 + 0.5, 0.4, "R1", col = "red")
            text(c2 - 0.4, 0.4, "R1", col = "red")
        } else if (s1 >= 0.5 & s1 < 1) {
            text(c1 - 1, 0.4, "R2", col = "red")
            text(c1 + 0.5, 0.4, "R1", col = "red")
            text(c2 - 0.4, 0.4, "R1", col = "red")
        }
        
        # text(c1-1,0.4,'R1',col='red') text(c1+1,0.4,'R2',col='red')
        # text(c2-0.4,0.4,'R2',col='red')
    } else if (mu1 < mu2) {
        text(c1 - 1, 0.4, "R1", col = "red")
        text(c1 + 1, 0.4, "R2", col = "red")
        text(c2 - 0.4, 0.4, "R2", col = "red")
    } else if (mu1 == mu2) {
        text(c1 - s1 - 0.1, 0.4, "R1", col = "red")
        text(c1 + 1, 0.4, "R2", col = "red")
        text(c2 - 0.4, 0.4, "R2", col = "red")
    }
} else if (c1 != c2 & s2 < s1) {
    if (mu1 > mu2) {
        text(c1 - 1, 0.4, "R2", col = "red")
        text(c1 + 1, 0.4, "R1", col = "red")
        text(c2 - 0.6, 0.4, "R1", col = "red")
    } else if (mu1 < mu2) {
        if (s2 >= 1) {
            text(c1 - 1, 0.4, "R2", col = "red")
            text(c1 + 0.8, 0.4, "R1", col = "red")
            text(c2 - 0.8, 0.4, "R1", col = "red")
        } else if (s2 >= 0 & s2 < 0.5) {
            text(c1 - s2 - 0.15, 0.4, "R2", col = "red")
            text(c1 + 0.5, 0.4, "R1", col = "red")
            text(c2 - 0.4, 0.4, "R1", col = "red")
        } else if (s2 >= 0.5 & s2 < 1) {
            text(c1 - 1, 0.4, "R2", col = "red")
            text(c1 + 0.5, 0.4, "R1", col = "red")
            text(c2 - 0.4, 0.4, "R1", col = "red")
        }
    } else if (mu1 == mu2) {
        text(c1 - 1, 0.4, "R2", col = "red")
        text(c1 + 1, 0.4, "R1", col = "red")
        text(c2 - 0.4, 0.4, "R1", col = "red")
    }
} else if (c1 != c2 & mu1 == mu2) {
    text(c1 - 1, 0.4, "R1", col = "red")
    text(c1 + 1, 0.4, "R2", col = "red")
    text(c2 - 0.4, 0.4, "R2", col = "red")
}

title("2 Normal distributions", cex.main = 1.8) 
