class FacturationController < ApplicationController

    def index
        @project = Project.find(params[:project_id])
        @users = User.all
        @members = Member.where(:project_id => @project[:id])
        @facturations = Facturation.all


        @current = User.current
        month_to_show = DateTime.new(DateTime.now.year, DateTime.now.month, 1)
        @time_entries = TimeEntry.where(:tmonth => month_to_show.month, :tyear => month_to_show.year, :project_id => @project[:id])
    end
end