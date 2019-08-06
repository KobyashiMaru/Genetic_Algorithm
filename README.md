# Genetic_Algorithm
Using genetic algorithm to fin the maximum of the function

As we know, genetic algorithm is an algorithm finding the best children of the generation, and make them crossover to be better than the last generation, but there is a little chance of mutation among the generation.

Pretty Darwinism Ikr.

Thus, we have to make the rule of parent picking, crossover, and mutation.

### Parent choosing
Of course the higher f(x, y) the better. Therefore, I choose 10 highest f(x, y) values to be the parent for the next generation.

### Crossover
Since we have 10 parents, I define the rule of crossover being choosing multiple parents, not exactly have to be 2 parents, it can be 1 or even 10 parents(but not 0 parents), and produce species by caculating the average among those parents.

Therefore, each generation will have 2^10 - 1 = 1023 species.

### Mutation
I define the rule of mutation to be exchanging the x-cordinate and the y-cordinate, e.g., (2, 3) will be mutated to be (3, 2). And I set the default mutation probability by p = 0.1.

### Result
The result is quite promising, my algorithm can reach local maximum in all the f(x, y) I can try, and can always converge in first 10 generations.

So I say this GA model perform pretty well.
