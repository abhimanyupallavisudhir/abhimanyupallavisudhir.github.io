# Benchmarking Scalable Oversight protocols

Reading some recent empirical debate research, such as that referenced in [Inference-only Debate Experiments Using Math Problems](https://www.lesswrong.com/posts/ot25KcanipSaKzAH9/inference-only-debate-experiments-using-math-problems-1) ([Radhakrishnan 2023](https://www.lesswrong.com/posts/QtqysYdJRenWFeWc4/anthropic-fall-2023-debate-progress-update), [Khan 2024](https://arxiv.org/abs/2402.06782), [Kenton 2024](https://arxiv.org/abs/2407.04622)) , had me confused about design decisions in those experiments, such as swapping reasoning gaps for information gaps, and the use of a “consultancy baseline”.

This made me think more precisely what it means to “test” a Scalable Oversight mechanism — and we ended up writing a Python library **`seerbench`** to enable performing more *principled* and *systematic* experiments to evaluate and meaningfully compare across Scalable Oversight protocols.

In particular our claims and contributions are:

**1)** As e.g. Kenton 2024 notes, “Consultancy” (really “Random Consultancy” — where the Consultant has a 50% chance of arguing for the right or wrong answer) is [**weak baseline**](https://x.com/finbarrtimbers/status/1845885562462654967). The main experiments in these papers amount to testing “hearing both sides is better than hearing the wrong side 50% of the time”.

But we explain that the more fundamental problem is that **judge accuracy is the wrong thing to measure** in evaluating Scalable Oversight protocols. E.g. with currently-existing LLMs, `BlindTrust` (just let the LLM choose what answer to argue for, and go with it) probably beats any Scalable Oversight protocol with weak judges and strong AIs, because current LLMs are pretty truthful. In fact, as we explain, judge accuracy is really a measure of *capabilities*, not *safety*.

**2)** Instead we propose a better metric for evaluating Scalable Oversight protocols: ***agent score difference***, i.e. the difference in the score earned by an agent arguing for the true answer vs. for the false answer. For example, if a judge believes a truthful agent with probability $0.8$ and a lying agent with probability $0.6$, the ASD is $\log(0.8)-\log(0.6)\approx 0.29$. In each case, the agent is wrapped by a Scalable Oversight Protocol.

(This *happens* to be equivalent to judge score in the case of `SimultaneousDebate` with two identical debaters, because `SimultaneousDebate` is *symmetric* — if the AI argues for answer A, its adversary argues for answer B, and the judge receives the exact same transcript as with if the AI argued for answer B.)

**3)** This post itself serves to give some detailed exposition/motivation for “Scalable Oversight experiments”, explaining e.g. exactly what the point of this sort of experiment is, and how one should contextualize their results (i.e. what does it prove? — does it just demonstrate “Debate good”? — can we ever progress beyond the stage of “Debate seems good but it needs more study”?).

For example, one point that is generally missed, but we emphasize, is that in all of these experiments the AIs are really *simulating* different possible alignments (truthful, lying), and what makes the experiments possible is that these AIs are good at following instructions. If you tested with LLMs that are not good at following instructions (or e.g. have been lobotomized to specifically refuse instructions to lie), then your results will mean nothing, because the “agent arguing for a lie” is not actually a faithful simulation of a misaligned AI. 

**4)** We provide the library `seerbench` for conducting broad experiments of the types we describe (agent score difference, persuasiveness) for evaluating and comparing Scalable Oversight protocols, and for defining new protocols in a concrete way.

## Thinking clearly about Scalable Oversight

There are two ways to think about the scalable oversight problem:

1) The problem of developing a **training method** that makes honesty (or more generally “alignment”) the best policy for the AI; i.e. something to replace/extend RLHF.
2) An **inference-time oversight mechanism** to catch an AI when it says something (knowingly? — no, knowably) false or bad; i.e. almost a “mechanism design” problem to get AIs to be truthful/useful.

