class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :set_timezone

  def set_timezone
    if current_user
      Time.zone = current_user.time_zone
    end
  end
  
  def initialize_map
    @map = Cartographer::Gmap.new( 'map' )    
    @map.controls << :type
    @map.controls << :large
    @map.controls << :scale
    @map.controls << :overview
    @map.debug = false 
    @map.marker_mgr = false
    @map.marker_clusterer = true
    if current_user && current_user.latitude
      @map.center = [current_user.latitude, current_user.longitude]
      @map.zoom = 13
    else
      @map.center = [-41.2924945, 174.7732353]
      @map.zoom = 4
    end

    cluster_icons = []


    org = Cartographer::ClusterIcon.new({:marker_type => "Organization"})
    org << {
              :url => '/images/drop.gif',
              :height => 73,
               :width => 118,
              :opt_anchor => [10, 0],
              :opt_textColor => 'black'
            }
    #push second variant
    org << {
              :url => '/images/drop.gif',
              :height => 73,
              :width => 118,
              :opt_anchor => [20, 0],
              :opt_textColor => 'black'
            }

    #push third variant
    org << {
              :url => '/images/drop.gif',
              :height => 73,
              :width => 118,
              :opt_anchor => [26, 0],
              :opt_textColor => 'black'
          }
    cluster_icons << org

    @map.marker_clusterer_icons = cluster_icons
    
    shadow_url = '/images/markers/shadow.png'
    
    @lost = Cartographer::Gicon.new(
        :name => 'lost',
        :image_url => '/images/markers/redblank.png',
        :shadow_url => shadow_url,
        :width => 27,
        :height => 27,
        :shadow_width => 51,
        :shadow_height => 37,
        :anchor_x => 15,
        :anchor_y => 29,
        :info_anchor_x => 0,
        :info_anchor_x => 1)
        
     @found = Cartographer::Gicon.new(
        :name => 'found',
        :image_url => '/images/markers/greenblank.png',
        :shadow_url => shadow_url,
        :width => 27,
        :height => 27,
        :shadow_width => 51,
        :shadow_height => 37,
        :anchor_x => 15,
        :anchor_y => 29,
        :info_anchor_x => 5,
        :info_anchor_x => 1)
     @map.icons << @lost
     @map.icons << @found
    return @map
   end
  
  
end
