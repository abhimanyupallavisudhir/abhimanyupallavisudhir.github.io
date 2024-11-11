Making a note of something that confused me at first while reading this: if $\mathbf{X}=(X_1\dots X_n)\sim N(0,\Sigma)$, then the principal component $v\cdot\mathbf{X}$ (where $v$ is the principal eigenvector of $\Sigma$) is NOT the latent variable for $\mathbf{X}$ -- indeed, $P(\mathbf{X}|v\cdot\mathbf{X})$ does not factor. E.g. in the two-dimensional case, knowing $X_1+X_2$ doesn't induce independence between $X_1, X_2$ at all -- in fact, it makes them completely determined from one another.

Instead, the latent is some $\Lambda\sim N(0,1)$  with conditionals $X_1=\Lambda+\varepsilon_1$, 



