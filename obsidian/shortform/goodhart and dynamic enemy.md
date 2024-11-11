
Something that seems like it should be well-known, but I have not seen an explicit reference for:

***Goodhart’s law can, in principle, be overcome via adversarial training (or generally learning Multi-Agent Systems)***

—aka “The enemy is smart.”

Goodhart’s law only really applies to a “static” objective, not when the objective is the outcome of a *game* with other agents who can *adapt*. 

This doesn’t really require the other agents to act in a way that continuously “improves” the training objective either, it just requires them to be able to constantly throw adversarial examples to the agent forcing it to “generalize”.

In particular, I think this is the basic reason why any reasonable Scalable Oversight protocol would be fundamentally “multi-agent” in nature (like Debate).