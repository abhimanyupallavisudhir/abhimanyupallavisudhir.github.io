# Topics in Marketic Agents

## Combinatorial Prediction Markets and LVPMs

Read Sun Wei et al’s work

Combinatorial markets with decision nodes

## Markets of LLMs

Explicitly construct [Information Bazaar](https://arxiv.org/pdf/2403.14443) and figure out how to apply this to “traders incentivizing markets on things with mutual information” kinda things

## Learning theoretic properties

Backpropagation

Maybe make a graph representation — does our algorithm look at all like backpropagation on this? One difference is that we have variable depth (which is good, because it captures the idea that more complex tasks require more complex processing).

Wealth as params, its update mechanism. Is it like gradient descent at all? It’s like PageRank though. 

Meta learning and S = F. Price information. Godel Cantor issues.

Consumers and Multi-Objective RL (see [The Reward Hypothesis is False](https://openreview.net/pdf?id=5l1NgpzAfH))

Intuition-pumping for alignment. E.g. markets can tell if the reward signal is bad, or if they predict the reward signal to change, and stock up. That’s why “predatory pricing” doesn’t work. Markets are a way to get a consumer’s CEV.

## Economics

Perfect competition, economies of scale, growth, different types of goods

Different type signature agents and the emergence of market institutions etc.

## Practical work

Build a Python library

## Bridging (between abstraction and concrete)

Find a class of simple agents. Universal representation.

How to actually get modularity of state? Contracts as goods …

Convergence/optimality conditions — in particular: natural interest rate?