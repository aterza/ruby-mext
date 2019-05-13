class Numeric

  #
  # a set of constants needed for pitch classes and MIDI
  #

  #
  # +MIDI_MIDDLE_C+: the central C (Do) in MIDI jargon
  #
  MIDI_MIDDLE_C = 60

  #
  # +PITCH_MIDDLE_C+: the central C (Do) in pitch-class jargon 
  #
  PITCH_MIDDLE_C = 8.0

  #
  # +CHROMATIC_NOTES_PER_OCTAVE+ (short: +CNPO+): the number of notes per octave  
  #
  CHROMATIC_NOTES_PER_OCTAVE = CNPO = 12.0

  #
  # +ZERO_PITCH+ (short: +ZP+): where does the +0.00+ pitch-class reside
  # in terms of semitones (+96)
  #
  ZERO_PITCH = ZP = PITCH_MIDDLE_C * CNPO

  #
  # +ZERO_MIDI_PITCH+ (short: +ZMP+): where does the +0.00+ pitch-class reside
  # in terms of midi notes (-36)
  #
  ZERO_MIDI_PITCH = ZMP = MIDI_MIDDLE_C - ZERO_PITCH

  #
  # +PITCH_CLASS_CENTS+ (short: +PCC+): the number of parts in every semitone
  #
  PITCH_CLASS_CENTS = PCC = 100.0


end
