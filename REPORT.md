# Report

- Olaf Kroon
- 10787321
- Programmeerproject

## DrumPad

Drumpad is a samplepad for your iphone. This application allows people to jam with classic drum sounds without hauling around heavy gear. Drumpad consists of four drumpads that can be used to play 6 different drumkits. The way every kit sounds can be manipulated to your own liking by mixing every sound and adding effects. 

<img src="https://github.com/olaf-olaf/finalProject/blob/master/doc/DrumPad.png" width="200px"></br>

## Technical Design

### overview
The entire application revolves around a singleton of the AudioController class. In this class every aspect of audioprocessing is taken care of. The audioproccesing proces of this application can be seperated into 4 parts. The first part of the audioprocessing is to load the samples that belong to a corresponding drumkit into audioplayers. The second part is mixing all the audioplayers together. In this part of the proces the levels of the audioplayers and the stereo imiging (panning) is determined. The third part of the proces is adding effects. The last step is to actually create sound by connecting everything to an output and allowing the user to trigger sound. The entire AudioController class is made using audiokit. This is a library for building instruments on IOS. 

Every view in the application is a visual representation of certain variables within the audio proces. Each representation is interactive. Users can alter the visual representations of variables to change these variables to their liking. For example, 'Viewcontroller.swift' allows the user to play audio by tapping drumpads, to change drumkits by pressing buttons adjacent to to text that informs the user of which drumkit is currently being used, and to set the beats per minute of a metronome with a slider.  

### MVC

#### Model

##### AudioController.swift

This file contains the AudioController class. When initialized, an instance of this class contains a sample based synthesizer. The class contains methods regarding replacing samples, playing samples and the metronome, and setting parameters for mixing and effects. AudioController can only be initialized as a singleton.

##### Knob.swift

This file contains three classes related to a custom reusable knob that can be used to determine values for variables in a way that is similar to a slider. The first class is a subclass from UIControl called Knob. This class handles the values a knob can represent and updates them according to data from a gesture recognizer. To do this the knob needs a visual appearence, and a gesture recognizer that can detect and handle a rotating movement from the user. Knob uses instances of the other two classes to achieve this. The second class, KnobRenderer, takes care of the visual appereance of the knob. The third class, RotationGestureRecognizer, is a subclass of UIPanRecognizer that can detect rotating movements of the users finger on a knob. 

##### MixerParameters.Swift

This file contains two classes that are used to bundle related values. By bundling different values together one can keep unit interfaces small.It also prevents methods from just taking any value as long as it is of the same type. The first class is MixerLevels. MixerLevels contains 4 floats representing the levels of different audioplayers. The second class is MixerPanning. Mixerpanning contains 4 floats representing the stereo imaging of different audioplayers. Both classes are used as a paremeter for the AudioController method 'mixAudio'.

##### ShowMixerLed.swift

This file contains a class called ShowMixerLed. This class contains functions that return strings that can be displayed on labels in the AudioMixerViewController.

##### ShowKitLed

This file contains the ShowKitLed class. This contains an array is strings with the names of all drumkits. It also contains 2 methods that allow users to scroll back and forth through each element of an array containing all the drumkits. AudioController uses an instance of ShowKitLed to keep track of which kit is being used. Viewcontroller uses the instance of ShowKitLed in AudioController to the display the kit that is being used. 

#### View
##### ViewController.swift

This file contains 'ViewController', the main view controller of this application. It consists of a slider, 4 buttons representing a drumpads, a metronome button, an FX button, a mixer buttons, ands two buttons that can be used to scroll through different kits. Every element of this view except for the FX button and the mixer button calls a method of AudioController when touched. The drumpads call the 'playsample' method to generate sound, the slider and the metronome button can be used to trigger the Metronome of AudioController and the two most upper buttons call the 'replaceKit' method to load a new set of samples. 

<img src="https://github.com/olaf-olaf/finalProject/blob/master/doc/DrumPad.png" width="200px"></br>

##### AudioMixerViewController.swift

This file contains a viewcontroller called AudioMixerViewController. This viewcontroller consists of 4 sliders and 4 knobs. When 'back' is pressed the values of the sliders and the knob will be bundled in an object and then will be passed on to the AudioController method 'mixAudio' is called. 

