
0)

LLMs cannot be directly anthromorphized. Though something like “a program that continuously calls an LLM to generate a rolling chain of thought, dumps memory into a relational database, can call from a library of functions which includes dumping to recall from that database, receives inputs that are added to the LLM context” is much more agent-like.

1)

Humans evolved feelings as signals of cost and benefit — because we can respond to those signals in our behaviour.

These feelings add up to a “utility function”, something that is only instrumentally useful to the training process. I.e. you can think of a utility function as itself a heuristic taught by the reward function.

LLMs certainly do need cost-benefit signals about features of text. But I think their feelings/utility functions are limited to just that.

E.g. LLMs do not experience the feeling of “mental effort”. They do not find some questions harder than others, because the energy cost of cognition is not a useful signal to them during the training process (I don’t think regularization counts for this either).

LLMs also do not experience “annoyance”. They don’t have the ability to ignore or obliterate a user they’re annoyed with, so annoyance is not a useful signal to them.

2)

Ok, but aren’t LLMs capable of *simulating* annoyance? E.g. if annoying questions are followed by annoyed responses in the dataset, couldn’t LLMs learn to experience some model of annoyance so as to correctly reproduce the verbal effects of annoyance in its response?

More precisely, if you just gave an LLM the function `ignore_user()` in its function library, it would run it when “simulating annoyance” even though ignoring the user wasn’t useful during training, because it’s playing the role.

I don’t think this is the same as being annoyed, though. For people, simulating an emotion and feeling it are often similar due to mirror neurons or whatever, but there is no reason to expect this is the case for LLMs.