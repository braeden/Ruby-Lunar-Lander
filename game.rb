require 'ray'
#Define Window Title
Ray.game "Lunar Lander" do
  register { add_hook :quit, method(:exit!) }
  scene :square do
    @lander = Ray::Polygon.new#, Ray::Color.white
    @lander.pos = [200,0]
    @lander.filled   = false
    @lander.outlined = true
    @lander.outline = Ray::Color.white
    #
    @lander.add_point([0,10])
    @lander.add_point([0,0])
    @lander.add_point([5,-5])

    @lander.add_point([10,0])
    @lander.add_point([10,10])
    @flame = Ray::Polygon.new
    @flame.add_point([7,10])
    @flame.add_point([5,10])
    @flame.add_point([3,10])
    #@lander[6].pos += [0,5]
    @fuel = 5000
    @score = 0
    @fuel_empty = "false"
    #@sound = sound "rocket.mp3"
    @xvel = 0
    @yvel = 0
    @angle = 0#@lander.angle
    @map = Ray::Polygon.new
    @map.outline_width = 2
    @map.filled   = false
    @map.outlined = true
    @map.add_point([0, 500])
    xmap=0
    21.times do
      xmap=xmap+30
      @map.add_point([xmap, rand(100)+300])
    end
    slopit=0
    @slope=[]
=begin
    21.times do
      a_x << @map[slopit].pos.x
      a_y << @map[slopit].pos.y
      b_x << @map[slopit+1].pos.x
      b_y << @map[slopit+1].pos.y

      slopit += 1
      puts @slope.inspect
    end
=end
    @map.add_point([window.size.width, 500])
    on :key_press, key(:q){ exit! }

    always do
      @angle += 1 if holding?(:right)
      @angle -= 1 if holding?(:left)
      @flame.pos = @lander.pos
      @flame.angle = @lander.angle
      if holding?(:up)
        if @fuel_empty=="false"
          @yvel -= 0.02
          if @flame[1].pos.y < @flame[0].pos.y+20
            @flame[1].pos += [0,0.3]
          end
          if @fuel > 0
            @fuel -= 1
          else
            @fuel_empty = "true"
          end
        end
        #@sound.play
      end
      @yvel += 0.01
      if @flame[1].pos.y > @lander[4].pos.y
        @flame[1].pos -= [0, 0.1]
      end
      #@xvel
      #gravity
      #@xvel = @angle/360
      @lander.pos += [@xvel, @yvel]
      @lander.angle = @angle
    #  if @lander.collide?(@map)
    #    @col="true"
    #  end
    #  @sound.pause
    #  if [@lander.pos.x, @lander.pos.y, 100, 100].to_rect.collide?(@map)
    #    puts "Collide"
    #  end
    end
    render do |win|
      if @fuel_empty == "true"
        win.draw text("Out of Fuel", :at => [100,100], :size => 20)
        win.draw @lander
        win.draw @map
        win.draw text("Y vel:" + @yvel.round(2).to_s, :at => [10,10], :size => 20)
        win.draw text("X vel:" + @xvel.round(2).to_s, :at => [10,30], :size => 20)
        win.draw text("Angle:" + @angle.to_s, :at => [550,10], :size => 20)
        win.draw text("Fuel:" + @fuel.to_s, :at => [200,10], :size => 20)
      else
        win.draw @lander
        win.draw @map
        win.draw @flame
        win.draw text("Y vel:" + @yvel.round(2).to_s, :at => [10,10], :size => 20)
        win.draw text("X vel:" + @xvel.round(2).to_s, :at => [10,30], :size => 20)
        #win.draw text("Altitude:" + @lander.pos.y.round(2).to_s, :at => [520,50], :size => 20)
        win.draw text("Angle:" + @angle.to_s, :at => [550,10], :size => 20)
        win.draw text("Score:" + @score.to_s, :at => [550,30], :size => 20)
        win.draw text("Fuel:" + @fuel.to_s, :at => [200,10], :size => 20)
      end
    end
  end
  scenes << :square
end
