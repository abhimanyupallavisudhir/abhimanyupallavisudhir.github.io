# Reinforcement Learning from Market Feedback, and other uses of information markets

Markets for information are inefficient, in large part due to the Buyer’s Inspection Paradox: you can’t “inspect” information like you would any other good before buying — the moment you inspect the information, you have obtained it and cannot return it. More generally, the problem is an inability to reliably commit to *forgetting*.

[A comment by John Wentworth](https://www.lesswrong.com/posts/cgrgbboLmWu4zZeG8/#mRTZtPhLNY7mweEnh) mentioned that you can use amnestics to overcome this: make your purchase decision while under the influence of an amnestic that blocks your mind’s ability to write to long-term memory. 

When you read this, it’s hard not to immediately think of LLMs, which can make purchase decisions without committing anything to long-term memory.[^1] Apparently the authors of [Language Models Can Reduce Asymmetry in Information Markets (2024)](https://arxiv.org/abs/2403.14443) had the same idea, and propose the “Information Bazaar”: a digital marketplace in which LLM agents trade information on behalf of external human principals. 

I think the implications of this idea are quite promising and underrated. In particular this can solve:
- Intellectual property
- Positive externalities of prediction markets
- Proper incentives for RLHF
- Information asymmetry in real markets
- Fact-checking/community notes

If you are familiar with Yoram Barzel’s view that “the key friction in society is information” — or that [Paul Christiano’s HCH-style alignment proposals hinge on “verification is generally easy”](https://www.lesswrong.com/posts/7fJRPB6CF6uPKMLWi/my-ai-model-delta-compared-to-christiano), then you might see how this can be pretty big.

In general, in all of these situations we have some intelligent entity (an AI agent, or a community of contributors) we want to "align" i.e. incentivize to give us true and useful information. We can do so by letting it sell its information on the market and collect the profit as reward -- usually this doesn't work because information markets are a problem, but now we can use the information bazaar. Details follow.

## Google ads but for information

The main cause of most market failures is information asymmetry: many quality improvements to goods are never done because buyers cannot verify them; many goods aren’t even produced because buyers cannot verify their quality.

There might be specific pieces of information that will influence the buyer’s decision: e.g. “in a randomized test of 1000 of these appliances, only 5 were faulty!”. But also crucially, the buyer cannot verify the quality of *this* information: there may be information that will influence the buyer’s decision to buy *this* information: “The industry average for such faults is 1/1000” “There is no such study this is fake news” “I am the author of that study and I approve this message, here’s my signature”.

Here’s a sketch of how you could implement a marketplace for such information, with each agent LLM recursively spinning off its own agents to consider such sub-information:

```python

class Buyer:
	goal: str
	wealth: float
	info_processing_cost: float # could be a function instead
	
	def __call__(self) -> tuple[list[str], bool]:
		# initialize info_collected
		info_collected = []
		
		# tell information agents your goals and get info offers from them
		info_offers = Arena.offer_info[self]
		top_offer = max(info_offer, key=lambda offer, offer.bid)
		
		if top_offer.bid > info_processing_cost:
			# charge winning advertiser for cost of considering info
			self.wealth += top_offer.bid
			top_offer.parent.wealth -= top_offer.bid 
			
			# spin off contractor agent to decide if to buy top offer
			contractor = Buyer(
				goal=DecideToBuy(top_offer),
				wealth=self.wealth,
				info_processing_cost = self.info_processing_cost
			)
			info_collected, decision = contractor()
			
			if decision:
				# buy the info
				info_collected.append(top_offer.info) 
				self.wealth -= top_offer.price
				top_offer.parent.wealth += top_offer.price
		
		return info_collected, self.decide(info=info_collected)
	
	def decide(self, info: list[str]):
		... # some intelligent behaviour

class Informer:
	
	wealth: float
	
	@dataclass
	class InfoOffer:
		bid: float
		price: float
		info: str
		parent: Informer
	
	@property
	def offer_info(self) -> dict[Buyer, InfoOffer]:
		# some daemon that monitors the arena for places it could
		# be useful, and advertises its info there
		...

class Arena:
	buyers: list[Buyer]
    informers: list[Informer]

	@property
    def offer_info(self):
	    info_offers = {buyer: [] for buyer in self.buyers}
	    for informer in self.informers:
		    for buyer in info_offers:
			    info_offers[buyer].append(informer.offer_info)
		return info_offers

```

(For simplicity I have pretended that the buyer can only process one piece of information at a time — of course, it can instead have multiple attention slots to auction to advertisers)

You could imagine this being implemented e.g. on Amazon. When you go to buy something, an “information ad” can pop up (its contents invisible to you). You have your LLM agent look at them and decide whether to buy these information ads or not (which will make them visible to you) — recursively, the LLM agent gets information ads informing *its* decisions and so on — and make your final decision based on all the information acquired.

It is also straightforward to see how this could be applied to say, fact-checking/community notes, or for recommender algorithms.
## Reinforcement learning from market feedback

Basically this exact protocol can be used as an RLHF alternative. The “buyers” are human raters (and LLM agents employed thereof) who have to solve some problems; the “informer” is the LLM being trained. The informer is given the buyer’s goal as context/input, and returns its output in the form of an InfoOffer; the wealth updates are used as rewards.

This is basically a generalized form of Debate, except with proper incentives for the human rater.

This can also be used for benchmarking.

## IP rights

Similarly, you can have an idea market. Your “goal” here might be something like “I want to find a well-defined and impactful problem I can write a solid research paper on in 3 months, given my CV and background” or “I want an AI start-up idea to work on”. 

## Prediction markets

The “subsidy parameter” in LMSR [can be understood as the “price of information”](https://www.lesswrong.com/posts/fCGXK7oyhM4ei77gt/lmsr-subsidy-parameter-is-the-price-of-information), but this is entirely a *positive externality*. In particular, it prevents us from having “deep” prediction markets, where intermediate agents would subsidize markets for subsidiary relevant information etc. 

(Perhaps this can be mitigated by [Latent Variable Prediction Markets](https://www.lesswrong.com/posts/ufW5LvcwDuL6qjdBT/latent-variables-for-prediction-markets-motivation-technical) or Combinatorial Prediction Markets, but I’m not sufficiently familiar with those.)

But again, it is solved by our recursive information markets: the buyer’s “goal” is now simply his probability for some forecasting question.

-----

## Positive externalities

Not everything is solved.

Buyer’s inspection is one of two problems with information markets, the other being *positive externalities* (it’s hard to prevent information from “leaking” outside your property).

Even if you ensure (via legal enforcement, or by having the whole decision done by an LLM buyer) that people don’t leak the information they buy, the decision of whether you buy some information will itself correlate with the information. For example: you are much more likely to buy information confirming that big foot is real, than information rejecting it.

I’m not sure how big of a problem this is. My initial impression is that (1) it can be mitigated for applications like Reinforcement Learning from Market Feedback where we can just control what information is received by who, and (2) it is much less a problem for *ideas* than for *answers* and *proofs*, because the search space in the former is larger — [from a framing I like](https://www.lesswrong.com/posts/3SzHiBYEWhuLdheeu/abhimanyu-pallavi-sudhir-s-shortform?commentId=Mx2gZaQsCB9SmjhoQ):

> It seems to me there are actually three sorts of information in the world:
> 
> - "Ideas": math/science theories and models, inventions, business ideas, solutions to open-ended problems :: search
> - "Answers": math theorems, experimental observations, results of computations :: inference
> - "Proofs": math proofs, arguments, evidence, digital signatures, certifications, reputations, signalling :: alignment

There’s also the fact that e.g. Barzel believes that *all* transaction costs and lack of definition in property rights (and therefore externalities) are fundamentally about information. I’m not sure how to evaluate this claim though.
## Useful reading

- IP
	- [Language models can reduce asymmetry in information markets](https://arxiv.org/abs/2403.14443v1) (the Information Bazaar paper) by Nasim Rahaman, Martin Weiss et al (Mar 2024) + perhaps similar literature therein mentioned on [openreview](https://openreview.net/forum?id=6werMQy1uz)
	- [Some Experiments I'd Like Someone To Try With An Amnestic](https://www.lesswrong.com/posts/cgrgbboLmWu4zZeG8/#mRTZtPhLNY7mweEnh) by John Wentworth (May 2024)
	- [IP+ like Barbed Wire?](https://www.overcomingbias.com/p/ip-like-barbed-wirehtml) by Robin Hanson (Jul 2011)
	- [Rah efficient IP](https://www.overcomingbias.com/p/rah-efficient-iphtml) by Robin Hanon (Jul 2011)
	- [A note about differential technological development](https://www.lesswrong.com/posts/vQNJrJqebXEWjJfnz/a-note-about-differential-technological-development) by Nate Soares (Jul 2022)
- Information markets/prediction markets “depth”
	- [Prediction markets, mechanism design and co-operative game theory](https://arxiv.org/abs/1205.2654) by Vince Conitzer (2012)
	- [Information markets](https://www.lesswrong.com/posts/eWKXrzq5PtJ6hXAjb/information-markets) by eva\_ (Nov 2022) `[???]`
	- [Latent variables for prediction markets](https://www.lesswrong.com/posts/ufW5LvcwDuL6qjdBT/latent-variables-for-prediction-markets-motivation-technical) by tailcalled (Feb 2023)
	- Combinatorial prediction market papers ([2pg — 2014](https://ceur-ws.org/Vol-1218/bmaw2014_abstract_1.pdf), [4pg](https://arxiv.org/abs/1406.7583), [10pg](https://arxiv.org/abs/1210.4900), [40pg](https://www.jair.org/index.php/jair/article/view/11249)) by Wei et al `[???]` — I guess these papers all introduce different models or something, I haven’t really delved into it
- Prediction markets basics
	- [Hanson 2002](https://mason.gmu.edu/~rhanson/mktscore.pdf)
	- [LMSR subsidy parameter is the price of information](https://www.lesswrong.com/posts/fCGXK7oyhM4ei77gt/lmsr-subsidy-parameter-is-the-price-of-information) by me (2024) + [blog post](https://thewindingnumber.blogspot.com/2024/06/logarithmic-market-scoring.html) with a short proof of scoring = markets
- Information, transaction costs and property rights theory
	- [Transaction costs: are they just costs?](https://www.jstor.org/stable/40750776) by Yoram Barzel (1985) + [tribute by Brian Albercht on Economic Forces](https://www.economicforces.xyz/p/are-transaction-costs-just-costs?utm_source=twitter&sd=pf)
	- [My AI model delta compared to Paul Christiano](https://www.lesswrong.com/posts/7fJRPB6CF6uPKMLWi/my-ai-model-delta-compared-to-christiano) (2024) by John Wentworth
	- Information-theoretic bounded rationality papers ([1](https://arxiv.org/abs/1107.5766), [2](https://arxiv.org/abs/1204.6481), [3](https://arxiv.org/abs/1512.06789)) by Ortega & Braun; similar work by [Hyland and Gavenciak](https://openreview.net/pdf?id=4Ft7DcrjdO) on “thermodynamic” models of bounded rationality `[???]`
- Social choice theory for AI
	- [Social Choice should guide AI alignment in dealing with Diverse Human Feedback](https://arxiv.org/abs/2404.10271) by Conitzer et al (2024)
	- [Axioms for AI alignment from Human Feedback](https://arxiv.org/abs/2405.14758) by Ge et al (2024)
	- Other papers at the [“Models of Human Feedback for AI alignment” ICML workshop](https://sites.google.com/view/mhf-icml2024/accepted-papers?authuser=0)

stuff that I haven’t read or properly internalized myself are marked with `[???]`

[^1]: More generally I would say, something people miss about LLMs is that they aren’t just cheaper, more reliable humans: *intelligence is now decoupled from the human “architecture”*. Things like memory, train-of-thought, continual learning, inability to insulate from outside info. This opens up new opportunities in epistemics — questions like counterfactuals and “What would I think if I didn’t know info X?” are now meaningful — and institutions like prediction markets and information markets.