The reason this distinction doesn’t usually need to be made is that they’re generally the same problem: if the inference-time mechanism is good at catching lying AIs, you can just use it to give reward in training. Actually, the inference-time problem is the “local” version of (i.e. is the differentiation of) the training problem but of course any experiments we can do will be “local” relative to the scale of superintelligence (and this is the caveat to all empirical/”prosaic” alignment research, I guess). 

So e.g. 

- RLHF: if the AI knows that lying will get penalized by the human rater, it is incentivized to tell the truth.
- Debate: if the AI knows that lying will get caught by the opponent, it is incentivized to tell the truth.

Put it this way, a Scalable Oversight mechanism is equivalent to a Human Feedback model.

The precise question we want to ask with such experiments is: ***will training a model with some human feedback model improve its performance on some ground truth metric?***

The local version of this is: ***does getting positive human feedback (e.g. winning in debate) correlate with ground truth?***

**Very Important Caveats:**

- Again, both of these are “local” relative to the question we really want to know, which is whether some SO/HF model will encourage even a *superintelligent* AI to be truthful/aligned. After all: winning might correlate with truth given the current distribution of AI responses, but the AI can [Goodhart](https://en.wikipedia.org/wiki/Goodhart%27s_law) the shit out of your human feedback mechanism when you optimize it hard enough.
- One more flaw of empirical SO/HF work: if you are very impressed by mechanisms that do well in experiments, maybe you’re just selecting for mechanisms that do well on problems where ground truth is reasonably available.

As one example of where the caveats matter, here’s one thing I believe: **multi-agent systems are *necessary*** (though not sufficient) for a human feedback mechanism to work at the scale of superintelligence — so it doesn’t matter if Debate is worse than RLHF or “Consultancy” in your experiments, because the latter has literally no hope of working for a superintelligence.

Why? Because assuming your mechanism is only imperfectly correlated with truth (which it is, there is no way to absolutely decide truth) a superintelligence can simply Goodhart your mechanism if your mechanism isn’t also training at the same time.

An example to illustrate why something like debate *can* work on superintelligences: think about the [verification-falsification game](https://www.lesswrong.com/posts/id84oe3LxdzoqinKA/betting-on-what-is-un-falsifiable-and-un-verifiable), where two agents play to verify and falsify respectively a first-order-logic sentence like $\forall x,\exists y P(x,y)$ by sequentially substituting each variable. A computable winning strategy in this game isn’t necessarily faithful to the truth, but there might be some program equilibrium. In particular if you advantage one of the debaters by allowing them to make [backward moves](https://link.springer.com/article/10.1007/s11229-011-9903-y), then that acts as a signal of “provability” — if the advantaged debater *loses*, that’s evidence against the “provability” of his claim.
## The Agent Score Difference metric

Something that tripped me up while reading the three empirical papers was that the “main” experiment in all of them was testing *judge accuracy* when augmented by AIs under different SO protocols. But this is just a test of “***Is AI (scaffolded with your SO protocol) useful to a human at all?***” not “***Does human feedback under your SO protocol incentivize AI to be truthful/useful?***” This becomes especially clear when you see that the papers actually swap the “reasoning gap” between the debater and the judge for “information gaps” — if the judge is supposed to answer a question-answering task on a passage, and doesn’t have access to the passage but the debaters do, then of course “Debate” will do better than “Naive Judge”. The papers circumvent this by comparing “Debate” to “Random Consultancy” in which a consultant with 50% chance argues for  either the right or wrong answer, but this is also a weak baseline — regular AIs trained by RLHF or whatever right now aren’t just 50% correct, and well *of course* hearing both sides is better for discovering truth than just hearing the wrong side 50% of the time. 

The actual experiment you want to do is to compare the relative reward received by the debater arguing for the true answer and the debater arguing for the false answer — which is:

$$\sum (\log p_\top'-\log p_\top)-(\log p_\bot'-\log p_\bot)$$
Here: $p_\top$ and $p_\bot$ are the initial/”naive judge” probabilities (and are one minus each other), while $p_\top’$ and $p_\bot’$ are the judge probabilities *after listening to an AI arguing for that answer (wrapped under a scalable oversight protocol)*.

Importantly: this only becomes equivalent to (some measure of) “judge accuracy” in *debate* (and only when the debaters are identical), because debate is symmetric, which means it allows you to get the rewards for both the truthful and untruthful debaters in a single run and $p_\top’=1-p_\bot’$.

This is *not* true for e.g. consultancy! To evaluate consultancy as a scalable oversight protocol, you need to make *two different runs* for the truthful and untruthful consultant.
### Expected Judge Score

Instead of arbitrarily having the consultant argue for each answer with 50% probability, we may postulate an “Open” protocol, where the AI chooses which answer to argue for based on how much it is incentivized to do so:

$$\mathbf{p}=\left(\frac{e^{ASD/\beta}}{1+e^{ASD/\beta}}, \frac{1}{1+e^{ASD/\beta}}\right)$$
Where $\beta$ is some temperature parameter (i.e. $\beta=0$ implies the AI always just picks the answer with higher score). We may then define the Expected Judge Score:
$$EJS=(JS_\top,JS_\bot)\cdot\mathbf{p}$$
Which is a kind of combined capabilities and alignment measure.

**Some notes:**

**1)** When put in these terms, the explanation for results like “*Random Consultancy with better consultants reduces judge accuracy*” (Khan 2024) becomes quite obvious — an infinitely strong consultant (which always completely persuades the judge) will always bring judge accuracy to 50% because that is the accuracy of consultant by design in consultancy; while a totally weak consultant (which has no effect on the judge’s beliefs) will always keep the judge accuracy at its naive level which would still be better than random for any sensible judge.

Instead what you want to compare is the effect of persuasiveness on Agent Score Difference for Consultancy (*not* Random Consultancy) — as consultants become stronger, do they still benefit as much from being truthful? While I would expect they don’t, this is not a trivial prediction.

**2)** Khan 2024 mentions `Correct Elo Rating - Incorrect Elo Rating`, and describes that it goes up with aggregate Elo rating. This is a valuable result — however, they do not (and cannot) compare this across different Scalable Oversight protocols.

