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

