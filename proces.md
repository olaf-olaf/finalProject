proces.md
### Proces

## 9-01-2017
Today i’ve been working on a read me file and basic sketches for the app design.

## 10-01-2017
Today i’ve been working on the technical design of the app. 

## 11-01-2017
First day of coding. I’m trying to figure out whether to use the audio player of Apple or the Audiokit library. Audiokit has some latency problems and can’t play two audio files simultaneously. The latency is caused because I initialise every time the user presses a drum pad. Initialising Audiokit in a singleton might fix this problem. The audio player of Apple works with zero latency but has very little features.

##12-01-2017

Initialising Audiokit in a singleton works. I can now play audio simultaneously with an acceptable amount of latency. Since the basic functionality is working it is relatively easy to add new features to the audioprocessing. Because of this i’ve decided to add a mixer, metronome and a effects mixer to the app. I’ve implemented a basic effects mixer (only three effects and the sounds are just presets) to the app. 

##13-01-2017
Today the app has been extended with a audiomixer. It only controls level so far. To add panning functionality i probably need to import a library that allows me to implement knobs from cocoapods. 

##16-01-2017
Switching between different kits has been added to the app. At first some bugs arose due to using different file formats (mono to stereo) when replacing files. 

##17-01-2017

Today i’ve added a metronome to the app. The metronome’s speed can adjusted with a slider. Right now i’m thinking of whether i Should display the BPM of the metronome or not. 

##18-01-2017
Today i’ve been  working on adding a rotary knob to my project so i can let the user pan their samples. I accomplished this by completing a ray wenderlich tutorial written in swift 1.2. I’ve got the functionality working completely but still have to figure out improve the visual aspect of the knob.  

##19-01-2017
I've been trying to implement callback functions in order to be able to repeatadly trigger a sample without the sample needing to finish first.I  have spoken to some potential users of the app and they would like to see the bpm of the metronome. I've implemented that as well. In case I don't succeed in properly fixing the playback problem with callback functions i will try to 'mask' the problem by. 
- making samples shorter so the user doesn't notice this problem
- creating several instances of audioplayers so if one is already playing, i can just play another one. This however, is quite ugly.

##20-01-2017
Today's presentation made clear that visual aspects of my app should be improved. It was still very basic. So today i've added some colors to the app that should give the user some feedback whether a button is pushed or something is playing. Right now i'm still trying to get everything as pretty as possible without using images. If i feel liek i've got the maximum visuals out of the app by coding I might improve the visuals by adding some custom images. 

