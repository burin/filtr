module Filtr
  class Image
    attr :file_path
    attr :path
    attr :mask
    attr :vignette_mask

    def initialize(file_path)
      @file_path = File.expand_path(file_path)
      @path = @file_path.chomp(File.extname(@file_path))+"-lomo.png"
      @mask = @file_path.chomp(File.extname(@file_path))+"-mask.png"
      @vignette_mask = File.join(File.dirname(__FILE__), "assets", "vignette.png")
    end

    class << self

      def lomo(file_path)
        image = self.new(file_path)
        dimensions = "800x600"
        `cp #{image.file_path} #{image.path}`
        `convert -resize 800x600\\> #{image.path} #{image.path}`
        dimensions = `identify -format '%wx%h' #{image.path}`.split("\n")[0]
        `convert -unsharp 1.5x1.5 #{image.path} #{image.path}`
        `convert -contrast -contrast #{image.path} #{image.path}`
        `convert -modulate 100,120 #{image.path} #{image.path}`
        `convert -resize #{dimensions}\\! #{image.vignette_mask} #{image.mask}`
        `composite -compose multiply #{image.mask} #{image.path} #{image.path}`
        return image
      end

      def postcard(file_path)
        image = self.new(file_path)
        `cp #{image.file_path} #{image.path}`
        `convert -size 800x600\\> -contrast -modulate 100,150 -gaussian 1x2 +matte #{image.path} #{image.mask}`
        `convert -gaussian 0x5 -modulate 180,150 #{image.mask} #{image.mask}`
        `convert -resize 800x600\\> -unsharp 1.5x1.5 -modulate 175,100 -contrast -contrast -contrast #{image.path} #{image.path}`
        `convert -gaussian 1x2 #{image.path} #{image.path}`
        `composite -compose multiply #{image.mask} #{image.path} #{image.path}`
        return image
      end

      def rockstar(file_path)
        image = self.new(file_path)
        `cp #{image.file_path} #{image.path}`
        `convert -resize 800x600\\> -unsharp 1.5x1.5 -modulate 175,150 -contrast -contrast -contrast #{image.path} #{image.path}`
        `convert -gaussian 1x2 #{image.path} #{image.path}`
        `convert -depth 16 -colorspace GRAY -contrast -sharpen 5x5 #{image.path} #{image.path}`
        return image
      end

      def dazed(file_path)
        image = self.new(file_path)
        `cp #{image.file_path} #{image.path}`
        `convert  -resize 800x600\\> -unsharp 1.5x1.5 -modulate 175,150 -contrast -contrast -contrast #{image.path} #{image.path}`
        `convert -gaussian 1x2 #{image.path} #{image.path}`
        return image
      end

      def julee(file_path)
        image = self.new(file_path)
        `cp #{image.file_path} #{image.path}`
        `convert -resize 800x600\\> #{image.path} #{image.path}`
        `convert -gaussian 1x2 +matte #{image.path} #{image.mask}`
        `convert -gaussian 0x5 -contrast -modulate 100,60 #{image.mask} #{image.mask}`
        `convert -modulate 100,60 #{image.path} #{image.path}`
        `convert -contrast #{image.path} #{image.path}`
        `composite -compose screen #{image.mask} #{image.path} #{image.path}`
        `convert -modulate 125,200 #{image.path} #{image.path}`
        return image
      end

    end
  end
end