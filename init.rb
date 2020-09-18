Redmine::Plugin.register :facturacion_proyecto do
  name 'Facturacion Proyecto plugin'
  author 'Folder IT'
  description 'Este plugin permite la facturacion de los proyectos'
  version '0.0.1'

  project_module :facturacion_proyecto do
    permission :view_facturacion, :facturation => :index
    permission :administrativo_facturacion, :facturation => :administrativo_facturacion
  end

  menu :project_menu, :facturation, { :controller => 'facturation', :action => 'index' }, :caption => 'Facturacion proyecto', :after => :proformanext, :param => :project_id
end
