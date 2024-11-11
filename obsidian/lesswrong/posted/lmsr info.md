# LMSR subsidy is the price of information
A logarithmic scoring rule to elicit a probability distribution $\mathbf{r}$ on a random variable $X\in\{1\dots n\}$ is $s(\mathbf{r})=b\log(r_X)$. Something that always seemed clear to me but I haven’t seen explicitly written anywhere is that the parameter $b$ is just the “price of information on $X$”.

Firstly: for an agent with true belief $\mathbf{p}$, the expected score from making a report $\mathbf{r}$ is $\mathrm{E}_{\mathbf{p}}[s(\mathbf{r})]=\sum_{x\in\{1\dots n\}}b\log(r_x)p_x=-bH(\mathbf{p},\mathbf{r})$ where $H$ is cross-entropy. This is maximized when $\mathbf{r}=\mathbf{p}$.

Well, this is just the standard proof that logarithmic scoring is proper. This max score itself is $\mathrm{E}_{\mathbf{p}}[s(\mathbf{p})]=-bH(\mathbf{p})$ i.e. the entropy in $\mathbf{p}$. So your expected earning is exactly proportional to the information you have on $X$ (the negative of the entropy in your probability distribution for it), and the proportionality constant, the price of a bit of information on $X$, is $b$.

This can be made even clearer by considering the value of some _other_ piece of information $Y$. If $Y=y$ and you learn this fact, you will bet $P(X|Y=y)$ which would give you an expected score of $\mathrm{E}_{P(X\mid Y=y)}[P(X\mid Y=y)]=-bH(P(X\mid Y=y))$. Taking the expectation over $Y$, your expected score if you acquire $Y$ is $-b\mathrm{E}_{P(Y)}[H(P(X\mid Y=y))]$ which is the conditional entropy $-bH(X\mid Y)$. Thus the expected profit from acquiring $Y$ is $-b(H(X\mid Y)-H(X))=bI(X;Y)$.

So the value of $Y$ is precisely $b$ multiplied by its mutual information with $X$, i.e. $b$ is the price of one bit of information on $X$.

I assume this is widely known. But I think it’s still pedagogically useful to actually think in these terms because it sheds light on things like:

- **Choosing a good scoring rule** — it’s not just that we want the scoring rule to be proper (incentivize honesty), we also want it to incentivize the optimal amount of effort in acquiring information. $b$ should be a measure of how important a question is.
- But also: like the price of any good, the **price of information can vary** (e.g. you might want to reduce $b$ after some key information becomes public, since you’re getting it for free)! And like any good it would have **diminishing returns**. This motivates things like [1].
- It makes clear the fact that prediction markets have huge **positive externalities** — the market-maker is paying for the information, but it becomes public. This is bad (see also: [2]) — in general, **IP rights** remain an unsolved problem: [3]. I have a very clever idea to solve it, which I will elaborate in another post.

[1] “Market Making with Decreasing Utility for Information” by Miroslav Dudik et al. https://arxiv.org/abs/1407.8161v1
[2] “Transaction costs: are they just costs?” by Yoram Barzel. http://www.jstor.org/stable/40750776
[3] “IP+ like barbed wire?” by Robin Hanson. https://www.overcomingbias.com/p/ip-like-barbed-wirehtml)