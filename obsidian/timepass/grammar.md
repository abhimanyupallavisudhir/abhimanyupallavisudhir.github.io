# Preamble

## Introduction

Translate into Senscript: *The only statements that ought to be made arethose about reasoning, or about observation, or about action. Fromobservation, arises prediction, but only for the purpose of action, andthus the axioms of action form the axioms for all behaviour. Butlanguage is not philosophy. The statements that are made are not thesame as those that ought to be made -- metaphysical and otherwisemeaningless statements are made. Language and its grammar mustaccommodate these statements.*

Name "Senscript"

## Document conventions

Document conventions -- code, italics, underline

# Grammar

## Words and operations

### Sets, attributes and events

The fundamental axioms of Senscript are the existence of *events* (or *states*, if you prefer), *sets* and *attributes*. The grammar of thelanguage simply comprises of specific statements we can make about these objects. Sets are sets of events, and events are determined by their attributes that are given as tuples of sets. Intuitively, one should imagine a state or event as a very specific state an object is ever in, or a very specific event that ever occurs.

Examples of events (here *dog1*, *run1*) etc. are names given to the events, and not actually accessible in the language itself:

```
y1 = <dog1 thing = dog, owner = (me, you), time = tomorrow,...>

y2 = <run1 thing = run, time = yesterday, location = along Main Street, manner = fast, doer = me, ...>
```
Examples of sets:

```
dog = {
    <dog1 thing = dog, owner = (me, you), location = Earth>, 
    <dog2 thing = dog, owner = me, location = Mars>,
    <dog1 thing = dog, owner = me, location = Earth>, 
    ...
}

eat = {
    <eat1 thing = eat, doer = (me, you), doee = rice, time = now>,
    <eat2 thing = eat, doer = you, doee = dragon, time = yesterday>,
    <eat3 thing = eat, doer = me, doee = serpent, time = yesterday>,
    ...
}
```

In practice, events will have a massive number of attribute sets and aset will contain a massive number of member events.

The "words" of Senscript are sets. The relation between sets and statesis expressed through attribute extraction with the `$` sign -- e.g.`y_1$owner` is `(me, you)`, `y_2$doer` is `me` etc. -- and through the standard interpretation of a word `W` as `W = { y | y$thing contains W }` --e.g. *dog* is the set of all states of dogs, etc. A more generalconstruction for words (based on attributes other than `thing`) will bediscussed in the `Apostrophication` section.

Worth noting is that the names of the attributes are not of centralimportance -- one could access `y_1$thing` as`y_1$animal` or something just as well. The name of theattribute must be a valid Senscript word, but the behavior of attributesis purely axiomatic.

### Apostrophication

Given a word `W` and an attribute `s`, we definetheir apostrophication `W's` to be the set:

```
{ y | y$s intersects W/~ }
```

Where

```
W/~ := { V | Exists z in W, V in z$thing }
```

