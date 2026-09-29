---
layout: post
title: "Doing Reinforcement Learning for my Internship!"
date: 2021-08-13 04:10:26 -0700
image: /assets/images/doing-reinforcement-learning-for-my-internship-1.png
excerpt: "So, I've been working on my internship, actually, the last couple of weeks. It's really engaging stuff. The last time I updated you guys..."
minutes_to_read: 6
---

![]({{ "/assets/images/doing-reinforcement-learning-for-my-internship-1.png" | relative_url }})

So, I've been working on my internship, actually, the last couple of weeks.

It's really engaging stuff. The last time I updated you guys on the internship, I was still collecting data every day on manufacturers. It was grueling stuff, but the coding kept me well in.

Then, after I finished the collection, (and had a week of no assignments), Trevor (the PhD student I'm working with at UC Davis, along with Professor Assadian) and I started the next amazing phase, the reinforcement learning.

So, as part of the chapter, the professor thought we ought to have an example of how AI can be used in safety features (since that's what the chapter we're writing is focusing on), so Trevor came up with the 'using reinforcement learning to create automatic collision avoidance systems'.

In NHTSA terminology, those would be the AEB (Automatic Emergency Braking) and the AES (Automatic Evasive Steering) features in cars.

Anyway, that week while I was chilling, Trevor was adapting a set of OpenAI Gym environments to fit our needs. OpenAI, if you didn't know, is a big company owned by Microsoft, they do a lot of work on researching cutting-edge AI.

Their 'Gym' project is an open-source set of code for training reinforcement algorithms.

And... I realized I should probably explain what reinforcement learning is.

So, reinforcement learning, at its base, is the idea of using neural networks to control the actions of an 'agent' in an environment.

This could anything from controlling an Atari Breakout paddle and trying to win the game to learning to walk to driving a car.

And that last case is exactly what we were working on.

But anyway, Gym is there to standardize the interface for how an agent communicates and sees in an environment. It almost makes it plug-and-play. You can pick any model that has been built to interface with Gym (there's a lot of them) or code your own. You can pick any environment as well, or code your own.

So, Trevor started with a GitHub repository that already had a ton of driving environments. He forked it, and created our own collision environment within.

GitHub link: [https://github.com/tvidano/highway-env](https://github.com/tvidano/highway-env)

It's a simple straight highway, with a number of basic cars around and one controlled car. When the car is close to a collision, the AI model takes control and has to learn how to stay alive and not crash. You can see a pic up above.

Trevor spent the better part of that week making the collision env. He had to rewrite a good chunk of the original repository as well, to add tire locking and skidding and other simulation-like-things.

When I got sent the repository, it took me pretty much two days to figure out what the heck was going on. I don't actually have a great bank of coding knowledge, my strength in coding comes mostly from my ability to learn and work with new code quickly.

Once I properly understood it, I wrote a batch script that trained a model and collected statistics on how well it had done, like survived 173 times and crashed 394 times, and also gave a percent of runs it dodged correctly.

![]({{ "/assets/images/doing-reinforcement-learning-for-my-internship-2.png" | relative_url }})

And then, we had to train a model that was better at avoiding collisions than just hard braking was. Should take maybe a week, no?

Nope. Couldn't do it. No matter what I or Trevor trained, it just was never good enough compared to braking was. Turns out self-driving is hard!

Anyway, we basically went on a spree of interactions. We would try everything, training models over and over again with different variables.

I was able to run multiple models at once, you know, self-built PC with pretty good specs.

Totally overloaded my computer occasionally, running 10-12 models at once. (Neural nets are pretty heavy computationally, so it was a lot.) Love you, computer, you're a beast.

But we tried EVERYTHING. We tried changing the rewards function, so many times.

(A rewards function is how the AI learns what behavior to do. You give a higher number for the behavior you want, and the AI adjusts itself to better optimize and maximize the reward.)

So as a result, the reward function basically controls the entire learning behavior. A clear possible culprit.

We tried sparse rewards, giving a reward if and only if it survived the whole time. We tried dense rewards, rewarding things from how shallow the collisions to its orientations. Penalty rewards, for going offroad, so on. My own variant function, which rewarded and penalized specific other behaviors like time alive and lateral velocity. It's a complicated business.

![]({{ "/assets/images/doing-reinforcement-learning-for-my-internship-3.png" | relative_url }})

A piece of the reward function. You can see, under the 'if variant:' my special sauce reward function. It worked just as well as penalty\_dense, though, to be honest.

We tried changing the observations of the AI model, what it can see. We went from giving it the xy positions of cars around it to a LIDAR-like observation, to appending the vehicle's position and velocity to that LIDAR scheme.

We tried changing the environment itself, altering the time\_to\_collision function, changing it so that the AI only received observations and steps when it was supposed to be active and not otherwise.

We even set up the RL-baselines-zoo library (meant to simplify the training of models) to help us train models and hyperparameter-optimize (hyperparameters are the parameters of the neural model you start with, like how big it is, how many batches it gets, etc.). There was a registry error in the environment that took me HOURS to find before I could set it all up.

Yep. Still nothing. At this point, Trevor and I were basically at a loss. We sort of backtracked, focusing on training an agent that could at least just brake. We accomplished that, at least, if barely. Wow, an AI can copy hard braking.

We didn't really have a choice though, since none of our other iterations could even match it. And we were pretty darn close to the deadline, maybe a week or two and there was still the writing of the chapter to be done. Trevor had been working on that alongside, luckily.

Fast-forward to the literal last day to submit the chapter to that UMich professor. I had been away for the last week, in New York (for reasons I may explain later). I had still been running iterations of the model, but there were a couple of last-ditch changes that had occurred to me that would have been hard to code there. Mainly, I increased the number of lanes to five and made them wider.

My reasoning was this: we'd altered so much of the program. The rewards, observations, environment functionality, training. There wasn't much left that could be causing this failure. Maybe something about the situation was fundamentally giving the AI unreasonable difficulty. Essentially, the task wasn't reasonable to do effectively, at least the way we'd phrased it.

It wasn't a new thought, but I'd never been able to figure out what to do about it. Cutting the number of cars in the simulation hadn't worked before, since the hard braking only got correspondingly better.

But, I figured increasing the number of lanes and width of lanes would maybe do it. Give the AI more room to work with, let it dodge amongst the cars. Good enough last-ditch effort yeah?

The way I've been leading up to it you probably already know what the outcome of those iterations were.

Successful indeed. An actual AI better at dodging and avoiding collisions than a simple emergency braker. Granted, some realism had been sacrificed by widening the lane, but it wasn't excessive and it didn't really matter since it still had worked when nothing else had.

Not all happy endings, though. Too late to put in the chapter. No time to draft a new section on this when we hadn't done any further checking or analysis on the results, or when we had already written a section on a 1D hard-braker agent.

But, Trevor says he wants to do a whole new paper on the results of this. An AI that can both dodge and brake is an accomplishment. Ahhhh, it's just so cool.

I get to work on the most complicated code I've ever seen, work on ACTUAL AI RESEARCH, actually eventually understand the code, SOLVE THE AI TASK that has literally taken a month, get MY NAME, NIHAL GULATI, as the third AUTHOR in this chapter for a peer-reviewed book, then maybe also CO-AUTHOR another research paper with Trevor?

Too cool. But how in the world can I manage all this work on top of my college application work on top of all my other work? It's a good question. One I haven't quite answered myself yet. Check back by November to see if I've overloaded and fried my circuitry yet.
