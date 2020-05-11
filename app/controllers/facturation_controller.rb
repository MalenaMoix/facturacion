class FacturationController < ApplicationController

    def index
        @project = Project.find(params[:project_id])

        @users = User.all

        @members = @project.members.all

        @facturations = Facturation.all

        ids = []
        for @member in @members
         ids.push @member[:user_id]
        end

        @empleados = User.where(id: ids)
       

        @current = User.current
        month_to_show = DateTime.new(DateTime.now.year, DateTime.now.month, 1)
        @time_entries = TimeEntry.where(:tmonth => month_to_show.month, :tyear => month_to_show.year, :project_id => @project[:id])
        @months = TimeEntry.select('tyear, tmonth').where(:project_id => @project[:id]).group('tyear, tmonth')
    end
end