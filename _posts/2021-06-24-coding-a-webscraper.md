---
layout: post
title: "Coding A Webscraper!"
date: 2021-06-24 00:08:35 -0700
excerpt: "Hey there readers! (Yes, all of my many, many, many readers, most of which are probably my two parents) Yeah, yeah, I know. Two weeks..."
minutes_to_read: 3
---

Hey there readers! (Yes, all of my many, many, many readers, most of which are probably my two parents)

Yeah, yeah, I know. Two weeks have elapsed again since I last posted. So much for my schedule.

To be fair, I'm pretty busy. I have an internship!

So, I've been working with this Ph.D. student called Trevor at UC Davis. He's studying to be a control engineer (sounds boring, I know, but he deals with a lot of cool AI stuff). He's been assigned by his professor to write a chapter for a book by some Michigan professor on advanced safety features in today's vehicles. (His lab focuses a lot on cars in particular). Essentially, our chapter's gonna analyze what features are already in cars and how to use AI to improve the technology.

My job is essentially just to help him out in writing the chapter. It's pretty fun so far. He's had me gathering data from car manufacturer websites (specifically, which cars had which standard safety features) to include as a source in the chapter.

He at first was going to to it by hand (boy would that have been abject misery), but he had asked me if I could program something to take in those marketing manufacturer terms (Ex. Ford CoPilot360) and give out the NHTSA definitions (Ex. Adaptive Cruise Control (ACC) and Lane Keep Assist (LKA)), to speed up our entry.

Well, I did that. And then as I was trying the program out, I thought to myself, wouldn't it be easier if I could just input the website and have it just do a simple text search from the terms? So I tried that.

One long night of coding later, and a lot of web searching, I had built me a web scraper. I didn't even know what a web scaper was before this.  Google and Stack Overflow are a gift to humankind and should forever be revered. And Python deserves a callout as well, for making it so easy to just import a library and get a website's text with a couple of lines of code.

And, so, I've just been applying the code to different websites to fill out our data. I just give it the URL of the website and a table of what features are what, and it spits out our spreadsheet.

It's still a butt-ton of work, simply because of the amount of cars I'm dealing with, I think I've passed 600. But oh my god would this have been torture without my program. It has its uses in being able to alter my data easily as well. I can easily change a definition and rerun all the code to get my new data once it's been set up for a manufacturer.

Lots of work, though, lot of work. It's like a full-time job in terms of hours I put in, and practically worse since it's self-paced and I'm prone to distraction and procrastination.

I'm definitely proud of my achievement. This is no simple piece of code, and it gets more complicated every day as I have to deal with non-standardized websites and different manufacturers doing different stuff.

Wait, I might as well just include it. Sorry, it's really messy and barely commented. Not exactly fit for public viewing. But here:

It's a Jupyter Notebook Python file, which you can either open if you have Anaconda installed or with Google Collaboratory (like Google Docs for Python notebooks)

<p class="file-download"><a href="{{ "/assets/files/rowgenerator.ipynb" | relative_url }}" download>&#128196; rowgenerator.ipynb</a> <span>(346 KB)</span></p>

Or, you can check out my GitHub repo at https://github.com/Sihal3/ADASVehicleScraper3000.

Trevor, that PhD student, was really happy with it as well. He said that he had been thinking about collecting the data autonomously in some way as well but had sought to give my high-school self less of an impossible task. Boy, was he pleasantly surprised.

As for me, well, I just finished off Jeep and Nissan today. Gotta get started on Ram.

See ya!
