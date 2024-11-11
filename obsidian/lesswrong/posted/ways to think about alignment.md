
I’m listing some “ways to think about alignment”. I’m not sure how much of the “whole problem” each of these individually captures, but they are intended to be very well-motivated, fundamental problems which can:

1) demonstrate to an honest skeptic that there is “something here”, it’s not just hand-wavy sci-fi BS
2) be used to sanity-check an alignment proposal by asking “well, which of these does it solve?”

(Bleg: tell me how much of the whole problem each individual thing captures, what it leaves out, and what things are really equivalent.)

I have three, maybe four:

***A. The problem of buying under information asymmetry.***

The basic problem with RLHF is that it fundamentally relies on a human’s ability to judge the correctness or value of a (potentially superhuman) AI’s outputs. In other words, the AI is trained on the human supervisor’s immediate, superficial volition, rather than on her extrapolated volition.

The standard measurement device for human values is the “market” — you put something on the market, and see how much it sells for. But markets, too, only price things correctly when assuming *perfect information* — if you are unable to know (or verify/trust, if told) something about a product e.g. “how many years will this battery last?” “what is the polyphenolic content of this olive oil?” “is this item adulterated?” it doesn’t affect your decision to buy, so the producer has no reason to optimize on it, so he makes the cheapest possible product, you learn to expect this and revise down your valuation of it.

(One solution you might consider is to buy information on the product from an information market. This does not typically work, because information markets don’t work, but [maybe this time it will](https://www.lesswrong.com/posts/Y79tkWhvHi8GgLN2q/reinforcement-learning-from-information-bazaar-feedback-and).)

More generally fixing this is the goal of any **Scalable Oversight** mechanism.

***B. Utility ≠ Reward.***

There’s plenty that has been said about this, what convinced me was the article [Reward is not the optimization target](https://www.lesswrong.com/posts/pdaGN6pQyQarFHXF4/reward-is-not-the-optimization-target). As a simple demonstrative example: the *reward function* that train(s)(ed) humans is “survival and reproduction in the (current) (ancestral) environment”. But this is not the *utility function*, i.e. what we care about in life.

You could say “the selected agent is the boundedly optimal program for maximizing the expected reward” — that even if the environment changes (e.g. the invention of birth control), these changes in the environment are also governed by some computable process, which can eventually be learned and maximized (i.e. you can “learn to generalize”). 

But this really says much less than it seems to. One way to understand why is that **your specified reward function is not the *true* reward function given by nature.** The true reward function, specified by nature, is always “survival and reproduction in the current environment”. You “supplying a reward function” is just your attempt at modifying this natural environment — specifically by constantly editing the AI by tweaking its parameters based on gradient descent.

Your training process of “constantly editing an AI to push it to good outputs” — even if you do this online — will work *only as long as that is the dominant selective pressure on the AI*. There is no reason why (i.e. no selection effect for) a superhuman AI will tolerate your continued meddling in its parameters.

As a simple demonstration: the market selects for agents which serve the consumers well — such agents gain influence in the market, and as a result the aggregate of agents learns to optimize for social value. But this does not mean you have selected for agents that “care” about what you want, just ones which are very good at giving you what you want. The market mechanism does not, in itself, prevent a corporation from simply going rogue and McNuking the world. In fact the market mechanism doesn’t even make agents care about money; an agent can just get rich because it’s good at doing useful stuff, then McNuke the world.

Intuitively I find “just make the AI situationally unaware” to be a very natural solution, but [apparently that won’t work](https://www.lesswrong.com/posts/vCQNTuowPcnu6xqQN/distinguishing-test-from-training).

***C. Prover-verifier games***.

An analogy I made [earlier](https://www.lesswrong.com/posts/3SzHiBYEWhuLdheeu/abhimanyu-pallavi-sudhir-s-shortform?commentId=Mx2gZaQsCB9SmjhoQ):

> There is a cliche that there are two types of mathematicians: "theory developers" and "problem solvers". Similarly Hanson [divides the production of knowledge into "framing" and "filling"](https://www.overcomingbias.com/p/fillers_neglecthtml).
> 
> It seems to me there are actually three sorts of information in the world:
> 
> - "Ideas": math/science theories and models, inventions, business ideas, solutions to open-ended problems
> - "Answers": math theorems, experimental observations, results of computations
> - "Proofs": math proofs, arguments, evidence, digital signatures, certifications, reputations, signalling
> 
> … I wonder if this is a reasonable analogy to make:
> 
> - Ideas: search
> - Answers: inference
> - Proofs: alignment

Ultimately this relates back to A / scalable oversight: suppose you have a mechanism that bridges the information asymmetry gap between the human and the AI. You still need to ensure that the human *learns* to correctly update on this information — in fact, the AI (the prover) and the human (the verifier) need to learn in tandem, so the former can produce “proofs” understandable by the latter. 

For example, with Debate: if human judges have a strong bias in favor of hearing a particular answer to a question regardless of the evidence presented, the AI will learn to argue for that answer. Therefore we need simultaneous selection pressures on the humans to judge correctly (e.g. by putting the humans in a market and having them complete real-world tasks for reward).

This is never a problem if the human were a *Bayesian* agent, mind you — the AI can simply provide all the relevant evidence to convince the human of the truth. I would say that the ability to “rationalize” a belief update mechanism as “just Bayesian lacking real information” is what characterizes *bounded rationality*.

From the very relevant [Neural Interactive Proofs](https://openreview.net/pdf?id=RhEND1litL) paper:

> Another departure from these works is that we explicitly study the difficulty of the learning problem faced by the verifier. We can thus be seen as building on earlier models of computationally bounded agents in game-theoretic settings (Papadimitriou & Yannakakis, 1994; Chang, 2006; Halpern & Pass, 2008; Orton, 2021), though these do not consider learning.


***D. Extrapolated Volition is ambiguous.***

If we uplifted whales to human-level intelligence, would they thank us for the favor, or rebel against us because we hunted them in the past?

…

Ultimately questions like this are not actually meaningful, because there’s no obvious procedure to just “take the [extrapolated volition](https://intelligence.org/files/CEV.pdf)” of some arbitrary program (like a whale’s brain).

Are things different if you take humans instead of whales? Do humans have an unambiguous extrapolated volition? I think making this precise is intimately connected to C / Prover-Verifier games.