(this is not actually a quotient, because we don't actually have anequivalence relation)

> [!example] Examples
> - `planet'location` is the set of states of things located on planets.- `country'nationality` is the set of people with countries as their nationalities.- `country'nationality'owner` is the set of things whose owners have countries as their nationalities.

> [!info] Comparisons to human languages:
> - *Prepositions*: Approximately "in" translates to `'location`, "at" translates to `'time`, "of" translates to `'owner`, "to" translates to `'purpose`, "because of" translates to `'cause`, and so on. I say "approximately" because these prepositions are not really well-defined in English, and their use just depends on the words they're used with. That's not the case in Sensescript.
> - *Possession*: Same as the "of" example, the 's postposition can indicated by `'owner`.
> - `Subject/object`: `'doer` indicates that the preceding word is the subject of the current verb, `'doee` indicates that the preceding word is the object of the current verb. E.g. Hindi has a subject post-possession (the word "nae") that sometimes appears. In Sensescript, these indicators are essential.
> - *Adverbs*: in particular, prepositions produce adverbs. E.g. `fast'manner` is an adverb of manner (the set of fast activities), `Earth'location` is an adverb of location, etc.

More complicated adverbs like "during", "across", "along" will eventually be discussed.

### Intersection, union, complement

The key to forming sentences in Sensescript is set intersection, or specification. This is done by writing the sets adjacent to each other in any order.

The simplest example is the application of adjectives: `happy banana`refers to the set of things that are bananas, and are happy (`banana happy` also means the same thing). This can be used to form intersections that are not generally kosher in English, such as `swimmer banana` (set of things that are bananas, and are swimmers) or `happy inedible` (set of things that are happy and inedible).

But the true power of set specification lies in using it with verbs, to specify adverbs, subjects and objects. For example, the following term:

```
me'doer (along Main Street) future'time fast'manner run
```

Clearly means "the set of all fast runs I will make along Main Street". In standard English grammar, "run" is a verb, "fast", "in the future" and "along Main Street" are adverbs of manner, time and location, and "I" is the subject. But it is clear that this distinction between subjects, objects and adverbs is quite arbitrary. This is even clearer in the following example:

```
you'doer letter'doee Bob'recipient send
```

Which is "the set of all instances of you sending a letter to Bob". There is no fundamental reason why the letter is the object and Bob is the qualifier -- it could very well be the other way around. It makes more sense to think of verbs as functions that take multiple "adverb" parameters.

Note that we still haven't shown any Sensescript *sentences*. This will require us to make an assertion about the result of the intersection (we will call this the *characteristic set* of the sentence), such that itis nonempty.

Note that there are no rules for ordering words -- set intersection is symmetric. You could, for instance, try to emulate the conventions of English or another language. I prefer a verb-last syntax.

Comparisons to human languages:

- *Usage of adverbs*

An important example to note is the apostrophication of an intersected set. This allows us to show adjectives (including possessive adjectives).

> [!example] Examples
> - `(happy dog)'doer rice'doee eat` is the characteristic set of "some happy dogs eat rice".
> - `(dog king'owner)'doer rice'doee eat` is the characteristic set of "some of the king's dogs eat rice".

> [!info] Comparison to human languages
> - *Adjectives*: as we saw above.
> - *Possessive adjectives*, including *possessive determiners*.
> - *Restrictive relative clauses*: This seems like a natural extension of the same principle (think of e.g. "Some dogs that eat rice killed the dragon yesterday."), but is surprisingly difficult. We will see how to handle them in the section *Dollar expressions*.

Also worth noting are the complement of a set `W`:-`W`, (e.g. *-dog* is the set of states that are *not* dogs,*-happy* is the set of all states that are *not* happy, *-run* is the set of all events that are not running) and the union of sets`V` and `W`: `V`+`W`.

> [!info] Comparison to human languages
> - *Not* and *or* (*and* is simply the use of tupled attributes)

> [!example] Examples
> - `me'doer (wheat+(tasty food -rice))'doee eat` is the characteristic set of "I eat wheat or tasty food that isn't rice".
> - `me\'doer (today+tomorrow)'time eat` is the characteristic set to "I will eat today or tomorrow".
> - `dragon'doer (their prey) (eat+spare)` is the characteristic set to "Some dragons either eat or spare their prey". It may be a good idea to think about how one may add "but don't kill them for sport" to the sentence -- and how to write "their prey" in Sensescript.

### Lambda expressions

We introduce the following syntax, where `p` is an expression that takes a set and outputs a sentence (we haven't yet discussed sentences, but you know what we're talking about -- see the*Sentence types* section for more information):

```
(λun p(un)) = { y | p({y}) is true }
```

The un is arbitrary and can be replaced with any string of text (preferably fewer syllables) with exactly one nasal *n* (i.e. the topmost *n* of the Indic alphabets) that it ends with. It exists to prevent ambiguity in nesting lambda expressions -- a nested lambda expression should use different lambda-suffixes.

> [!example] Examples
> - `dog (λun un'doer eat.)` is the set of dogs that eat (while this is technically the characteristic set for "some dogs eat", it is easier to state the logically equivalent statement `dog'doer eat`).
> - `dog (λun un'doer (un'owner tail)'doee chase.)` is the set of dogs that chase their own tail.
> - `dog (λun un'doer (person (λan an'doer un'recipient yell.))'doee chase.)` -- (a nested one) characteristic set for "Some dogs chase people who yell at them."
> - `horse (λun mouse (λan an'doer un'doee kill. and un'doer an'doee kill.).).` -- (a nested one) "Horses and mice kill each other" (note: there's some ambiguity here -- we're saying that there exists a horse-mouse pair that kills each other, not that some horses kill mice and some mice kill horses) -- we will be able to simplify this later with factorization.

> [!info] Comparison to human languages

> - *Restrictive relative clauses*: This is important for the restrictive relative clauses mentioned in the *Adjectives in a sentence* section. As an example: `(dog [λun'doer eat.])'doer kill` is the characteristic set for "Dogs that eat kill".
> - *Reflexive grammar*: i.e. words like "own" and the suffix "-self".
> - *Reciprocal grammar*: i.e. "each other", "one another"
> - *Impersonal pronouns*: The only example of this from English is the pronoun "one" and its derivatives, but Indian languages provide a much clearer picture of such pronouns, e.g. the Kannada words "taanu" (roughly "one") and "tanna" (roughly "one's own") or the Hindi word "apna" (roughly "one's own"). Sensescript demonstration: `he [λun'doer (λun'owner rice)'doee eat.]` ("he eats *apna* rice"). This can also be done more simply with variables, which we will see in the *Variables* section.

### Big operators

Binary operators (that are associative, commutative) can be extended into "big operators" by prefixing with a backslash `\` -- the binary intersection can be upgraded to the arbitrary intersection, the binary union can be upgraded to the arbitrary union, as in mathematics. The format is as follows:

```
\+(P(un))(f(un))
```

```
\*(P(un))(f(un))
```

Which represent the intersection/union respectively of all sets`f(un)` such that the sentence `P(un)` holds. unis an index (and is set-valued of course) and can be replaced with any string of characters that ends with exactly one palatal *n* (i.e. the second row of the Indic alphabets) that it ends with -- contrast with the nasal *n* used for the lambda-expressions.

> [!example] Examples (for big intersection)
> - `\*(un person.)(king (λan an'doer un'doee rule))` is the set of kings who rule all people. Note that one could've used un for the lambda expression unambiguously outside of Latin script, as the *n* is different.
> - `\*(un dog (λan an'doer (an'owner tail)'doee).) (king (λan an'doer un'doee rule))` is the set of kings who rule all dogs that chase their own tail.

> [!example] Examples (for big union)
> - `\*(un person. and en action.)(king (λan an'doer un'doee en))` is the set of kings who do every action to every person. I don't know why that would be useful, but it's an example of a multivariate indexing.

## Anchors and variables

### Anchors

Some specific states are in-built, called *anchors*, allowing the formation of words relative to it. There are three anchors, and an anchor schema in Sensescript:
- `yee` represents the "first person state", representing the current state of the person communicating the information.
- `yoo` represents the "second person state", representing the current state of the person receiving the information.
- `yoe` represents the "textual state" or "zeroth person state", representing the current state of the current point in the information.
- `yaa` represents the "third person state schema", or "variable state". One can set states in the form of the string `yaa` followed by a string containing exactly one retroflex *n* with which it ends, e.g. yaaban. This way, one can set multiple third persons, as different variable names.

Recall that the states themselves are not words, but attributes ofstates are, and can be accessed through the `$` sign.

> [!info] Comparison to human languages
> - *Pronouns and pro-forms*: E.g. `yeeperson` ("me"), `yeelocation` ("here"), `yeetime` ("now"), `yaabanperson` (gender-neutral pronoun), `yaabanman` ("him"), `yaabanlocation` ("there"), `yaabantime` ("then"), `yaabanthing` ("that"/"it").
> - *Definite article*: "The" is essentially just "that". So one could say e.g. `yaabanfrog`, and it would say "the frog". Those of you who want pronouns based on height (which may be useful in e.g. basketball commentary) or nationality or whatever (analogous to pronouns based on gender), this is just the equivalent of saying "the tall man" (`yaaban(tall man)`) or "the Chinese man" (`yaaban(Chinese man)`).

Note that the `yee` terms do *not* always correspond to the proximate pro-forms, which are defined based on proximity -- e.g. `yeething` does not mean "this", and even `yeelocation` can't be used to e.g. point to a nearby location or a location on a map.

Also note that the word "the" in English has more uses than just as a definite article. The use of yaa is specifically for referring to a defined variable. Contrast with uses such as "The tiger is an annoying animal" (referring to abstractions), "The Earth is round" (as part of what are basically proper nouns), "This is the fastest way home"(specification that this is the *only* fastest way home).

### Variables

The key to using the variable state, of course, is *variable setting* --actually setting the value of the variable at some point in the text. But we need to be careful. Suppose we have the sentence:

*Some dogs that eat rice die.*

And we refer to "these dogs" (i.e. a set variable) in the next sentence:

*Some of these dogs go to heaven.*

Now there is ambiguity: "these dogs" could refer just to dogs, to the dogs that eat rice, or the dogs that eat rice which die. And then if one uses "these dogs" again, it could refer to any of those, or to the dogs that eat rice which die which go to heaven.

One may think of these different definitions as different levels of intersection of the word `dog` with various clauses. Indeed, one can do the "opposite of beta-reduction", to write the first statement as:

```
dog (λun un'doer rice'doee eat.) (λan an'doer die.)
```

One may consider simply requiring that statements be written in thisform to use variable setting. But you may imagine that we may need toassign both `dog` and `rice` as variables.

But wait a minute -- we're supposed to set states, not sets.

### Default Variable Inference

Perfect tense

Simultaneously, same, other, etc.

Universes, mentions, the verb be. Null verb for mentions?

## Sentences and connectors

### Classification of sentences

Classification, their punctuation, distinction from philosophy.

### Questions and answers

Or, generalised or. Leads to wh-, etc. Uses -- wh-

Questions providing partial information (all questions are loaded), e.g. "When *did* he die?" (provides info that he died at all, and that he died in past) or "Which singer killed the bird?"

### Assertions

Restrictive relative clauses, every/some/no/... any?

### Probability

### Emotion

Emphasis -- "I *did* shut the fridge", "Especially", etc. Or to show other emotions. Connotation -- positive, negative, etc. Exclamation. Contradiction. Dismissive (anyway). Confidence. "Of course". Even, opposite of even (Indians and un-even Chinese eat rice) -- kinda like just, sometimes. Literally, Exactly, Especially, Just, Only, Also, But... Already. Quotation marks?

Instead of?

For what I wish to say was the first time?

### Connectors

Kill and eat, kill then eat, etc. Disparate sentences (paragraphing convention also), implication, passage of observation etc.

### Factorization

"You, but not I, kill microbes." "You and I eat bricks and mortar respectively." Involving implicits? Related to slash (and/or)? Also relevant for giving answers. Respective, each other. Factorise to only state inputs to verb e.g. "there and then", "here and now"

### Environments

Math environment. Definition environment. Blog and comments environment(inherit definitions from parent comment or from post?)

### Further punctuation

We've used a lot of standard symbols for other purposes. Parentheses, comma and semicolon, slash, numbering, etc. DO NOT use -- ampersand, slash, percentage, etc.

# Vocabulary

## Special words

### Set partitions

Left side, right side... along, across... fuzzy logic. Nearly, barely. Basically some specific prepositions

CSCs -- extract sets from states (`yeeren`), sets from other sets ("king's location")

... examples of inductive notation: labeling a whole series of `yaa`'s, a series of commas, set intersections, dimensional union and intersection

Objects, properties associated with objects -- location, time, round-off, misc. attributes (weight, height), orientation and directions i.e. CSPs (left, right, above, below, inside, outside, across, along, at the top, at the bottom, after, before...)

Can be rounded off to nearest sentence, paragraph, etc.

We -- two different kinds of we -- can be multiple people talking at once, or can be an approximation.

Set Canonifying Property Assertions? -- Cardinality assertions. Distinguish me from us, him/her from him. Uses -- non-restrictive relative clauses.

Father, grandfather, greatgrandfather,... Yesterday, daybeforeyesterday...

### Attributes, values, units and number

Attribute-value syntax, units and counters, numbers, years, etc. Sann... Cardinals (two bananas, two things), ordinals Units, number counter (ge), percentages replaced by portions in decimal formats (shi). Fuzzy logic for values like "Very" "For the first time". For what I wish to say was the first time

Comparative superlative.

### Proper words

### Classes

## General words

### Basic idea and conventions

Nouns end in -u, etc. Synonyms hyphenated for clarification like Chinese. English Root words, Sanskrit conversions, Chinese for common and common properties/apostrophe terms... Ending in nasal and palatal n's forbidden. As few root words as possible, conversions emphasized. Merging equivalent words -- talk, say, speak, tell, etc. Making murder an adverb for kill

### Essential words

Thing, be, do, make, have, etc.?

### Word transformations

Verb transformations -- causative (-su), conversal (-du), ability (-ku),expectation ("this should work"); Be : become, be at : go, etc.

un-, anti-, -ive, -er... "fire removing person male"

Intertype conversions: Gerunds, "best eats/my run", etc. Creation, consumption, destruction defaults.

### Root word sheet

Basic principle -- English simple words that cannot be reduced as transformations of root words, no idioms like "putting out a fire". manual exceptions. Vocabulary is basically completely extensible if you make definitions on the fly.

th- suffixes, etc. Word suffixes for specific categories (e.g. step-,in-law)

# Pronunciation and script

# Postamble

## Translating tips

Keep meaning in mind -- e.g. "I want two things" (*any* two things or just two things?), all the other examples in grammar - old.docx... "the king", "just fire him"

If it cannot be translated, it's idiomatic -- e.g. "he was born smart", "at once"

Pronouns, Prepositions, every-, some-, any-, wh-, h-/th-,each/every/all/only, adverbs of location/time, restrictive relative clause, non-restrictive relative clause, clause, modals and auxillaries, addressing (Let's eat, Grandma!), z especially admittedly regardless to be honest etc., gerunds, connectors, articles, gender, tense, grammatical number and singular/plural, values and attributes, comparison, prefer to, "one" pronoun

Etc., i.e., e.g., also, even, any. In the order of. As in. in terms of. sic. Vice versa. After all. As usual. "Any most". One must...

And/or, (s), etc. -- not necessary!

For things that don't really make sense in English, suggest alternatives-- e.g. actually. Ideally? Let's hope for you. Stitch them together. Screw you. Allowed less leeway.

## Cheat-sheet

Grammatical terms, symbols (including spacebar.), variable names and lambda variable names, pronunciations thereof

Script

## Examples

### Standalone example sentences and phrases

The quick brown fox...

### Essay 1: short story

### Essay 2: instructional manual

### Essay 3: science fiction piece

Proper time, multiple dimensions

### Essay 4: legal contract

### Essay 5: mathematical text

A set is closed if and only if it contains all it limit points.

one can check that two discrete topological spaces with sets with thesame cardinality are homeomorphic

The union of two disjoint connected sets is connected.

disjoint open partition with connected sets is unique up to

it suffices to show that

"Nothing(ness) suffices." "A and B suffice." Necessify?

Variable setting -- for inverted commas, e.g. a "Euclidean" action [...: Euclidean] or something like that

which create an open disjoint cover of each connected component -- this can only be true of an open set if the sets in the cover are precisely the connected components

number of sample sets to plot distribution of sample stats with