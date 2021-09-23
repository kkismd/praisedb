# coding: utf-8
class Song < ActiveRecord::Base
  include Discard::Model

  has_many :song_edits

  # ふりがな処理のための正規表現
  KANJI_KANA = /([一-龠々]+)\(([ぁ-ん]+)\)/ # 漢字 ⇒ ひらがな
  ENG_KANA = /([a-zA-Z']+)\(([ァ-ヶー]+)\)/ # 英語 ⇒ カタカナ
  KANA_HIRA = /([ァ-ヴー]+)\(([ぁ-んー]+)\)/ # カタカナ ⇒ ひらがな
  NOT_WORDS = /[^a-zA-Z一-龠々ぁ-んァ-ヶ々ー ]/ # 英字、漢字、ひらがな、カタカナ 半角空白 以外の文字

  def self.code_options
    %w(A Ab Bb C Cm D E  Eb Em F  F#m Fm G)
  end

  def self.recents(home_id)
    kept.where(home_id: home_id).order('updated_at DESC').limit(10)
  end

  # バックアップファイルを作りそのフォルダーを返す
  # @return [Pathname] バックアップを作成したフォルダ
  def self.backup
    archive_name = 'songs'
    folder = Rails.root.join('tmp', archive_name)
    folder.rmtree if folder.exist?
    folder.mkpath
    kept.find_each do |song|
      file_name = "#{song.id}_#{song.fs_safe_title}.txt"
      path = Rails.root.join('tmp', archive_name, file_name)
      path.open('w') do |f|
        f.write(song.words)
        f.sync
        f.close
      end
    end
    folder
  end

  def fs_safe_title
    title.gsub(NOT_WORDS, '').gsub(/ +/, '_')
  end

  # テキストファイルにメタ情報を入れる場合に使うメソッド
  def text_format
    <<~END_OF_FORMAT
    ----
    id: #{id}
    code: #{code}
    title: "#{title}"
    cright: "#{cright}"
    last_update: #{updated_at.to_s(:db)}
    ----

    #{words}
    END_OF_FORMAT
  end

  # 空行で区切られたテキストをグループとする
  def phrases
    normalize_eol(words.to_s).split(/\n{2,}/)
  end

  # グループの一行目だけを返す
  def outline
    phrases.map{ |string| string.gsub(/\n.*/, '') }
  end

  def kanji
    kanjinize(words)
  end

  def kana
    kananize(words)
  end

  def update_words_for_search!
    self[:words_for_search] = ruby_trim(kanji + kana)
  end

  def ruby_trim(str)
    str.gsub(/\s+/, ' ').gsub(NOT_WORDS, '')
  end

  def romanize!
    return unless has_furigana?

    converter = RomanConverter.new
    result = StringIO.new
    normalize_eol(words).each_line do |line|
      if furigana?(line)
        result <<  line + converter.to_roman(kananaize_with_space(line))
      else
        result << line
      end
    end
    self.words = result.string
  end

  def has_furigana?
    furigana?(words)
    words =~ KANJI_KANA || words =~ ENG_KANA || words =~ KANA_HIRA
  end

  def build_edits
    song_edits.build words: words
  end

  def update_with(is_roman_button, new_attributes)
    is_saved = nil
    self.class.transaction do
      build_edits
      self.attributes = new_attributes
      romanize! if is_roman_button
      update_words_for_search!
      is_saved = save
    end
    is_saved
  end

  private def furigana?(str)
    str =~ KANJI_KANA || str =~ ENG_KANA || str =~ KANA_HIRA
  end

  private def kanjinize(str)
    str.
        gsub(KANJI_KANA){$1}.
        gsub(ENG_KANA){$1}.
        gsub(KANA_HIRA){$1}
  end

  private def kananize(str)
    str.
        gsub(KANJI_KANA){$2}.
        gsub(ENG_KANA){$1}.
        gsub(KANA_HIRA){$1}
  end

  private def kananaize_with_space(str)
    str.
        gsub(KANJI_KANA){' ' + $2 + ' '}.
        gsub(ENG_KANA){' ' + $1 + ' '}.
        gsub(KANA_HIRA){' ' + $1 + ' '}
  end

  private def normalize_eol(str)
    str.gsub(/\r\n/,"\n").gsub(/\r/, "\n")
  end
end