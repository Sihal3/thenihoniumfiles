---
layout: post
title: "Trying out deepfakes with artificial intelligence on my PC"
date: 2021-03-21 19:44:59 -0700
image: /assets/images/trying-out-deepfakes-with-artificial-intelligence-on-my-pc-1.jpg
excerpt: "Turns out I'm an easily distractible person. I though I was finished messing around with coding once I had set up GPT-2, a neural text..."
minutes_to_read: 3
---

Turns out I'm an easily distractible person. I though I was finished messing around with coding once I had set up GPT-2, a neural text engine, and a cryptocurrency mining software on my PC. (I'll talk about GPT-2 in a later post)

Nope. I apparently really want to squeeze every last bit of performance out of my PC, so I turned to deepfakes. My foray into deepfakes began just like my cryptocurrency mining. I was curious in class one day, and I started searching up what was required for deepfaking video and whether it was possible on consumer hardware. Short answer, you can, assuming you have a decent GPU. (It is possible on CPUs, but be prepared for weeks of waiting. Yes, weeks.)

Should probably explain what deepfakes are to begin with. Deepfakes are videos or photos where you use a neural network or autoencoder (deep learning) to realistically

facial features or entire heads with other people. There have been a couple popular deepfakes that served to draw attention to the practice; you might have seen that one where Obama is faked by comedian Jordan Peele and made to say some sketchy statements. Here's the link if you haven't seen it: [https://www.youtube.com/watch?v=cQ54GDm1eL0](https://www.youtube.com/watch?v=cQ54GDm1eL0)

That video also addresses the big problem with deepfakes: they're too real. People can use them to make anyone say anything, generate hard-to-dispell fake news or political scandals. Nothing large in scale has happened on that front, but deepfakes have been used to generate celebrity and revenge porn.

Generally, though, people just use them to swap out actors, like putting Nicholas Cage in Superman vs. Batman. But not as Superman or Batman. As Lois Lane.

![]({{ "/assets/images/trying-out-deepfakes-with-artificial-intelligence-on-my-pc-1.jpg" | relative_url }})

Yep.

Anyway, I found two main programs on the web, Deep Face Lab and Faceswap. Both use similar trainers and algorithms, but Faceswap runs like an actual GUI application, making it so much easier to use.

Unfortunately, getting Faceswap running on my PC wasn't just plug and play. Some machine learning tools aren't available yet for the new NVIDIA 3000 series graphics cards, one of which I have, seeing as I built my PC recently. Essentially, I have to go through some environment management with TensorFlow, Google's artificial intelligence Python library.

Past that, though, and everything was perfectly fine.

...

(Silently continued debugging the application before realized it had just been installed in the wrong directory)

...

It works now, it works, we're all good.

At first, the software looked incredibly complicated. But there were really only three main steps.

Step 1: Extraction. You get videos of the two people you want to swap, hopefully with good quality footage of their faces, then you load them into the software, which pulls out the face in the video and generates a large folder with photos of all the frames. Seriously, I was shocked by the amount of photos. I had 30000 photos of Obama's face just from one 15-minute speech on YouTube.

Step 2: Training. Once you have a large folder of images of each of your people-to-be-swapped, you train your neural network model with the images. It tries to replicate the faces you put in, slowly getting better and better as time goes on. Very slowly, in fact, a couple days of hard training if you want to be thorough and get the best swap possible. I usually cut mine off at a day or two, for time's sake.

Step 3: Conversion. The training of the model was the hard part. Now, you just put in the video or images you want to swap, and the model swaps them. Bam, deepfake.

My results, I discovered, were very dependent on the data I put in. No one-minute-blurry videos for your inputs, you need clear, 5-10 minute videos of each of your people. Otherwise, it's always blurry or just looks inhuman. You also preferably want video with a wide range of facial expressions, angles, and lighting. Then you have to train for a good 5 days or so, and then even after that you'll probably need some touching up in After Effects to look perfect. Here's one of my better swaps:

![]({{ "/assets/images/trying-out-deepfakes-with-artificial-intelligence-on-my-pc-2.jpg" | relative_url }})

I swapped one of my friends onto Lieutenant Uhura from Star Trek. The facial features look good, and there's not a lot of blurriness, but you can see that it's not quite right. The color of the face didn't transfer properly, and there's some fuzziness in movement when you watch the video.

However, I was surprised by just how well the face moved, as in changed expressions. It did so completely naturally, as if it was a real video that just had some glitchy artifacts. The facial features of the swap look so natural that you almost forget, that's not her real face.

But, the process definitely isn't foolproof yet, nor easy to pull off well. It is doable, though, and if you have a GPU, I encourage you to try it out yourself.

Maybe next I should try to put another one of my friends in Star Wars...
