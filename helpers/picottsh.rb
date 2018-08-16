# this plugin requiers SVOXs Pico text to speech engine installed
# pico2wave --lang de-DE --wave ./test.wav "Hier folgt der Test-Text"

class PicoTTSHelper
  private

  @@lang = {}
  PICO = "pico2wave"
  LANG = " --lang "
  WAVE = " --wave "

  FFMPEG = "ffmpeg -loglevel quiet -y -i "
  FF_PARA = " -vn -ar 44100 -ac 2 -ab 192k -f mp3 -metadata title=\"picotts\"" \
  "-metadata artist=\"picotts\" "

  FILE = "picotts.wav"
  OUTPUT_FILE = "picotts.mp3"
  RM = "rm "
  QUIET = " > /dev/null 2>&1"

  def init_languages
    @@lang["de"] == "de-DE"
    @@lang["uk"] == "en-UK"
    @@lang["us"] == "en-US"
    @@lang["es"] == "es-ES"
    @@lang["fr"] == "fr-FR"
    @@lang["it"] == "it-IT"
  end

  public

  def initialize(path, message, lang)
    if @@lang[lang].to_s.empty?
      lang = "en-US"
    end
    @create = PICO + LANG + lang + WAVE + path + FILE + " \"" + message + "\""
    @audio = FFMPEG + path + FILE + FF_PARA + path + OUTPUT_FILE
    @delete = RM + path + FILE
  end

  def getFileName
    return OUTPUT_FILE
  end

  def load
    puts(@create)
    system(@create)
    system(@audio)
    system(@delete)
  end
end

p = PicoTTSHelper.new("~/music/", "Hallo Welt du bist super", "de-DE")
p.load
