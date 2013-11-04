class Iphone::OsTemplatesController < Iphone::Base
  before_filter :superadmin_required

  def list
    @page_title = t('admin.hardware_servers.top_toolbar.os_templates')

    hardware_server = HardwareServer.find_by_id(params[:hardware_server_id])
    redirect_to(:controller => 'hardware_servers', :action => 'list') and return if !hardware_server

    @os_templates = os_templates_list(hardware_server)
  end

end
