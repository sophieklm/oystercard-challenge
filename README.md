# Oystercard

Modelling an oystercard system using Ruby, TDD, OOD using a set of classes to allow customers to top up, touch in/out, and be charged the correct fare for journeys.


How to use
---------

Clone the repository and cd into it.

Use IRB:

```shell
> require './lib/oystercard.rb'
```

Create a new oystercard:

```shell
> card = Oystercard.new
```

The following commands allow you to top up, touch in or touch out:

```shell
> card.top_up(10)
> card.touch_in(:oxford_circus)
> card.touch_out(:picadilly)
```
