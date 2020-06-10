class FacturationController < ApplicationController

  def index
    @project = Project.find(params[:project_id])
    @facturations = Facturation.all
    @empleados_facturation = ProjectAssignedUser.where(:project_id => @project[:id])
       

    #@current = User.current
    month_to_show = DateTime.new(DateTime.now.year, DateTime.now.month, 1)
    @time_entries = TimeEntry.where(:tmonth => month_to_show.month, :tyear => month_to_show.year, :project_id => @project[:id])
    @months = TimeEntry.select('tyear, tmonth').where(:project_id => @project[:id]).group('tyear, tmonth')


    get_employees_by_date
  end


    
  def get_employees_by_date
    fecha = params[:month] ? DateTime.parse(params[:month]) : DateTime.new(DateTime.now.year, DateTime.now.month, 1)
    
    @all_project_members = ProjectAssignedUser.where(:project_id => @project[:id])
    @project_active_members = []

    @all_project_members.each_with_index do |emp, index|
      if !emp.end_date
        if emp.start_date <= fecha
          @project_active_members.push(emp)
        end
      else
        if (emp.start_date <= fecha) && emp.end_date > fecha
          @project_active_members.push(emp)
        end
      end
    end
  end
end