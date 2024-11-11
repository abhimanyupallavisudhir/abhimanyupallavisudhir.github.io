Logic courses are very risk-averse to talking about philosophy. This is bad, because philosophy is the motivation/intuition for logic & TCS. This essay gives a scout's view.

*Epistemic status:* A computer scientist would nod through Chapters 2-5, at least after first looking at the logician for approval. Subsequent chapters take a philosophical stance, namely that expressed in the title.

## Contents

1.  Motivation and a cringey rant [skip for the technical meat]
2.  Gödel's first incompleteness theorem
3.  Gödel's second incompleteness theorem
4.  Semantics and truth
5.  Exercises
6.  Reflection and ordinals
7.  Chaitin and complexity
8.  Empiricism and the Löbstacle

(A rough version of Chs 1-5 post initially appeared as a [math stackexchange answer](https://math.stackexchange.com/questions/3768672/how-important-is-first-order-logic-to-g%c3%b6dels-incompleteness-theorem/4559696#4559696) and on my [blog](https://thewindingnumber.blogspot.com/2022/10/a-crash-course-on-mathematical-logic.html); I wrote it as I learned, and am posting more refined writing here.)

## Motivation and a cringey rant [skip for the technical meat]

There are several immediate philosophical questions a beginner may ask when first hearing of Gödel's incompleteness theorem, such as: 

1.  Does Gödel's theorem apply to humans? If so, how are we able to tell that the Gödel sentence is true, or that some program doesn't halt?
2.  Does Gödel's theorem imply that there are questions about the universe, or about mathematics, whose answers we can never learn? Are these questions at least comprehensible to us?
3.  What's with the suggestive analogy between logic and computation, and how can we make it more precise? If Gödel applies to humans, are we formal systems or programs?
4.  If "true" is different from "provable", what does "true" even mean?
5.  How do we know that (e.g.) ZFC is consistent? We keep talking about the "true" model, how do we even identify this true model? 

Unlike other areas of science that lay-people find weird and philosophers say absurd things about (such as relativity and quantum mechanics), these questions are honestly legitimate and relevant for AI work (the only such question that *isn't* legitimate is "Does Gödel preclude a TOE?"). 

Some [*very wrong*](https://xkcd.com/2494/) ways to answer these questions/to introduce mathematical logic:

1.  Gödel's theorem applies to specific types of formal systems, and says nothing about human reasoning. It just means we can't apply an *algorithm* to answer every question, not that we can't do so by other, more creative means! [Dude, do something non-algorithmic and show me.]
2.  Gödel's theorem is no biggie! It's just like how commutativity is independent of the axioms of group theory! [I literally can't predict if "Halt if Abhimanyu thinks I don't halt" halts, and you think this is like commutativity??]
3.  It's ok, you just need a stronger set of axioms. [But how do I know which axioms to use? You can't just say "observe the real world and figure it out"; we believe in arbitrary strengthenings of ZFC without doing any observations for it, so there must be some theoretical reasoning.]

It's a terrible habit, motivated by an averseness to risk and effort, of just giving the minimal technically-correct answer that still allows you to cover your ass and feign wisdom when someone [rights their wrong question](https://www.lesswrong.com/posts/rQEwySCcLtdKHkrHp/righting-a-wrong-question), by pompously sneering "that's a *completely* different question!" [*You knew what my question was! You could have made it more precise too!*]

It's like how religious people deal with "questions we cannot answer" by making up "answers we may not question"; now religious people no longer exist, so instead we have Redditors, who've found yet another way to deal with it: "deny that the question exists". 

You may go your entire life dismissing the questions that enter your mind as being imprecise, even though there are ways to tell that *there is something of non-trivial value there*, never saying anything that doesn't offer the security of already having been said in a textbook to protect you ...

... but hey, this way at least no one will call you a crank for entertaining weird questions.

(There are kids out there starving for [an interesting problem to work on](https://www.lesswrong.com/s/PtgH6ALi5CoJnPmGS/p/5tXiw9PBCqFLHs2Mp), and you're going to deny and strawman the ones you *get*?!!)

(This is how frequentist statistics survived for so long, by the way. *Yes*, it is technically true that "5% is the probability of the data given the null hypothesis, not the converse", but also completely useless to pretend that that's where the reasoning ends, because at the end of the day you need to *act* based on these probabilities, and for that you need the probability of the null hypothesis being true, no matter how "arbitrary" it is to calculate this. The Bayesian is the [man in the arena](https://www.goodreads.com/quotes/7-it-is-not-the-critic-who-counts-not-the-man), while you're just in the audience going "I can't talk about being the man in the arena, I can only talk about what I'd do if I *were* the man in the arena ... ")

## Gödel's first incompleteness theorem

Here's a general version of Gödel's first incompleteness theorem:

> Let Bob be a computer programmed to read Alice's mind, and do something different from what Alice expects him to do.
> 
> Then Alice cannot predict Bob's actions. She must either have no opinion of it (incomplete) or have a wrong opinion of it ($\Sigma_1$-unsound).

That's it. It's just a particularly adversarial measurement problem. There's only two assumptions that this requires:

1.  Alice can conceptualize computers.
2.  Bob is able to read Alice's mind.

If Alice is a formal system (where the latter reads as "Alice's theorems are computably enumerable"), this is the classic theorem.

If Alice is just some arbitrary algorithm, then this is the Halting problem.

You can play the part of Alice and write Bob as a program on your computer.

*Gödel's argument (and also e.g. Quine's paradox) works by introducing self-reference through logical correlation. You can't even have beliefs on "the rest of the world", because the rest of the world can contain models of you.*

## Gödel's second incompleteness theorem

Realistically, if Alice were an enumerator for a formal system, and Bob was a program "halt iff Alice proves I don't halt", then Bob would never halt, and Alice would be unable to prove this fact. But surely if this were *us* running the enumerator, we would realize this (*"Clearly the only possibility is that Bob doesn't halt but I don't prove this"*). Is this a limitation of formal systems?

Of course not; we can formalize this reflective reasoning too: 

$$\begin{align*}&\text{Bob halts} \\ &\implies \text{Alice proved Bob doesn't halt} \\ & \implies \text{Bob doesn't halt} \\ & \implies \text{Contradiction} \\  & \therefore \text{Bob doesn't halt} \end{align*}$$

And you realize the implicit assumption made in this reasoning, that if Alice proves something, it is true [i.e. Alice is sound]. Alice is not allowed to believe this. This is Gödel's second theorem. 

Notice how we are only allowed to deduce that Bob never halts when Bob depends on the beliefs of the proof enumerator/Alice *only*, NOT when Bob depends on our more reflective belief. We are allowed to believe in the soundness of this proof enumerator/Alice, we are not allowed to believe in the soundness of our "entire" belief.

## Semantics and truth

Does a person (or computer) really "compute", do they really have "beliefs" and "preferences", or are they just a physical process?

Any work with agents/computer science necessarily involves a layer of "interpretation" to assign meaning to their actions, or to decide that their beliefs are "true". 

> A *language* captures an agent's imagination; a *theory* captures an agent's beliefs. 
> 
> In formal logic, a language is a set of strings ("sentences") and a theory is a subset of those strings ("theorems"). 
> 
> Often-time, the theory is specified as the set of consequences (following some rules called a "logic") of some "axioms". We like this set to be computably enumerable.
> 
> Bob can *simulate* Alice if he can imagine things like "Alice believes X". This only requires his imagination (language) to be expressive enough. He needn't know everything that Alice believes, just be able to imagine that she does. 
> 
> Bob can *model* Alice if he can translate her imagination into his by a computable function (for FOL theories this translation function is the [T-schema](https://en.wikipedia.org/wiki/T-schema)) and believes the things she believes. This requires his beliefs (theory) to be strong enough. 
> 
> Hopefully this puts the question "What's stronger, logic or computation?" completely to rest. A theory may be expressive enough to simulate any program, that doesn't make it strong -- even PA simulates ZFC. But for any meaningful theory, there's a program that models it. 
> 
> A simulation is a superficial understanding. You can simulate topology by learning the axioms and applying them randomly, with no understanding of why it's useful.
> 
> A model is a deep understanding. If you have a mental model of topology, i.e. if you have things that its theorems apply to and are convinced that they apply to them, you can apply the heuristics you already have for these things to develop the theory.
> 
> There is a particular perspective in logic where you fix a base theory (a "foundation for mathematics") and consider all other theories in its semantics, i.e. as modelled by it. This is called *model theory*, and it makes perfect sense to study logic this way, because that's how we study all other mathematics! But that's not useful for philosophy.

If Bob models Alice, he judges a thing imagined by her to be "True" if he believes it (or rather his translation of it). This is the definition of truth according to ["Convention T"/"the semantic theory of truth"](https://en.wikipedia.org/wiki/Semantic_theory_of_truth). There are [other definitions of truth](https://en.wikipedia.org/wiki/Semantics_of_logic), but interpretation is fundamental to all of them.

Now that we have defined truth, we can formulate the Liar paradox.

> [*We can think of sentences and theorems as "questions" and "answers" respectively. A valid sentence of Alice is a question she might ask, a true theorem of Bob is an answer he may give.*]
> 
> For any sentence P, suppose Alice can ask "Is P true?" such that Bob will answer YES iff he believes P [this is the definition of truth, per Convention T].
> 
> But then what if P is the liar sentence -- or in terms of Convention T, "Bob will answer YES to the opposite of this sentence"?

This leads to "Tarski's theorem": Alice *can't even ask* "Is P true?", can't even formulate a general notion of truth (of Bob believing his interpretation of her statement), because when truth is relative in this sense, formulating truth would lead to a tower of increasing complexity: "Is P true?" really asks "Would Bob answer YES if I asked him P?", but Bob then needs to interpret *this* sentence [answer *this* question], ad infinitum.

## Exercises

1.  Turing degrees
    1.  Prove the unsolvability of the Entscheidungsproblem [that there is no algorithm that determines if ZFC proves a given statement].
    2.  Your immediate reaction should be one of puzzlement, that ZFC apparently "knows more" than any algorithm does, apparently breaking what earlier seemed to be a symmetry between logic and computation. Resolve this confusion. [You should arrive at the notion of "Turing equivalence". I would also formulate the precise correspondence between logic and computation as: Theories (at least the ones that we care about, i.e. can realistically capture an agent's beliefs) *are* programs, namely their theorem enumerators. But also theories are capable of proving things about programs, just as they are capable of proving things about stronger theories; they just don't believe those things themselves.]
    3.  List examples of things that are Turing equivalent. 
    4.  A Turing equivalence class is called a Turing degree. In particular, we denote the class of computable sets by $\varnothing$ (the smallest Turing degree), and denote the class of successive Halting Oracles by $\varnothing',\varnothing'',\dots\ \varnothing^{(n)},\dots$
2.  Arithmetical hierarchy
    1.  There is a fundamental relationship between $\exists$ statements and computable enumerability. State this precisely. [You should arrive at the definition of a "$\Sigma_1$-decidable problem".]
    2.  What about $\exists\exists\exists\exists$ statements?
    3.  What about $\forall$ statements?
    4.  What about $\exists\forall$ statements?
    5.  You should now be able to motivate the "*Arithmetical hierarchy*" -- the hierarchy of FOL sentences (equivalently FOL-definable sets): a $\Sigma_n$ sentence is one that starts with some exists then alternates $n-1$ times between consecutive sequences of foralls and exists; a $\Pi_n$ sentence is one that starts with some foralls then alternates $n-1$ times between consecutive sequences of exists and foralls. 
    6.  Prove Post's theorem: that $\Sigma_{n+1}$ is precisely the set of problems that are computably enumerable by a Turing machine with access to an Oracle for $\varnothing^{(n)}$.
3.  Miscellaneous paradoxes
    1.  Gödel's second theorem and Tarski's theorem are both ways of suggesting that "you can't have a belief about your truest beliefs". A third way, Löb's theorem, says: if $T \vdash ((T\vdash P)\implies P)$, then $T\vdash P$. I.e. the only things you can believe in your soundness for are the things you believe anyway. Prove this theorem using Curry's paradox ("If this sentence is true, then Germany borders China.") as a hint. Phrase this in terms of a computer program.
    2.  Suppose instead of Contrarian Bob, we have Conformist Carl, who reads Alice's mind and halts iff she believes he will. Will Carl halt? [It's *shocking* that Löb's theorem has such a thing as an application.]
    3.  But isn't Carl's situation symmetric? If instead Carl were to just follow "do whatever Alice believes he will", what would happen? [Formulate this situation very carefully logically.]
    4.  Formally write down Berry's paradox and figure out what goes wrong there.
    5.  Formally write down the jailor paradox and figure out what goes wrong there. [Answer: such a jailor actually cannot exist, but you need to argue this carefully.]

> ... the trend of how many results are treated: first they are considered major results, then interesting results, then they become exercises in yellow books.
> 
> ([a comment by a certain Joshua Zelinsky on Shtetl-Optimized](https://scottaaronson.blog/?p=697#comment-25044))

## Reflection and ordinals

[Eliezer has suggested](https://www.lesswrong.com/posts/rm8tv9qZ9nwQxhshx/you-provably-can-t-trust-yourself) that Gödel's second theorem can be intuitively understood as a statement of humility: "you can't believe something just because you believe it" (perhaps suggesting that we should therefore find the theorem unsurprising as a result). I'm not sure that this is a correct explanation; the word "because" is rather trippy here, and you also can't believe that you're right 80% of the time or 20% or something (or have a calibration map). I think it is a [fake explanation](https://www.lesswrong.com/posts/fysgqk4CjAwhBgNYT/fake-explanations); it's like saying neural networks are to be expected because they look like brains or because the world is hierarchical or something. It's an attempt to [*make Gödel intuitive*, rather than *make your intuition model Gödel*](https://www.lesswrong.com/posts/tWLFWAndSZSYN6rPB/think-like-reality). Similar analogies to education systems trying to "make math fun", when they should be training the children to naturally be excited about math.

The correct understanding of Gödel's second theorem -- as well as Tarski's theorem, and Löb's theorem -- I think, is that *you are not allowed to have beliefs about your beliefs*. Or rather: you are not allowed to have beliefs about your truest, most final beliefs. 

Because your beliefs just can't be *big enough* to contain themselves. Even in the most basic setting -- if you have a universe that is in one of two states, a sample space of $S=\{0,1\}$ but then you add an agent that believes one of those states to be true, your sample space of the universe *including* that agent needs to be $S^2$. If you want the agent's beliefs to be complete for *this* sample space, you then go up to $S^4$, etc. 

But at no point can you ask the agent's beliefs to be *fully* complete -- to be complete for *itself*. There's just not enough space, and just as the traditional Cantor diagonalization is a proof of "not enough space" for cardinalities, the diagonalization arguments found in Gödel proofs are natural generalizations of this idea.

Don't get me wrong -- you can certainly have beliefs like "I believe that I believe there is a dragon", etc. It's just that this will always be at a higher "level" than the earlier set of beliefs, so that earlier set of beliefs doesn't express the set of *all* your beliefs, so you can never quite quantify over *all* your beliefs, at all levels. The reason why it's OK for us to "informally believe but not prove that Bob never halts" has nothing to do with that belief being informal, it is because the formal system no longer represents our true belief, and Bob is only trying to fuck with our formal system, not our true belief. But Bob can always fuck with our true beliefs if he wants.

How far can we actually reflect on our beliefs? You may think one can have beliefs about beliefs, beliefs about beliefs about beliefs, etc. -- for any integer. This is equivalent to thinking "At t = 0, I think Bob will halt; at t = 1, I realize this belief of mine means that Bob will not halt; at t =3, I reflect on *that* and realize that Bob *will* halt, ... " But are not constrained to be so stupid, we can also predict all our future such reflections and immediately, in finite time, form a belief about all the reflections that we *would* have done if we had been so simplistic. We could call this reflection $\omega$, and we can accomplish it in t = 1, then at t = 2 we reflect on *that* ...

In general, we can reflect up to any *ordinal*. For the $\{0,1\}$ toy model described earlier, the idea is that the set of beliefs at stage $\omega$ would be $S^\mathbb{N}$ (aka $\mathbb{N}\to S$), i.e. agent $\omega$'s belief is a function that takes in a natural number $i$ and gives agent $i$'s belief [which is itself a vector of size $2^{i-1}$] ... but there's a caveat! Not every function/binary sequence can realistically represent the beliefs of a computable agent, only the *computable* ones can. The beliefs of each agent is a *program. *

[Let that sink in.]

Here are some general constructions for agents that reflect up to particular ordinals ($f$ is some pre-specified computable function that defines how the agent reflects).

      agent(n) = function():
      	initialize B
      	n times:
        	B = f(B)

    agent(omega) = function(i):
      	initialize B
      	i times:
        	B = f(B)

    agent(omega + n) = function():
      	agent(omega) = function(i):
      	    initialize B
      	    i times:
      	        B = f(B)
      	 n times:
      	     B = f(B) 

    agent(omega * 2) = function(i):
      	agent(omega) = function(j):
      	    initialize B
      	    j times:
      	        B = f(B)
      	 i times:
      	     B = f(B) 

    agent(omega * n) = function(i):
         initialize alpha(omega * 0) as before
      	 B[0] = alpha(omega * (n - 1))
      	 i times: B = f(B)

    agent(omega ^ 2) = function(i):
      	 initialize alpha(omega * n) as before
      	 return alpha(omega * i)

OK I've written these programs in ridiculous short-hand -- in reality the program for agent $\nu$ is a function that takes as input any ordinal $\mu<\nu$ and give as output the program for agent $\mu$. 

But for a general ordinal, this function may not be computable! In particular, since any computable ordinals may be inputted as the code for the program that decides the corresponding order, this means that the belief "program" for $\omega_{\mathrm{CK}}$ can take any program as input, discover what order it computes, and output that program's belief program. This is a violation of [Rice's theorem](https://en.wikipedia.org/wiki/Rice%27s_theorem), which says that there is no algorithm that can determine what any algorithm does [obviously!], so "agent $\omega_{\mathrm{CK}}$" isn't a computable program. 

*You can only reflect up to computable ordinals. The Church-Kleene Ordinal places a hard cap on reflection; you can get arbitrarily close to it (i.e. exceed every computable ordinal), but never reach it.*

This wisdom transfers over to strengthening a theory by reflecting on it. There is a program that enumerates $T+N$ (the $N$-th reflection of $T$) for all computable ordinals $N$, but no more. The minimal length of this program (Kolmogorov complexity) is non-decreasing in $N$, and approaches $\infty$ as $N\to\omega_{\mathrm{CK}}$.

## Chaitin and complexity

REALITY CHECK: you *cannot* reflect up to any arbitrary computable ordinal [a program that can reflect up to any arbitrary computable ordinal has complexity $\omega_{\mathrm{CK}}$, i.e. not a program]. Or rather: *you* cannot reflect up to any arbitrary computable ordinal -- you are some program, and you are bounded by whatever your computational power is.

Things are not so hopeless. You can build a computer that is better than you -- so in the end, you are only limited by the computational power of the universe/of physics.

*But don't we understand, intuitively, transfinite induction up to arbitrary ordinals?*

No -- because you are not capable of actually reasoning with these extremely strong theories, so such a "belief" has no meaning, much like you can't reason with an uncomputable theory. You can *imagine* such a theory, but you cannot believe it.

We can formalize these complexity-theoretic considerations:

*   *Chaitin's incompleteness theorem.* No program of length $L$ can determine the semantics of programs of algorithmic complexity even slightly over $L$.
*   Proof: Consider the program that prints out statements of the form "such program does such thing", and once it's exhausted all programs of length $<L$, it does something that it has never printed a description of before. 

The natural question to ask here: is the converse true?

*   [Q1.raw] Is halting for programs of length $< L$ always decidable by a longer program?
*   [.answer] Actually, this is a wrong question: there's an obvious stupid algorithm that just gives the right answer for each program, since the problem is finite -- it's just that if we write down this "algorithm", it would just be arbitrary, we would have no way to trust that it does what we think it does.

> *Aside.*
> 
> That's why we have *logic*! 
> 
> More precisely: that's why we have *semantics*.
> 
> The program `a = [1, 0, 0, 0, 1, ... ]; return a[turing_number(input)]` *could* decide halting for programs of length < n, but the only way to even claim that this is what the program does, to assign meaning to the program's actions, is through the eyes of another program which models (*not* just simulates) it.
> 
> At the end of the day, we want to know if *we* -- or rather, the universe -- can know that a program halts. Or in other words: 
> 
> *The things that are meaningful are the things that the universe possess a semantics for.*
> 
> So if you ever wondered "how do we find the right axioms?" or "what does logic really mean?" -- remember: the axiom of choice is *just metaphysics.*

*   [Q1.righted] For any $L$, is there a computable ordinal $N$ such that halting for programs of length $<L$ -- no, scratch that, *all arithmetical sentences* of length $<L$ -- are decidable by $\mathrm{ZF}+N$?
*   [.comment] It seems [(link)](https://mathoverflow.net/questions/67214/pi1-sentence-independent-of-zf-zfconzf-zfconzfconzfconzf-etc) that this was the subject of Turing's PhD thesis at Princeton, and that the answer is that $\omega+1$ suffices for halting for all $L$? But I'm not sure this is the same as what I'm asking for ... other relevant MathOverflow resources: [(link)](https://mathoverflow.net/questions/432470/do-we-expect-that-sufficiently-large-computable-ordinals-settle-every-question-o) [(link)](https://mathoverflow.net/questions/164148/is-there-a-computable-ordinal-encoding-the-proof-strength-of-zf-is-it-knowable)
*   [.UNANSWERED\_I\_BLEG]

## Empiricism and the Löbstacle

The "Löbstacle" can generally be defined as the question, "What is the rational basis for reflection and self-improvement (building a better computer)?" Even if we give a rational basis for reflection up to our *own* complexity, how could we possibly give a rational basis for "trusting the universe's computations"? -- if the universe is more complex than us, how can we assign semantics to it?

I believe the answer is *empiricism*. There isn't a way to say this without sounding like a deranged hippie, but I'll try: if a small program has access to a larger program (can run it and use its outputs), then for all intents and purposes, the latter can be considered a part of it (just like Alice cannot predict the actions of Bob, because by being able to read her mind, he is actually being more complex than her).

It's like, if we were a formal system we would have an axiom: *whatever is observed is valid* -- and this gives us access to all the computations the universe has performed yet. 

This is far from a formalized solution to the Löbstacle, but I think it's the right idea.

And that's all I'll say.

[ETA: not *all* empiricism is this. Empiricism also addresses regular statistical uncertainty, i.e. uncertainty about syntax, not just algorithmic uncertainty, i.e. uncertainty about semantics.]

## General reading

Things I read:

*   Ron Maimon's answer to [*Was mathematics invented or discovered?*](https://philosophy.stackexchange.com/questions/1/was-mathematics-invented-or-discovered)
*   Gregory Chaitin's [*Gödel's theorem and information*](https://www.cs.ox.ac.uk/activities/ieg/e-library/sources/georgia.pdf)
*   Rising Entropy's [*Consistently reflecting on decision theory*](https://risingentropy.com/consistently-reflecting-on-decision-theory/)
*   Scott Garrabrant's [*Bayesian probability is for things that are space-like separated from you*](https://www.lesswrong.com/posts/FvcyMMaJKhYibtFDD/bayesian-probability-is-for-things-that-are-space-like) 

Might also be worth reading on (but I haven't covered, because I don't understand the importance of) proof-theoretic ordinals. I believe a standard source is Rathjen.