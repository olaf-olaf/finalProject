# Report

- Olaf Kroon
- 10787321
- Programmeerproject

## DrumPad

Drumpad is a samplepad for your iphone. This application allows people to jam with classic drum sounds without hauling around heavy gear. Drumpad consists of four drumpads that can be used to play 6 different drumkits. The way every kit sounds can be manipulated to your own liking by mixing every sound and adding effects. 

<img src="https://github.com/olaf-olaf/finalProject/blob/master/doc/DrumPad.png" width="200px"></br>

## Technical Design

### overview
The entire application revolves around a singleton of the AudioController class. In this class every aspect of audioprocessing is taken care of. The audioproccesing proces of this application can be seperated into XX parts. The first part of the audioprocessing is to load the samples that belong to a corresponding drumkit into audioplayers. The second part is mixing all the audioplayers together. In this part of the proces the levels of the audioplayers and the stereo imiging (panning) is determined. The third part of the proces is adding effects. The last step is to actually create sound by connecting everything to an output and allowing the user to trigger sound. The entire AudioController class is made using audiokit. This is a library for building instruments on IOS. 

Every view in the application is a visual representation of certain variables within the audio proces. Every visual representation is interactive. Users can alter the visual representation representations of variables to change these variables to their liking. For example, 'Viewcontroller.swift' allows the user to play audio by tapping drumpads, to change drumkits by pressing buttons adjacent to to text informing that informers the user of which drumkit is currently being used, and to set the beats per minute of a metronome with a slider.  

### MVC

#### Model

##### AudioController.swift

This file contains the AudioController class. When initialized an object containt a sample based synthesizer is created. The class contains methods regarding replacing samples, playing samples and the metronome, and setting parameters for mixing and effects. AudioController can only be initialised as a singleton.

##### Knob.swift

This file contains three classes related to a custom reusable knob that can be used to determine values for variables in a way that is similar to a slider. The first class is a subclass from UIControl called Knob. This class handles the values a knob can represent and updates them according to data from a gesture recognizer. To do this the knob needs a visual appearence and a gesture recognizer that can detect and handle a rotating movement from the user. Knob uses instances of the other two classes to achieve this. The second class, KnobRenderer, takes care of the visual appereance of the knob. The third class, RotationGestureRecognizer, is a subclass of UIPanRecognizer that can detect rotating movements of the users finger on a knob. 

##### MixerParameters.Swift

This file contains two classes that are used to bundle related values. By bundling different values together one can keep unit interfaces small.It also prevents methods from just taking any value as long as it is of the same type. The first class is MixerLevels. MixerLevels contains 4 floats representing the levels of different audioplayers. The second class is MixerPanning. Mixerpanning contains 4 floats representing the stereo imaging of different audioplayers. Both classes are used as a paremeter for the AudioController method 'mixAudio'.

##### ShowMixerLed.swift

This file contains a class called ShowMixerLed. This class contains functions that return strings that can be displayed on labels in the AudioMixerViewController.

##### ShowKitLed

This file contains the ShowKitLed class. This contains an array is strings with the names of all drumkits. It also contains 2 methods that allow users to scroll back and forth through each element of the array. AudioController uses an instance of ShowKitLed to keep track of which kit is being used. Viewcontroller uses the instance of ShowKitLed in AudioController to the display the kit that is being used to the user. 

#### View

##### ViewController.swift
This file contains 'ViewController', the main view controller of this application. It consists of a slider, 4 buttons representing a drumpads, a metronome button, an FX button, a mixer buttons, ands two buttons that can be used to scroll through different kits. Every element of this view except for the FX button and the mixer button calls a method of AudioController when touched. The drumpads trigger the 'playsample' method to generate sound, the slider and the metronome button can be used to trigger the Metronome of AudioController and the two most upper buttons call the 'replaceKit' method to load a new set of samples. 

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

In the proces of making this app i've come across a few moments where I had to change my initial design. These moments will be discussed inchronological order. 

### Figuring out which library to use 11-01-2017

### Getting rid of latency due to initialisation 12-01-2017

### Problems with file formats 16-01-2017

### Implementing custom gestures / controllers 18-01-2017

### Getting rid of clicks 19-01-2017

## Differences in design, then and now. 










