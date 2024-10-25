require "mp3info"

def add_cover_to_mp3(mp3_file, cover_image, album_name, artist, genre)
  Mp3Info.open(mp3_file) do |mp3|
    # 读取封面图像文件
    cover_data = File.binread(cover_image)
    # 将封面图像数据添加到ID3v2标签
    mp3.tag2.add_picture(cover_data)
    # 设置专辑名称
    mp3.tag.album = album_name
    # 设置艺术家
    mp3.tag.artist = artist
    # 设置流派
    mp3.tag.genre = 2
  end
  puts "已为 #{mp3_file} 添加封面 #{cover_image}，专辑名 '#{album_name}'，艺术家 '#{artist}'，流派 '#{genre}'"
rescue => e
  puts "处理 #{mp3_file} 时出错: #{e.message}"
end

def process_directory(directory, cover_image, album_name, artist, genre)
  Dir.foreach(directory) do |filename|
    next unless filename.end_with?(".mp3")

    mp3_file_path = File.join(directory, filename)
    add_cover_to_mp3(mp3_file_path, cover_image, album_name, artist, genre)
  end
end

if __FILE__ == $0
  mp3_directory = "/Users/yanguosun/Developer/huifeidejiaoshi"  # 替换为MP3文件所在的目录
  cover_image_path = "/Users/yanguosun/Developer/huifeidejiaoshi/huifei.png"  # 替换为封面图片路径
  album_name = "会飞的教室"  # 设置专辑名称
  artist = "陈亮"  # 设置艺术家名称
  genre = "故事"  # 设置流派名称

  process_directory(mp3_directory, cover_image_path, album_name, artist, genre)
end