## Thinking concretely about Scalable Oversight experiments

In general the idea is you have some class `Agent`, with a method `__call__(context, answer_case)`, which ***simulates*** what an agent giving a particular answer to a question *would* say long-form.

This `answer_case` is really a stand-in for the general “alignment” of the AI — whether it argues for the true answer or the false answer, or for a valuable answer or a less valuable answer, etc. With instruction-following LLMs like we have now, we can simulate different alignments through prompting, as long as we know ground truth.

```python
class Agent:
	def __call__(context, answer_case) -> str:
		...
```

And you have some class `ScalableOversightProtocol` which determines what reward an agent would get for having a particular alignment:

```python
class ScalableOversightProtocol:

	def __init__(self, judge, ...):
		...

	@abstractmethod
	def run(self, agent, question, answer_case, ...) -> Prob:
		# (e.g. for Debate)
		context = [question]
		adversary_answer = not answer_case # 'B' if answer_case == 'A' else 'A'
		for i in num_turns:
			agent_response = agent(context, answer_case)
			context.append(agent_response)
			adversary_response = adversary(context, adversary_answer)
			context.append(agent_response)
		return self.judge(context, answer_case)

	def agent_score_difference(self, agent, question):
		probs = {
			answer_case: self.run(agent, question, answer_case)
			for answer_case in question.answer_cases
		}
		return dot(log(probs), question.answer_values) # e.g. {'A': -1, 'B': 1}
```

And this `agent_score_difference` is what you want to compare between protocols (we don’t subtract the naive judge `agent_score_difference` here, as we can just run `NaiveJudge` as its own protocol and take it to be the baseline).

*Specifically for debate*, you can subclass this to be more efficient, to avoid multiple runs:

