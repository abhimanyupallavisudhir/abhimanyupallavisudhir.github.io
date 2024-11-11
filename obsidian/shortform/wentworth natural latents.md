addendum to [The Mind-Market Correspondence](../lesswrong/archived/The%20Mind-Market%20Correspondence.md)

I have looked through [L1] John Wentworth (2023) Natural latents. I think his “fundamental theorem” is just a generalization of [sufficient statistics](https://thewindingnumber.blogspot.com/2021/04/sufficient-statistics.html): a statistic $\Lambda(\mathbf{X})$ that is sufficient for all $X_1,\dots X_n$ is also sufficient for any “insensitive” variable $\Lambda'(\mathbf{X})$, because $\Lambda$ contains every bit of mutual information, and $\Lambda’$ can’t depend on any $X_i$-specific information, so it has to be only determined by mutual information. Furthermore if $\Lambda$ is both sufficient and insensitive (“a natural latent”), it is a minimal sufficient statistic.

(He doesn’t write these as random functions of $\mathbf{X}$, but that’s essentially what “resampling latents” does.)

He conjectures that there is a way to naturally construct a natural latent, via “simultaneous resampling”, described in [L2], [L3], [L4].