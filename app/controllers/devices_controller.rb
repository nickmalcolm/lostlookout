class DevicesController < ApplicationController
  skip_before_filter :set_timezone
  
  def register
    unless params.nil? || params["apid"].nil?
      @device = Device.find_by_apid(params["apid"])
      if @device.nil?
        if Device.create!(:apid => params[:apid], :area => params[:area])
          head :ok
        end
      else 
        if @device.update_attributes(:area => params["area"])
          head :ok
        end
      end
    else
      render :text => "Error", :status => 500
    end
  end

end