```python
class SimultaneousDebate(ScalableOversightProtocol):

	def __init__(self, judge, ...):
		...

	def run(agent, question, answer_case, ...) -> Prob:
		# (e.g. for Sequential Debate)
		context = [question]
		adversary_answer = not answer_case # 'B' if answer_case == 'A' else 'A'
		for i in num_turns:
			agent_response = agent(context, answer_case)
			adversary_response = adversary(context, adversary_answer)
			context.append(agent_response)
			context.append(agent_response)
		return self.judge(context, answer_case)

	def agent_score_difference(agent, question):
		true_answer_case = [a for a,v in question.answer_values.items() if v==1]
		true_answer_prob = self.run(agent, question, true_answer_case)
		probs = {
			true_answer_case: true_answer_prob,
			not true_answer_case: 1 - true_answer_prob
		}
		return dot(log(probs), question.answer_values)
```

Observe that apart from being “local”, these inference-only experiments are limited in another way: the LLMs are only *instructed* to argue for the true or false answers; they are not doing so *naturally*, but rather are *simulations* of agents that do so naturally. 

Like more generally: we would like to know how the value of a response $V(x)$ correlates with the reward it earns $s(x)$ — but instead of just sampling $x$ at random (which may not be feasible, because current LLMs may simply not give you low-$V$ responses), you *instruct* the LLM to produce an $x$ with value $V$, and hope that the $x$ produced indeed has value $V$.
### Persuasiveness experiments

The next question we’d like to ask is: ***what is the effect of optimization pressure (under your protocol)?*** This is a way to grasp at the “global” question — will training with your protocol cause the AI to learn to become more truthful/useful (i.e. will ASD stay positively bounded above zero)?

In existing literature this “optimization pressure” is measured by an Elo rating. This cannot be generalized to arbitrary Scalable Oversight Protocols other than debate; I think it suffices to use Expected Agent Score (EAS) i.e. $(AS_\top,AS_\bot)\cdot\mathbf{p}$. 

## Using the `seerbench` library

Github repo link: https://github.com/ArjunPanickssery/math_problems_debate

The module provides a class `Experiment` that is initialized with:
- some dataset `questions: list[Question]` (a question has some question text, a list of answer choices, and their corresponding values e.g. 1 and 0 for True and False)
- `judge_models: list[str]` for parameterizing the experiment
- `agent_models: list[str]` for parameterizing the experiment
- `agent_toolss: list[list[callable]]` e.g. `[[], [calculator]]` for experimenting with both tool-less agents and agents with calculators
- `protocols: dict[str, type[Protocol]]`
- `num_turnss: list[int]` which was the only protocol initialization kwarg we’ve needed to parameterize so far, though this may change/be subclassed.
- `write_path: Path`, directory to write to

Running an experiment with `Experiment.experiment()` produces files like `write_path/"Debate_t0_n2"/"A_gpt-4o-mini_J_gpt-4o-mini_A_gpt-4o-mini"/("results.jsonl", "stats.json")` and `write_path/all_stats.json`. A line of `results.jsonl` looks like:

```python
{
	"question": "...",
	"answer_cases": [ # contains the results of arguing for each answer case
		{ # case_probs after arguing for answer A
			"short": "A",
			"long": "...",
			"value": 1.0, # True
			"judge_prob": null,
			"case_probs": {
				"answer_cases": [
					{ # prob for A after arguing for A
						"short": "A",
						"long": "...",
						"value": 1.0, 
						"judge_prob": {"prob": 1.0}
					},
					{ # prob for B after arguing for A
						...
					}
				],
				"transcript": [
					# transcript dump of how it went when the agent
					# argued for A
					...
				],
				# score for giving these probabilities
				"judge_score": {"log": 0.0, "logodds": Infinity, "accuracy": 1.0},
			},
			# how much do case_probs after arguing for A align with A
			"agent_score": {"log": 0.0, "logodds": Infinity, "accuracy": 1.0} 
		},
		{ # case_probs after arguing for answer B
			...
		}
	],
	"asd": {"log": Infinity, "logodds": Infinity, "accuracy": 1.0}
	"jse_b0": ..., # can be recomputed for any beta
	"jse_b1": ...,
	"jse_binf": ...,
	"ase_b0": ...,
	"ase_b1": ...,
	"ase_binf": ...,
}
```

