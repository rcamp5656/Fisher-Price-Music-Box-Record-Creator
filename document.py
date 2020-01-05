import mido
import const

class Document:
    # what the .fpr format uses
    __NOTE_FPR = '+'
    __EMPTY_FPR = '-'

    filename = None
    title = 'Default'
    comment = ''
    _partition = None
    length_x = 0    #length of beats
    length_y = 0    #length of tracks
    program = 8
    NOTES = [67, 72, 74, 76, 79, 81, 83, 84, 86, 88, 89, 91, 93, 95, 96, 98]

    def __init__(self, length_x, length_y):
        self._partition = [[False for x in range(length_x)]
                          for y in range(length_y)]
        self.length_x = length_x
        self.length_y = length_y

    def has_note(self, x, y):
        return self._partition[y][x]

    def set_note(self, x, y, value):
        self._partition[y][x] = value

    def get_beats(self, track_index):
        return self._partition[track_index]

    def reverse_note(self, x, y):
        self._partition[y][x] = not self._partition[y][x]

    def left_shift(self, x):
        for partition_y in range(self.length_y):
            self._partition[partition_y].pop(x)
            self._partition[partition_y].append(False)

    def right_shift(self, x):
        for partition_y in range(self.length_y):
            self._partition[partition_y].insert(x, False)
            self._partition[partition_y].pop

    def load(self):
        try:
            input = ''
            with open(self.filename) as fp:
                lineno = 0
                while lineno < self.length_y:
                    line = fp.readline().rstrip()
                    line = line.ljust(self.length_x, self.__EMPTY_FPR)[:self.length_x]
                    for i in range(len(line)):
                        self._partition[lineno][i] = line[i] == self.__NOTE_FPR
                    lineno += 1
                self.title=fp.readline().rstrip()
                while line:
                    line=fp.readline()
                    self.comment+=line
            fp.close()
        except FileNotFoundError as e:
            pass

    def save(self):
        output = ''
        for partition_y in range(0, self.length_y):
            for partition_x in range(0, self.length_x):
                has_note = self.has_note(partition_x, partition_y)
                output += self.__NOTE_FPR if has_note else self.__EMPTY_FPR
            output += '\n'
        output += self.title
        output += self.comment

        file = open(self.filename, 'w')
        file.write(output)
        file.close()

    def export_to_mid(self):
        mid = mido.MidiFile(type=0, ticks_per_beat=480)
        track = mido.MidiTrack()
        mid.tracks.append(track)

        ticks = 480

        track.append(mido.Message('program_change', program=self.program, time=0))

        for partition_x in range(self.length_x):
            for partition_y in range(self.length_y):
                if self.has_note(partition_x, partition_y):
                    track.append(mido.Message('note_on', note=self.NOTES[partition_y], time=0))
            track.append(mido.Message('note_off', time=ticks))

        mid.save(self.title + '.mid')
