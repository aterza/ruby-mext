#
# +Numeric+
#
# extensions that apply to any number
#
class Numeric

  #
  # +DEFAULT_PITCH_FORK+ is our 'A' (or +La+) standard
  #
  DEFAULT_PITCH_FORK = 440.0
  MIDI_PITCH_FORK    = 69.0
  #
  # 
  @@pitch_fork = DEFAULT_PITCH_FORK

  class << self

    #
    # +pitch_fork=(value)+: sets the current tuning
    #
    def pitch_fork=(value)
      @@pitch_fork = value
    end

    #
    # +pitch_fork(value)+: gets the current tuning
    #
    def pitch_fork
      @@pitch_fork
    end

    #
    # +reset_pitch_fork+: resets the pitch fork to its default
    #
    def reset_pitch_fork
      @@pitch_fork = DEFAULT_PITCH_FORK
    end

  end

end
