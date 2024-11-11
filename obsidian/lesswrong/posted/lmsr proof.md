
Suppose you have a prediction market for event $P$ at current price $p$.

You can bet on this market, but even the infinitesimally smallest bet you make moves the prices according to the logarithmic market scoring rule:

$$p = \frac{e^{x}}{1+e^{x}} $$
Where $x$ is the number of stocks of $P$ in circulation. 

So suppose you trade according to the pattern $x(t)$ i.e. $x(t)$ is the number of stocks you hold at time $t$. In other words at each time $t$, you buy $x'(t)dt$ stocks at price $p(t)$.

Then the total cost you’ve paid over time $t$ is:

$$\begin{align}\int_0^tx'(t)p(t)dt&=\int_0^t\frac{e^x}{1+e^{x}}dx\\
&=\left.\left[\log(e^{x(t)}+1)\right]\right._0^t\\
&=\left.\left[-\log(1-p(t))\right]\right._0^t\\
&=\left.\left[x(t)-\log p(t)\right]\right._0^t
\end{align}
$$

The payoff if $P$ resolves True is $\left.x(t)\right|_0^t$, and the profit is thus $\left[\log p(t)\right]_0^t$.

The payoff if $P$ resolves False is $0$, and the profit is thus $\left[\log (1-p(t))\right]_0^t$.

This is the standard proof, due to Hanson, that a prediction market with a logarithmic market maker provides logarithmic scoring.