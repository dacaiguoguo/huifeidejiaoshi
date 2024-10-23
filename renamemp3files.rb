require 'fileutils'

def rename_mp3_files(directory)
  Dir.glob(File.join(directory, '**', '*.mp3')).each do |file|
    basename = File.basename(file, '.mp3')
    unless basename.include?('会飞的教室')
      new_name = File.join(File.dirname(file), "#{basename}会飞的教室.mp3")
      FileUtils.mv(file, new_name)
      puts "已重命名: #{file} -> #{new_name}"
    end
  end
end

# 使用示例
puts "请输入要处理的文件夹路径："
directory = gets.chomp

if Dir.exist?(directory)
  rename_mp3_files(directory)
  puts "处理完成。"
else
  puts "错误：指定的文件夹不存在。"
end
