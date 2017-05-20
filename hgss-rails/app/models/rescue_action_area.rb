class RescueActionArea < ApplicationRecord
  belongs_to :rescue_action

  def map_url
  	coordinates = JSON.parse(points)
  	polygon_part = "path=color:0x00000000|weight:5|fillcolor:0xAA2643|"

  	polygon_part << coordinates.map do |c|
  		"#{c["lat"]},#{c["lng"]}"
  	end.join("|")

  	"https://maps.googleapis.com/maps/api/staticmap?center=#{latitude},#{longitude}&zoom=#{zoom_level}&size=250x200&maptype=roadmap
&#{polygon_part}&key=AIzaSyBiW2d-FSKStrfYWSzxC2SAw_HUFssLWE4"
  end
end
