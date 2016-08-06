module TracksHelper
  def ugly_lyrics(lyrics)
    lyrics = lyrics.split(".")
    lyrics[0] = " #{lyrics.first}"
    lyrics.map!{|l| "♫ #{l}"}
    "<pre>#{lyrics.join(". \n")}</pre>".html_safe
  end
end
