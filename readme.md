This sofwtare is a music box tune tracker.

It can export .scad file to create custom disc for the Fisher Price Record Player toy.

music box tune tracker use the same file format (.fpr) from "Fred Record Player" available at https://www.instructables.com/id/3D-printing-records-for-a-Fisher-Price-toy-record-/

# Prerequisites

This software uses Python with the Curses library for the interface and the Mido library for sound.
You will also need a Midi backend, I use timidity, which can be installed under Linux Ubuntu with :

```
 sudo apt install libasound2-dev libjack-dev timidity
```

The python dependencies can be installed with pip:

```
pip install mido python-rtmidi
```

Then run timidity with:

```
timidity -iA -B2,8 -Os1l -s 44100
```

# Run

## List Midi ports

Under Linux, midi 'Port name' can be listed with

```
aplaymidi -l

 Port    Client name                      Port name
 14:0    Midi Through                     Midi Through Port-0
128:0    TiMidity                         TiMidity port 0
128:1    TiMidity                         TiMidity port 1
128:2    TiMidity                         TiMidity port 2
128:3    TiMidity                         TiMidity port 3
```

## Command line usage

```
optional arguments:
  -h, --help         show this help message and exit
  --port PORT        name of the midi port to use
  --file FILE        fpr file to open
  --mid MID          import from .mid file created with music box tune tracker
  --program PROGRAM  midi instrument code
  --title TITLE      set the title of a new tune
  --low              display low pitch notes first

```

### Example

```
python music-box-tracker.py --port 'TiMidity port 0'
```

## Using music box tune tracker

* Arrow key: Move the cursor
* Space: add/remove a note at cursor
* p: play/stop
* t: play the tone at cursor
* r: play the column of tones at cursor
* s: save
* l: load
* x: export to .mid
* e: edit title
* q: quit
* o: move the playing start location to cursor
* i: move the playing start location to the right
* u: move the playing start location to the left
* +: right shift the partition
* -: left shift the partition

# Convert .fpr to .scad

.fpr file can be converted to .scad file by using the fpr_to_scad.py file


```
usage: fpr_to_scad.py [-h] [--fpr FPR] [--fprbis FPRBIS] [--scad SCAD]
                      [--thickness THICKNESS]

optional arguments:
  -h, --help            show this help message and exit
  --fpr FPR             name of fpr file
  --fprbis FPRBIS       name of fpr file for second track
  --scad SCAD           name of scad file to output
  --thickness THICKNESS
                        thickness in mm, must be 3 or 5. Default to 3 if one
                        side or 5 if two side
```

# Screenshot

<img src="https://github.com/odrevet/music-box-tune-tracker/blob/master/screenshot/screenshot.png" width="6400" height="480" />

# Thanks

Thanks to [FredMurphy](https://github.com/FredMurphy) to have created and shared "Fred Record Player" source code, it was of a great help, notably to implement the export to scad feature.

More informations on running Fred Record Player under linux is available in the [fred_record_player](fred_record_player.md) file
