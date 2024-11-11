This post is part of my broader aim to try and formulate everything AI in terms of markets so that alignment becomes an antitrust problem. Comments appreciated. 

Prerequisites [1].

Now also available on [arXiv](https://arxiv.org/abs/2402.14021).

## introduction: betting on what is neither verifiable nor falsifiable (non-VF)

Prediction markets are good at eliciting probabilities about events that will occur at a fixed, finite time. However, there are many questions we would like to bet on that cannot be resolved in finite time. For example:

*   ($\Sigma_1$) an asteroid impact will eventually occur; I am mortal; P halts
*   ($\Pi_1$) an asteroid impact will never occur; I am immortal; P doesn't halt
*   ($\Sigma_2$) there will exist an immortal man; some P_n doesn't halt; this infinite checkerboard has a completely black horizontal row
*   ($\Pi_2$) all men will be mortal; every P_n halts; there are infinitely many primes
*   ($\Pi_3$) sentences about limits e.g. x_n diverges to +infinity

As a sigma-algebra, the $\Sigma_{n+1}$ sentence $\exists x, P(x)$ should be seen as the countable union $\bigcup_{x=1}^\infty P(x)$ and so its probability should be the supremum of all the finite unions. Similarly, a $\Pi$ sentence should be seen as a countable intersection and its probability as an infimum. This is fine in probability theory, but I mean, "supremum" and "infimum" are not computable functions, you would need to elicit an infinite number of bets. 

> *Indeed, the desire to consider infinite events is basically the motivation for using sigma-algebras rather than set algebras in probability theories.* Set algebras correspond to propositional logic; sigma-algebras to predicate logic (to be sure, to *second*-order logic rather than first, because you can take any countable unions and intersections, not necessarily even enumerable in a computable way, which would correspond to some hyperarithmetic theory).

Actually $\Sigma_1$ (verifiable) and $\Pi_1$ (falsifiable) sentences are still OK: for verifiable sentences, just pay the trader if/when the sentence is verified; for falsifiable sentences, the trader is paid \$1 upfront and returns it if the sentence is falsified. These are what we call "long" and "short" positions respectively.

So philosophers will tell you there is nothing beyond $\Sigma_1$ and $\Pi_1$, but surely they must be wrong? Because we might actually care about sentences like "there are infinitely many primes" and "all men are mortal". We *may care about them*, means our utility functions may depend on them. We just need to construct a situation in which a utility function depends exactly on such a sentence and nothing else, i.e. devise a scoring rule to elicit probabilities on such sentences.

## alternate introduction: theory-independent pricing of logical sentences


On the face of it, Garrabrant induction seems like the completely natural formalism for logical uncertainty, with no special tricks — *of course* markets are the correct way to handle algorithmic uncertainty (they're the natural way to "aggregate algorithmic information", because they aggregate all of the traders' information, including algorithmic information), *of course* you'd want an inexploitability/Dutch-book criterion.

But actually Garrabrant induction isn't just "markets" — it has several additional constructions:

*   You can't actually just have a prediction market for all logical sentences, because it's not like the ground truth for all mathematical claims is definitively revealed at some point. I'm not even talking about unprovable sentences — even the sentence "there are an infinite number of primes" is *neither verifiable nor falsifiable*! *Peano Arithmetic* believes it, and what Garrabrant induction does is to just pay off the sentence when PA proves it.
*   But Garrabrant induction isn't a prediction market for "$\mathsf{PA}\vdash \phi$" *either* — it actually does attempt to assign a price to undecidable sentences. This is because of the whole "propositionally consistent worlds" trick, specifically: the market maker is always willing to exchange $\phi+\lnot\phi$ for $\$1$, even when $\phi$ is independent of $\mathsf{PA}$.
*   Less important to this article but worth a mention: it only dominates continuous traders; it also has a weird way of computing equilibrium when something like LMSR would be nicer.

In general, I think it is unsatisfactory for a market to rely completely on a formal theory as a source of truth — it makes it hard to generalize beyond the realm of pure math, you can't design good agents with it, and I think the full theory of logical uncertainty should simultaneously address the question of *Why even trust logic in the first place?*, and the answer should look like "because logic makes a lot of money on the market".

## the problem is not trivial

An obvious, immediate solution might look something like an inductive construction, where for $P$ a $\Pi_n$ sentence, you can give a trader the asset $\bigvee_{x\le n}P(x)$ on day $n$, taking it back the next day, ad infinitum, so the asset value approaches the $\Sigma_{n+1}$ asset $\exists x,P(x)$ over infinite time. 

But that doesn't actually work. We can illustrate this with this simple pictorial description of arithmetical sentences — e.g. a $\Pi_2$ sentence can be formulated as: Consider an infinite grid of white and black squares. Does it have a row comprised entirely of black squares?

![](https://39669.cdn.cke-cs.com/rQvD3VnunXZu34m86e5f/images/b9924f83c5a16405c308c9bf29ebbc636becaf55e69e2fb9.png)

Then the described scoring mechanism is equivalent to looking at a finite chunk of the board each day, and give him \$1 if it has a fully black row; the next day, you expand the chunk, take back any rewards from the previous day and repeat the exercise. Essentially, we are approximating $\exists x,\forall y,P(x,y)$ with the sequence $\bigvee_{x\le n}\bigwedge_{y\le n}P(x,y)$. This has an intuitive appeal, because it mirrors what we do with $\Sigma_1$ and $\Pi_1$ sentences: you give out \$1 free to $\Pi$ sentences holders, then they must pay it back when falsified. 

Picture-proof to see this doesn't work:

![](https://39669.cdn.cke-cs.com/rQvD3VnunXZu34m86e5f/images/2c8baeb5d30a58029da9d35e9cdb1ce57cdb53718eadf905.png)

In fact at least for $n>3$ in the Arithmetic Hierarchy, we have an impossibility theorem for *any* such scoring mechanism:

> **Theorem 1 (the problem is hard)**. Let $P(x\_1,\dots x\_n)$ be an $n$-ary primitive relation (denote its $\Sigma_n$ and $\Pi_n$ quantifications as $\Sigma P$ and $\Pi P$ respectively), let $D:\mathbb{N}\to\operatorname{list}\mathbb{N}^n$ be some fixed  "enumerator" of $\mathbb{N}^n$ (i.e. $\operatorname{set}(D_{t+1})\supseteq \operatorname{set}(D_t)$, $\bigcup_{t\in\mathbb{N}} \operatorname{set}(D_t)=\mathbb{N}^n$), and allow vectorizing $P$ on $\operatorname{finset}\mathbb{N}^n$, i.e. $P(\langle\mathbf{x}\_1,\dots \mathbf{x}\_n\rangle)=\langle P(\mathbf{x}\_1),\dots P(\mathbf{x}\_n)\rangle$. A "mechanism" for $\Sigma P$ (respectively $\Pi P$) can be either:
> 
> *   [asset] a computable sequence of computable functions $v\_t:\mathrm{Bool}^{D\_t}\to\mathbb{R}$ such that $\lim_{t\to\infty} v\_t(P(D\_t))=\begin{cases}\$1 & \text{if }\Sigma P\\ \$0 & \text{if }\lnot\Sigma P\end{cases}$ (respectively $\Pi P$).
> *   [score] a computable sequence of computable functions $s\_t:(0,1)\to\mathrm{Bool}^{D\_t}\to\mathbb{R}$ such that $\lim_{t\to\infty} s\_t(p,P(D\_t))=\begin{cases}\log(p) & \text{if }\Sigma P\\ \log(1-p) & \text{if }\lnot\Sigma P\end{cases}$ (respectively $\Pi P$).
> 
> Then for $n>3$, there is no computable procedure that, given some $n$-ary $P$, gives a mechanism for $\Sigma P$ (respectively $\Pi P$).
> 
> **Proof.** Suppose such a computable procedure existed, denote it by $\phi$. Then for all $n$-ary primitive relations $P$, the sentence $\Sigma P$ would be equivalent to either $\lim_{t\to\infty} \phi(P)\_t(P(D\_t))=1$ or $\lim_{t\to\infty} \phi(P)\_t(0.3,P(D\_t))=\log(0.3)$, depending on the type of mechanism. However, both of these sentences are $\Pi_3$, and for every $\Sigma_n$ sentence were equivalent to a $\Pi_3$ one would contradict Tarski's theorem.

## options and game semantics

But here's what you could do: at each step in time, let the asset-holder choose the height of the finite window, *then* the asset-issuer choose the width of the finite window (do you see why the order is important?). Then you ask if there is a *winning strategy* for the asset-holder, i.e. to make the asset value sequence "converge" to \$1, \$1, \$1 ... and if there's a *winning strategy* for the asset-issuer, i.e. to make the asset value sequence "converge" to \$0, \$0, \$0 ... (I put "converge" in quotes because that's probably not actually what we care about) This approach is closely analogous to [game semantics](https://en.wikipedia.org/wiki/Game_semantics).

More generally:

> Every asset has a "holder" and an "issuer".
> 
> A $\Sigma_{n+1}$ asset $\exists x, P(x)$ entails a counter $S\subseteq\mathbb{N}$, chosen by the holder at every point in time, and an underlying $\Pi_n$ asset $\bigvee_{x\in S}P(x)$ with the same holder and issuer.
> 
> A $\Pi_{n+1}$ asset $\forall x, P(x)$ entails a counter $S\subseteq\mathbb{N}$, chosen by the issuer at every point in time, and an underlying $\Sigma_n$ asset $\bigwedge_{x\in S}P(x)$ with the same holder and issuer.
> 
> If the underlying asset is ever sold off or given away, it must be re-bought before the next time it is updated.

In other words: the asset-holder and issuer repeatedly play the verification-falsification game against each other; if the asset-holder can "consistently" win, the asset is worth \$1, if the asset-issuer can "consistently" win, the asset is worth \$0. In fact, I think this simpler formulation is enough:

> A $\Sigma_{n+1}$ asset $\exists x, P(x)$ entails a counter $x\in\mathbb{N}$, chosen by the holder at every point in time, and an underlying $\Pi_n$ asset $P(x)$ with the same holder and issuer (if no counter is chosen, the underlying asset is $\bot$).
> 
> A $\Pi_{n+1}$ asset $\forall x, P(x)$ entails a counter $x\in\mathbb{N}$, chosen by the issuer at every point in time, and an underlying $\Sigma_n$ asset $P(x)$ with the same holder and issuer (if no counter is chosen, the underlying asset is $\top$).
> 
> If the underlying asset is ever sold off or given away, it must be re-bought before the next time it is updated.

There are several obvious problems with this (either) formulation, which really boil down to two things:

*   *Cost of construction —* You *want* to bet on the existence of a winning strategy, but you're really betting on whether you (or really anyone ever in the market) will find a winning strategy. In particular, this means the "cost of finding a winning strategy" sounds like something that may matter to the price of the asset, and also that the task of holding and issuing assets is itself strategic, so it is perhaps not straightforward to design an inventory-based market-maker (e.g. LMSR).
*   *Solvency/strategic bankruptcy* — Traders no longer have limited liability, they don't really own the cash they claim to have (they might have to pay it back at any point if they lose the game again). Given an agent whose asset's underlying value goes as \$1, \$0, \$1, \$1, \$0, \$1, ... how do you even determine what the "true" value of this asset is? In markets, the thing that really enforces the assumed incentive (i.e. that agents actually care about money) is the *budgeting* mechanism, aka *capitalism* [2], which lets agents that have proved themselves to be good at profit-maximizing gain more influence, as measured by a variable called "wealth". This "capitalism" thing is really what allows us to bring markets over to settings where traders are not assumed to be perfect profit-maximizing agents, but simply some programs. Now when traders had limited liability like in the traditional prediction markets (i.e. they actually hold the asset they do, and will never be asked to return it), checking if they are in-budget was easy: just check the value of their current cash reserves. Besides, you could still have just focused on profit-maximizing agents and still studied interesting things: not so anymore, when there is no way to define even how much an agent values a particular value sequence without resorting to "what kind of agent does capitalism select for?".

## constructivism

The latter problem can be cast aside for the time-being by making the games one-shot, i.e. having the agents pick their set of choices at one go rather than letting them add to it indefinitely (explicit construction [3])

The first problem, I believe, implies a somewhat radical rethinking of the probabilities we give sentences. Much like logical uncertainty requires us to accept giving a probability that isn't 0 or 1 to $\pi_{10^{99}}=6$ — by relativizing knowledge to a class of programs — *constructivism* demands that we accept the probability of non-VF sentences to be read as:

> the probability that *WE WILL CONSTRUCT* an $x$ such that for all $y$ *WE WILL CONSTRUCT*, $P(x,y)$

[*Constructivism*](https://en.wikipedia.org/wiki/Constructivism_(philosophy_of_mathematics)), as I would put it, is the position that the only information that counts towards a non-VF sentence is one that helps you win a VF game for it. If it is very difficult for you to construct an $x$ to play, that should count against the probability of the sentence. This is not as damning as one might think, though, because you do have the whole market's abilities at your disposal.

I will now present some results to persuade you that this approach is fine. It might be easier, for this purpose, to focus on statistical rather than algorithmic uncertainty. To be concrete, what I'm talking about is some sequence of random variables indexed as $P(x,y)$; then $\bigcup_x P(x, 5)$ is a $\Sigma_1$ sentence; $\bigcup\_x \bigcap\_y P(x,y)$ is $\Sigma_2$, etc. Note that if the $P(x,y)$s were independent, then the probability of any $\Sigma_2$ or $\Pi_2$ or higher sentence would have to be 0 or 1 by [Kolmogorov's 0-1 law](https://en.wikipedia.org/wiki/Kolmogorov%27s_zero%E2%80%93one_law); so you have to introduce dependencies between them. E.g. 

> Generate each $P(x, 0)\sim \operatorname{Bernoulli}\left(\frac1{(x+1)^2}\right)$ unconditionally and $P(x, y+1)\sim\operatorname{Bernoulli}\left(e^{-\frac{1}{\#\left[{P(x,\le y)}\right]^2}}\right)$ conditionally on $\#\left[{P(x,\le y)}\right]$ (the number of 1s so far for the same $x$). One can show that the probability of $\exists x,\forall y, P(x, y)$ is $1-\operatorname{sinc}(\pi e^{-\pi^2/12})\approx 0.288$.

(for those who want to play with such propositions, here's a [Colab notebook](https://colab.research.google.com/drive/1y-onJsYL2yZZ-nlgiWa0SM294gew1YF2?usp=sharing) with a class `RandomProp`.)

The limitation of sticking to statistical uncertainty is that you no longer have a notion of non-constructive evidence. Well, actually you do have the weak kind of non-constructive evidence: 

> an event $I$ that gives no information on $A$ or $B$ but gives information on $A\cup B$: 
> 
> e.g. I have two children; $A$ is "my eldest is a boy"; $B$ is "my youngest is a boy"; $I$ is "I have a boy and a girl". 

But this is not really non-constructive for us, because we are allowed to submit bets on any finite set of options (so, for e.g. the $\sqrt{2}^{\sqrt2}$ proof is OK). What we do not have with statistical uncertainty is the strong kind of non-constructive evidence:

> an event $I$ that is independent of every finite union $\bigcup_{i\in S}A_i$ but gives information on the countable union $\bigcup_{i\in \mathbb{N}}A_i$:
> 
> This is impossible, as you can prove by applying continuity from below to the sequence $A_i\cap I$.

So we will need some cleverer way to formalize the idea that our scheme incentivizes "constructive evidence" only. But at least we can prove some results in the logical case. *In the long run*, all possible constructors will be born. So in the long run, the probabilities must approach the ones predicted by probability theory. For example, in the "infinite black row" example, once $(\alpha,\aleph)$ is added to the market, where $\alpha$ buys $\forall x, \exists y, x \le y$ indefinitely and $\aleph$ is a constructor such that $\aleph(\forall y, x\ge y)\ni x+1$, the price of $\forall x, \exists y, x \le y$ *will* approach \$1 and the price of $\exists x, \forall y,x \ge y$ ("there is an infinite black row") *will* approach \$0.

(In fact, you don't even need to wait for that constructor to get the right probability: agents can also learn to wait for constructors to be born to; think e.g. the market for bonsai trees.)

> *Notation*. Let $P$ be a sentence and $\tilde\alpha$ be a constructor, i.e. a map $\operatorname{Prop}\to\operatorname{finset}\mathbb{N}$. Write $P,\!\tilde\alpha$ for $\tilde\alpha(P)$ and $P.\!\tilde\alpha$ for the replacement of the leading bounded variable in $P$ by the outputs of $\tilde\alpha$, i.e. $\bigvee_{x\in \tilde\alpha(P)}P[x]$ if $P$ is $\Sigma$ and $\bigwedge_{x\in \tilde\alpha(P)}P[x]$ if $P$ is $\Pi$. Note that $P.\!\tilde\alpha$ is always lower on the (hyper-)arithmetical hierarchy than $P$. Thus for two constructors $\tilde\alpha$, $\tilde\beta$, the alternating sequence $P.\!\tilde\alpha.\!\tilde\beta.\!\tilde\alpha.\!\tilde\beta.\!\tilde\alpha\dots$ must eventually terminate at an atomic proposition. Denote this atomic proposition by $\operatorname{Game}(P, \tilde\alpha, \tilde\beta)$. E.g. for First-Order-Logic sentences (specifically the example of $\Sigma_{n}$ for even $n$):
> 
> $$\operatorname{Game}(P, \tilde\alpha, \tilde\beta)=\bigvee_{x\_0\in P,\tilde\alpha}\bigwedge\_{x\_1\in P.\tilde\alpha,\tilde\beta}\bigvee\_{x\_2\in P.\tilde\alpha.\tilde\beta,\tilde\alpha}\dots\bigwedge\_{x\_n\in P.\tilde\alpha.\tilde\beta.\tilde\alpha\dots,\tilde\beta} P(x\_0\dots x_n)$$
> 
> For sentences beyond FOL, the expression is much the same except that $n$ cannot be determined easily (but the fact that the sequence terminates is equivalent to the well-foundedness of its ordinal rank).

We are ready to formulate our main theorem: that equilibrium prices for constructively true sentences (i.e. sentences for which there is a computable winning strategy to the Verification-Falsification game) approach \$1. The sketch of the proof is as follows: 

*   **a [complete class theorem](https://www.lesswrong.com/posts/sZuw6SGfmZHvcAAEP/complete-class-consequentialist-foundations):** if a sequence of prices (paired with a constructor) is exploitable (you can generate infinite profits by trading on it, which means it never "learns" to beat your strategy) by some (trader, constructor) pair, it is exploitable by "the market" (i.e. by the firm that hires each enumerated (trader, constructor) pair with smaller and smaller portions of the budget)
*   **market cannot exploit its own equilibrium prices** let the sequence of prices simply be the market equilibrium prices; then there are constructors you can pair them with so that "the market" cannot exploit them. 
*   **nobody can exploit market equilibrium prices** therefore for market equilibrium prices, there are constructors you can pair them with to make them inexploitable.
*   **this implies everything** if market prices of constructively true sentences did not tend towards \$1, there would be a strategy to exploit them. Thus they do. 

> **Definition 1 (Being very precise about the market construction).** Define:
> 
> *   A *price setter* is composed of:
>     *   a price sequence $\pi^{*}:t\mapsto\operatorname{Prop}\to[0,1]$
>     *   a constructor $\tilde{\pi}:t\mapsto\operatorname{Prop}\to\operatorname{label}\to\operatorname{finset}\mathbb{N}\cup\{\operatorname{pass}\}$
>     *   a labeller $\pi^\#:t\mapsto\operatorname{Prop}\to\mathbb{Q}\to_\_\operatorname{label}\cup\{\operatorname{pass}\}$ (where $\to_\_$ is the symbol for a piecewise-constant function over a finite number of pieces, i.e. a labelled finite-interval partition) such that $\operatorname{supp}\pi^\#(t,P)$ has length $\mu^\$(t,P)$ (defined via mutual recursion as follows)
> *   An *agent* $\alpha$ is composed of:
>     *   an endowment $\alpha^\mathrm{b}\in\mathbb{Q}$ and a birthday $\alpha^{\mathrm{t}}\in\mathbb{N}$
>     *   a trader $\hat\alpha:t\mapsto\operatorname{Prop}\to_\circ[0,1]\to\mathbb{Q}$ such that $\hat{\alpha}(t,P)$ is decreasing in price
>     *   a constructor $\tilde\alpha:t\mapsto\operatorname{Prop}\to\operatorname{label}\to\operatorname{finset}\mathbb{N}\cup\{\operatorname{pass}\}$
>     *   a labeller $\alpha^\#:t\mapsto\operatorname{Prop}\to\mathbb{Q}\to_\_\operatorname{label}\cup\{\operatorname{pass}\}$ such that $\operatorname{supp}\alpha^\#(t,P)$ has length $\alpha^\$(t,P)$ (defined via mutual recursion as follows).
>     *   an inventory $\alpha^{\$}:t\mapsto\operatorname{Prop}\to_\circ\mathbb{Q}$ defined by initial conditions $\alpha^\$(s,\top)=0$ for $s<\alpha^{\mathrm{t}}$, $\alpha^\$(\alpha^{\operatorname{t}},\top)=\alpha^{\mathrm{b}}$ and for all other propositions $\alpha^\$(0,P)=0$;  and recursion $\alpha^\$(t+1)=\alpha^\$(t)+\sum_{P,i}\delta_{P,i}\alpha^\$(t)$where:
>         *   orders placed: $\delta_{P,1}\alpha^{\$}(t,P)=\lambda\hat\alpha(t,P,\pi^*(t,P))$ where $\lambda$ indicates that for all $P$, $\max_p-\hat{\alpha}(t,P,p)\le\alpha^\$(t,P)$ (you're not selling what you don't have) AND $\sum_{P}\max_pp\hat{\alpha}(t,P,p)\le\alpha^\$(t,\top)$ (you can afford all your purchases)
>         *   cost of orders placed: $\delta_{P,2}\alpha^\$(t,\top)=-\pi^*(t,P)\delta_{P,1}\alpha^\$(t,P)$
>         *   the moves played (if $P$ is $\Sigma$): $\delta_{P,3}\alpha^\$(t,P)=-\sum_{l\in\operatorname{supp}\tilde\alpha(t,P)}|\alpha^\#(t,P)^{-1}(l)|$ and $\delta_{P,4}\alpha^\$(t,P[\tilde\alpha(t,P,l)])=|\alpha^\#(t,P)^{-1}(l)|$.
>         *   the opponent's moves (if $P$ is $\Pi$): $\delta_{P,5}\alpha^\$(t,P)=-\sum_{l\in\operatorname{supp}\tilde\pi(t,P)}|\pi^\#(t,P)^{-1}(l)|$ and $\delta_{P,6}\alpha^\$(t,P[\tilde\pi(t,P,l)])=|\pi^\#(t,P)^{-1}(l)|$
>         *   the payout from empirical truth (if $P$ is $\Delta_0$): if $\xi(t)$ supports $P$, then $\delta_{P,7}\alpha^{\$}(t,P)=-\alpha^{\$}(t,P)$ and $\delta_{P,8}\alpha^{\$}(t,\xi(t,P))=\alpha^{\$}(t,P)$
> *   The *empirical reality* is a process $\xi:t\mapsto\Delta\_0\to\_\circ\{\top,\bot,\operatorname{pass}\}$ such that $s\le t\implies\xi(t)|_{\operatorname{supp}\xi(s)}=\xi(s)$, $\bigcup\_t\operatorname{supp}\xi(t)=\Delta\_0$, and $\xi(t,\lnot P)=\lnot \xi(t,P)$.
> *   A *father of agents* is an injective $\mu^{\operatorname{bh}}:t\mapsto\alpha$ with a finite total endowment i.e. $\sum_{t}\mu^{\operatorname{bh}}(t)^{\mathrm{b}}<\infty$ and correct birthdays i.e. $\mu^{\mathrm{bh}}(t)^{\mathrm{t}}=t$. It is associated with an *aggregate agent* as follows:
>     *   $\mu^{\mathrm{b}}=\sum_{t}\mu^{\operatorname{bh}}(t)^{\mathrm{b}}$
>     *   $\hat\mu(t)=\sum_{\alpha}\lambda_\alpha\hat\alpha(t)$  where $\lambda_\alpha$ indicates that for all $P$, $\max_p-\hat{\alpha}(t,P,p)\le\alpha^\$(t,P)$ and $\sum_{P}\max_pp\hat{\alpha}(t,P,p)\le\alpha^\$(t,\top)$.
>     *   $\tilde{\mu}(t,P,``\alpha\!":l)=\tilde\alpha(t,P,l)$
>     *   $\mu^\#(t,P,q)=``\mu^{\mathrm{bh}}(t\_q)\!":\mu^{\mathrm{bh}}(t\_q)^\#(t,P)$ where $t_q$ is the smallest $t$ such that $\sum_{s\le t}\mu^{\mathrm{bh}}(s)^\$(t,P)\ge q$ if such a $t_q\le t$ exists, otherwise $\mathrm{pass}$.
> *   An agent $\alpha$ is said to *exploit* a price-setter $\pi$ if $\left\{\alpha^{\$}(t,\top):t\in\mathbb{N}\right\}$ is bounded below but not above.
> *   A special price sequence $\varpi^*$ called *equilibrium*, computed as follows. For each $P$, $\varpi^*(t,P)$ is the solution $p$ to $\hat{\mu}(t,P,p)-\hat{\mu}(t,\lnot P,1-p)=0$. 

> **Theorem 2a [market dominance/CCT].** Suppose some agent $\alpha$ exploits a price setter $\pi$. Then so does any aggregate agent $\mu$ that fathers $\alpha$. (*Proof:* immediate.)
> 
> **Lemma 2b [market cannot exploit its own equilibrium].** There exists constructors and labellers $\tilde\varpi,\varpi^\#$ such that $\mu$ cannot exploit $\varpi=(\varpi^*,\tilde\varpi,\varpi^\#)$.
> 
> *Proof.* At equilibrium price, $\mu$ buys equal amounts of $P$ and $\lnot P$, however it may use different constructors for different portions of each. So we will have $\varpi$ use $\mu$'s constructors for $\lnot P$ against $\mu$'s constructors for $P$ and vice versa so that it wins exactly the same number of games as it loses.
> 
> ![](https://39669.cdn.cke-cs.com/rQvD3VnunXZu34m86e5f/images/6955ed6c2929000ff0d0dd6b113be8b3742799056ca10919.png)
> 
> We construct as follows: 
> 
> *   $\tilde\varpi(t,P)=\tilde\mu(t,\lnot P)$
> *   $\varpi^\#(t,P)=\mu^\#(t,\lnot P)$
> 
> The result is immediate.
> 
> **Corollary 2c [thus no one can].** Thus no one can exploit $\varpi$. (*Proof:* immediate.)
> 
> **Theorem 2d [thus our result, pt 1].** $\lim_{t\to\infty}\varpi^*(t,P)$ exists for all $P$; denote this as $\varpi^\infty(P)$.
> 
> *Proof.* Suppose it didn't; then there is some $p'\in(0,1)$ and $\varepsilon>0$ such that $\varpi^*(t,P)>p'+\varepsilon$ infinitely often and $\varpi^*(t,P)<p'-\varepsilon$ infinitely often. Then consider the agent given by a trader that sells at $p>p'+\varepsilon$ and buys at $p<p'-\varepsilon$, and a trivial constructor (doesn't play the game at all, returns $\operatorname{pass}$ every turn). This agent exploits the market.  
> 
> **Theorem 2e [thus our result, pt 2].** If $P$ is a constructively true sentence, i.e. such that $\exists\tilde\alpha,\forall\tilde\beta, \operatorname{Game}(P,\tilde\alpha,\tilde\beta)$ (where quantifications are over constructors enumerated by the father), then $\varpi^\infty(P)=1$.
> 
> *Proof.* Suppose it wasn't; then there is some $\varepsilon$ such that $\varpi^*(t,P)$ is below $1-\varepsilon$ infinitely many times. Then consider the agent given by trader that buys at $p<1-\varepsilon$ and the constructor $\tilde\alpha$ from the hypothesis. This agent exploits the market. 
> 
> **Corollary 2f.** If $P$ is a constructively false sentence, i.e. such that $\exists\tilde\beta,\forall\tilde\alpha, \lnot\operatorname{Game}(P,\tilde\alpha,\tilde\beta)$, then $\varpi^\infty(P)=0$.
> 
> *Proof.* Just apply 2e to $\lnot P$.

This is not nearly as strong a result as I would like. I don't know what happens with sentences that are neither constructively true nor constructively false (perhaps it depends on the exact enumeration order ... ?), I don't have any nice results relating to the behaviour of prices "in approach" (stuff like $\pi_{10^{1000}}=3$ having price $0.1$ for a long time).

Perhaps something like this captures part of what I want:

> **Definition 2 (Constructible sigma algebras).** Define $\Omega=\{0,1\}^\mathbb{N}$, i.e. the set of binary sequences, to be our "sample space". We define our "constructible algebra" $\Psi$ on this space as the smallest set such that:
> 
> *   every subset $\overline{\pi}\_i=\{w\in\Omega\mid w\_i = 0\}$ and $\pi\_i=\{w\in\Omega\mid w\_i = 1\}$ is in $\Psi$.
> *   The finite unions and intersections of $\pi\_i,\overline{\pi}\_i$ are in $\Psi$; these are called its "propositional sets"
> *   $\Psi$ is closed under unions and intersections over the its computably enumerable subsets, i.e. for $p:\mathbb{N}\to\Psi$ computable, $\bigcup_{x\in\mathbb{N}} p(x)$ and $\bigcap_{x\in\mathbb{N}} p(x)$ are in $\Psi$.
> 
> (Does this differ from "monadic algebras", "[quantifier algebras](https://planetmath.org/quantifieralgebra)" and "polyadic algebras"?)

How would we actually define probability assignments on this? I would think something like $\sup_\tilde\alpha\inf_\tilde\beta\operatorname{Game}(P,\tilde\alpha,\beta)$, but that's not right. Seems like it should be something bounded between $\sup_\tilde\alpha\inf_\tilde\beta\operatorname{Game}(P,\tilde\alpha,\beta)\le\mathbf{Pr}(P)\le\inf_\tilde\beta\sup_\tilde\alpha\operatorname{Game}(P,\tilde\alpha,\beta)$.

Perhaps it relates to Japaridze's "Computability Logic". Or to Vladimir Vovk's reformulation of probability theory.

## betting on the latent space

So the real reason this matters, and what I'm more interested in working on hereon:

> If a tree falls in the forest, and no one's there to bet on it, does it make a sound?

There is a whole class of sentences which apparently have *no* grounding in empirical verification or falsification. Unlike our examples, they can't even be expressed as arithmetical sentences in verifiable or falsifiable things. Yet we see them as meaningful; they are part of our world-model. 

How could you *possibly* bet on something like "Is Bob responsible for the murder?" It's not good enough to resolve according to the outcome of an investigation, it certainly feels as though this sentence has some meaning outside of the outcome of an investigation, that there is some **noumenal reality**. 

Perhaps it is instructive to ask: *why* do we care about "Is Bob responsible for the murder?" Because it correlates with other questions, that *are* rooted in empirical reality, like "Will the murder rate be lower if we jail Bob?". This is why we care about, say, history, or heck, much of real science too.

More importantly, such statements about this mentally-constructed world model — about the past, about the faraway and invisible, about the imagined — are pieces of information that we regard as likely to be useful for multiple downstream tasks. They are **good abstractions**, good compressed representations capturing correlations between things.

> Related: [Latent variables for prediction markets: motivation, technical guide, and design considerations](https://www.lesswrong.com/posts/ufW5LvcwDuL6qjdBT/latent-variables-for-prediction-markets-motivation-technical) by [tailcalled](https://www.lesswrong.com/users/tailcalled). 

The noumenal reality is a mentally-constructed world model. It exists in the **latent space** of an intelligent agent. Intelligence is *about* creating good abstractions in this sense. So if we develop a model of markets that automatically compute likely useful abstractions, i.e. a framework of **prediction markets for subjective questions**, that will dual as an alternate framework for designing AI agents.

[1]

If you are unfamiliar with logic you should read my previous post [Meaningful things are those the universe possesses a semantics for](https://www.lesswrong.com/posts/xqxXrAohXSD3akYCg/meaningful-things-are-those-the-universe-possesses-a). 

If you're unfamiliar with markets and scoring rules read [Robin Hanson](https://www.lesswrong.com/users/robinhanson)'s [Logarithmic Market Scoring](https://mason.gmu.edu/~rhanson/mktscore.pdf).  

If you're unfamiliar with logical uncertainty and specifically Garrabrant induction read [Scott Garrabrant](https://www.lesswrong.com/users/scott-garrabrant)'s [Logical Induction](https://arxiv.org/abs/1609.03543).

If you are unfamiliar with ordinals, it's OK, so am I.

(But you can read my [blog post](https://thewindingnumber.blogspot.com/2023/06/ordinals-and-well-founded-recursion.html) so you're at least not any more unfamiliar with them than I am.)
    
[2] Markets are intelligence; capitalism is learning.
    
[3]
    
A *trader* is a function $Q(\mathbf{i}, t)$ where $\mathbf{i}$ is the information in the environment (e.g. information from the order book) and $t$ is time, returning limit orders for each sentence ($\operatorname{Prop}\to_\circ([0,1]\to_\lrcorner\mathbb{Q})$).

A *constructor* is a function $\aleph(t, P)$ (where $P$ is some $\Sigma_n$ sentence) which returns a finite set of naturals (or "skip") to substitute for the leading bound variable.

An agent is a (trader, constructor) pair, and acts in the obvious way, i.e. for each $t$:

> 1. Submit an order $Q(\mathbf{i},t)$ to the exchange and receive assets to inventory.

> 2. For each $\Sigma$ sentence $P$ in inventory, generate $X=\aleph(t,P)$ and submit them, replace $P$ with $\bigvee_{x\in X} P(x)$ and reduce to prenex normal form.

> 3. For each $\Pi$ sentence $P$ in inventory, receive the finite set $X$ chosen by the opponent, replace $P$ with $\bigwedge_{x\in X} P(x)$ and reduce to prenex normal form.

> 4. For each $\Delta_0$ sentence $P$ in inventory, receive its computation and cash out.

The details of the exchange are not important, it could be a continuous double auction, what's crucial is that orders are only filled if within budget, and that $\Sigma$ and $\Pi$ orders are matched to each other: an order for a $\Pi$ asset at price $p$ allows the exchange to sell its negative $\Sigma$ asset at price $1-p$, and vice versa. (Essentially: each trade is a $\Sigma$ bettor and a $\Pi$ bettor coming together to pool $\$p$ and $\$(1-p)$ and the winner gets the total amount.)