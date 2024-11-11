
## Introduction

There are two perspectives from which we can motivate this problem:

- probability estimates for non-VF sentences
- logical uncertainty

Our contributions in this paper are threefold:

- we prove a straightforward impossibility theorem for any reasonable proper scoring mechanism for probability estimates of non-VF sentences
- we propose an alternative model for eliciting probabilities for such non-VF sentences (diagram: bettor, debaters) in which instead one debates on the outcome of a VF *game* in which truth is the equilibrium strategy, and some form of optimization pressure is applied to the players. This optimization pressure could come in the form of a prediction market (in which, as we argue, the mechanism is equivalent to *options*), or via RL (this is very closely related to debate …). In particular we construct an idealized version of such a market, analogous to the Garrabrant inductor, in which “every program” is a participant, and demonstrate that it prices sentences according to CGTS-truth. (and leads to an alternate notion of probability). Alt probability theory, program equilibrium.
- benchmark LLMs on their performance on giving probabilities for non-VF sentences. In this, we contribute to the rich literature on LLM forecasting by applying it to non-VF sentences. 

diagram: bettor, debaters
diagram: fol

example of nonVF: will Ukraine become a “permanent” NATO member? 

### Related work

Prediction markets, logical uncertainty and bounded rationality, AI debate, game semantics, LLM forecasting, 

debate: transfer of ideas between VF game and debate, like doubly-efficient debate, going back and changing moves, etc.

## Impossibility theorem

bla bla bla

Pitfall prevention: what about the naive thing?

## Framework

… algorithms

… what if we have every program play the game? Show in a nice pseudo-Pythonic way

theorems

… alt prob theory

… program equilibrium

## LLM Benchmark

We would like to 























---

**Abstract:**

An important problem in (…) is developing good *scoring rules* for probability estimates. This can be used to elicit honest probabilities, markets, and as reward functions for evaluating and training AI models. However, no such ground truth exists for non-VF sentences … these could be FOL sentences … real-world prediction markets for such often amount to predicting not whether it is true, but whether it will be proven … this also means there is no way to train an AI in a supervised manner to be accurate on such sentences. Our contribution in this paper is twofold: (1) options, equivalently VF game; (2) provide an LLM benchmark … our work acts as an alternative to Garrabrant induction … relevant to AI Debate based approaches … 

## Introduction

Extension of abstract / previous intro …

- Impossibility thm

For an example of a naive approach that doesn’t work — appendix ref.

We do two things: sec ref, sec ref.
### Related work

- CGTS-truth etc.
- Logical Induction
- AI debate — can be a setting; want to see if LLMs can sensibly provide probabilities on these debates 
- Forecasting without ground truth (cite consistency checks paper) — in contrast, we study questions that literally *cannot* be answered definitively …
- General BR work e.g. Halpern

## Framework

## Experiments with LLMs

I could develop an _LLM Benchmark_ for their performance on betting on non-verifiable sentences. 

I.e. LLMs would play the role of both the bettor (that provides a probability estimate for the sentence) and the player (that chooses which x1 ... xn to substitute into the bound variable). We could apply these forecasters to datasets like:

- Some propositions we come up with from some "practically infinite" data for which we know ground truth e.g. some kind of financial data or something (have to think about this) 

- Some data we generate based on a stochastic rule, e.g. P(x, 0) ~ Bernoulli(1 / (x + 1) ** 2); P(x, y + 1) ~ Bernoulli(exp (- 1 / #[P(x, <= y)] ** 2)).

- Forget ground truth, forget real datasets – just say that the terminal proposition in the VF game is sold off at the LLM's forecast for _that_ proposition, and evaluate its profit on that. 


The last one is probably the best approach actually, because it singles out the LLM's performance on _betting the VF game specifically_, rather than mixing it with its general forecasting accuracy. 

- AI Debate — have an LLM bet on the debate at each step.

So in this way we expand the rich literature on LLM forecasting by applying it to non-VF sentences. The paper could be divided into two parts, one for prediction markets and the other for LLM forecasters.

3 dimensions of tests: _n_ of FOL level, type of sentence (empirical or mathematical), scale (various ollamas)