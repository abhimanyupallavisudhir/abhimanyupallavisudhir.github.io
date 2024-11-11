
| P   | Q   | Q\| P | P → Q |
| --- | --- | ----- | ----- |
| T   | T   | T     | T     |
| T   | F   | F     | F     |
| F   | T   | N/A   | T     |
| F   | F   | N/A   | T     |
Resolution logic for conditionalization:

```
if P:
	return Q
else:
	return None
```

Resolution logic for implies:

```
if P:
	return Q
else:
	return True

(equivalently) return not P or Q
```
