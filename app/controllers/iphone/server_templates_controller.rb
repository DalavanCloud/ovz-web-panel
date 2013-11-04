class Iphone::ServerTemplatesController < Iphone::Base
  before_filter :superadmin_required

  def list
    @page_title = t('admin.hardware_servers.top_toolbar.server_templates')

    hardware_server = HardwareServer.find_by_id(params[:hardware_server_id])
    redirect_to(:controller => 'hardware_servers', :action => 'list') and return if !hardware_server

    @server_templates = server_templates_list(hardware_server)
  end

end
