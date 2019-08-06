library(dplyr)

fxy = function(x, y){
  return((12*cos(((x+3)^2 + (y+2)^2) / 4) / (3 + (x+3)^2 + (y+2)^2)))
}

X = seq(from = -10, to = 10, by = 0.5)
Y = seq(from = -10, to = 10, by = 0.5)
Z = outer(X, Y, FUN = fxy)
persp(X, Y, Z, border = "cyan", col = "lightblue") -> res

#==============================set the first gen===============================

number_of_init = 1000
initial_values = matrix(c((runif(min = -10, max = 10, n = number_of_init)), 
                         (runif(min = -10, max = 10, n = number_of_init))), 
                       ncol = number_of_init, nrow = 2, byrow = T)

generation_list = list(initial_values)

#==============================set the first gen===============================


#==============================rules of picking parents========================
parent_pick = function(gen, nparents = 10){
  xyz_matrix = rbind(gen, fxy(gen[1, ], gen[2, ]))
  sorted_values = fxy(gen[1, ], gen[2, ]) %>% sort(, decreasing = T)
  
  parent = matrix(0, ncol = nparents, nrow = 2)
  i = 1
  
  for(i in seq(1 : nparents)){
    j = which(xyz_matrix[3, ] == sorted_values[i])
    
    if (length(j) > 1){
      k = sample(seq(1:length(j)), size = 1)
      j = j[k]
    }
    parent[1, i] = xyz_matrix[1, j]
    parent[2, i] = xyz_matrix[2, j]
  }
  
  
  return(parent)
}

#==============================rules of picking parents========================


#=================================child generating================================
#parent length = 5

crossover = function(parent, nchild = 50){
  a = c(0, 1)

  
  crossover_matrix = expand.grid(a, a, a, a, a, a, a, a, a, a)
  crossover_matrix = crossover_matrix[2:(dim(crossover_matrix)[1]-1), ]
  n = dim(crossover_matrix)[1]
  
  child_matrix = matrix(0, nrow = 2, ncol = n)
  
  i = 1
  
  for(i in seq(1 : n)){
    crossover_factor = crossover_matrix[i, ] #1x5
    child = parent %*% t(crossover_factor) / sum(crossover_matrix[i, ])
    
    child_matrix[, i] = child
  }
  
  return(child_matrix)
  
}


#=================================child generating================================

#=================================mutation========================================

#mutation: x-axis and y-axis are flipped

mutation = function(child_matrix, p = 0.1){
  decision = sample(c(0, 1), 1, prob = c(1 - p, p))
  if (decision == 1){
    cutoff = 500
    
    
    child_matrix_1 = child_matrix[, 1:cutoff]
    child_matrix_2 = child_matrix[, (cutoff+1):dim(child_matrix)[2]]
    
    child_matrix_1 = rbind(child_matrix_1[2, ], child_matrix_1[1, ])
    
    child_matrix = cbind(child_matrix_1, child_matrix_2)
    
  }
  
  return(child_matrix)
}


#=================================mutation========================================


#==========================Genetic Algorithm=================================
generation_num = 50

i = 1

for (i in seq(1:generation_num)){
  creature = generation_list[[i]]
  
  #pick parents
  parents = parent_pick(gen = creature)
  
  #crossover the child
  child = crossover(parents)
  
  #mutate the child
  child = mutation(child_matrix = child, p = 0.01)
  
  #plot the points on 3d plot to see the situation
  x11() 
  persp(X, Y, Z, border = "cyan", col = "lightblue") -> res
  points(trans3d(x = creature[1, ], y = creature[2, ], z = fxy(x = creature[1, ], y = creature[2, ]), pmat = res), 
         col = 2, pch = 16)
  
  generation_list[[i + 1]] = child
  
}


#==========================Genetic Algorithm=================================