<img src="https://github.com/olaf-olaf/finalProject/blob/master/doc/AudioMixer.png" width="200px"></br>

##### FxController.swift

FxController.swift contains a viewController called FxController. FxController consists of 4 sliders and 4 buttons. When 'back' is pressed a Audiocontroller method 'mixFx' will be called. All buttons in this view will show another view when pressed.

<img src="https://github.com/olaf-olaf/finalProject/blob/master/doc/FXMixer.png" width="200px"></br>
 
##### Reverb / Delay / Distortion / Ring ParameterViewController.Swift

Each of these viewcontrollers contains a set of knobs that represent values of the effect objects in AudioController. Whenever 'back' is pressed by the user an AudioController method that updates the effects object values to the values of the knobs will be called. 

<img src="https://github.com/olaf-olaf/finalProject/blob/master/doc/FXParameters.png" width="200px"></br>

#### Controller

##### Main.storyboard

This file consists of some segues that are triggered by buttons. 

## Challenges in process

In the proces of making this app i've come across a few moments where I had to change my initial design. These moments will be discussed in chronological order. 

### Getting rid of latency due to initialisation 12-01-2017

In my initial design I tried to create 4 classes with each one audio player and output. All the effects / mixing related programming would go in between the players and the outputs. This was possible with the apple library since it initalizes extremely fast and allows you to have multiple outputs. When using this library my initial design would work without any latency. Audiokit however, has quite a slow initialization. This caused immense latency which basically made the samplepad unplayable. Another problem that occured when using audiokit in my initial design is that audiokit only allows one output. Because of this no samples could be played simultaneously. 

I decided to stick with audiokit because it has so many possibilities and change my design. Instead of giving each samplepad a class, I built the entire audio processer in a singleton. I was able to mix different sounds into one output by using a mixer object. 

### Problems with file formats 16-01-2017

When I implemented switching between kits the app occasionally mysteriously crashed when playing with a new kit. After some research it turned out the audioplayer couldn't handle initially loading a mono file and then switching to a stereo file. I fixed this by converting all the samples to mono using Wave Agent. 

### Implementing custom gestures / controllers 18-01-2017

One of my goals in creating this app was to make the app feel like a real samplepad as much as possible. Essential to this feeling is having similar controls. Because of this I decided to implement a knob into my project. Since Xcode has no ready made knob available I tried getting one by installing a pod. After trying a few pods they all turned out to be worthless. I ended up following a Ray Wenderlich tutorial written in swift 1.2. This turned out to be quite a challenge since syntax has drasticaly changed since then. I have rewritten a lot of the code by browsing through the apple developer documentation. Eventually I got the knob working. It is still pretty basic in it's design, but it does the job.  

### Getting rid of clicks 19-01-2017

A problem occured when I tried to repeatedly play long samples. It turned out the audiokit audioplayer wouldn't replay a sample while it is already playing. My initial fix of this problem was to simply stop the sample and then replay it. This caused excessive clicking and popping. This noise was caused because an audio wave was abruptly ended at a high amplitude. After several other failing attempts I masked to problem by giving creating a backup audio player for every existing audioplayer. Whenever the main audioplayer is already playing the backup player is used to play audio. Backup players in combination with shorter samples almosts completely masks this problem. 

## Defending these decisions

Taking care of audio Processing in a singleton has several benefits. Firstly, it ensures that no latency occurs when playing the samplepads after segueing between views because the synthesizer is initialized only once and then stays active as long as the app is running. Secondly, since everything in this app refers to some part of the synthesizer it makes sense to have the data regarding this synthesizer in global scope. The alternative would be segueing loads of data between views, which would be incredebly inconvenient. Taking care of audio files outside of Xcode has both pro's and cons. The biggest pro is that the best code is no code. Keeping up a consistent sample database saves a lot of code. The con is that the application is less adaptable since samples in stereo have to be converted first. Getting rid of clicks by creating a backup player is an easy fix for a major problem. It unfortunately only masks the problem. If the user repeatedly triggers a kick drum really fast the app won't respond to every other tap. 

If I would have more time to work on this application I wouldn't make any major changes to the functionality. My final product is a playable instrument, but looks really basic. Since looks are incredibly important in the musical instruments industry I would spend time creating custom images and controllers to make the application that is not only sonically appealing, but vissually appealing as well. 













