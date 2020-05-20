class FacturationController < ApplicationController

    def index
        @project = Project.find(params[:project_id])
        @facturations = Facturation.all
        @empleados_facturation = ProjectAssignedUser.where(:project_id => @project[:id])
       

        @current = User.current
        month_to_show = DateTime.new(DateTime.now.year, DateTime.now.month, 1)
        @time_entries = TimeEntry.where(:tmonth => month_to_show.month, :tyear => month_to_show.year, :project_id => @project[:id])
        @months = TimeEntry.select('tyear, tmonth').where(:project_id => @project[:id]).group('tyear, tmonth')
    end
end