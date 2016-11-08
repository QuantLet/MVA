
ppsib = function(px){
  n   = NROW(px)
  m   = NCOL(px)
  cx  = px - matrix(apply(px,2,mean),nrow=n,ncol=m,byrow=T)
  mu  = rbind(apply(cx,2,mean),apply(cx^2,2,mean),apply(cx^3,2,mean),apply(cx^4,2,mean))
  k3  = mu[3]
  k4  = mu[4] - (3*(mu[2]^2))
  ind = ((k3^2)+((k4^2)/4))/12
  return(ind)
}


### Example 1 
# set.seed(100)                 # initialize random generator
# x = matrix(rnorm(100,0,1))    # generate a dataset with mean(x)=0 and var(x)=1            
# ppsib(x)                      # compute the index with Scott's rule


### Example 2
# plotindex1 = function(x) {
#     n   = 50
#     phi = seq(0, by = 2 * pi/n, length = n)
#     ind = matrix(0, n, 1)
#     i   = 0
#     while (i < n) {
#         i       = i + 1
#         xp      = x %*% c(cos(phi[i]), sin(phi[i]))
#         ind[i]  = ppsib(xp)
#         matplot(phi, ind, type = "l", xlab = "X", ylab = "Y")
#     }
# }

# sphere = function(x) {
#     x = x - matrix(apply(x, 2, mean), nrow = NROW(x), ncol = NCOL(x), byrow = T)
#     s = svd(var(x))
#     s = s$u/matrix(sqrt(s$d), nrow(s$u), ncol(s$u), byrow = T)
#     x = as.matrix(x) %*% as.matrix(s)
#     return(x)
# }

# x = read.table("bank2.dat")
# x = sphere(x[, c(4, 6)])
# plotindex1(x)
# title(paste("Index function ")) 
