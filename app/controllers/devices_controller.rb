class DevicesController < ApplicationController
  
  def update
    @device = Device.find_or_create_by_apid(params[:device][:apid])

    respond_to do |format|
      if @device.update_attributes(params[:device])
        format.html { redirect_to(@device, :notice => 'Device was successfully updated.') }
      else
        format.html { render :status => 500 }
      end
    end
  end

end
