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

    @project_facturations = Facturation.where(:project_id => @project[:id],:fecha => fecha.strftime("%Y-%m-%d"))
    puts 'FACTURATION'
    puts @project_facturations.length()
    if @project_facturations.length()==0 #si 0 no tiene otros gastos cargado antes-> agrego un gasto vacio
      @fact = Facturation.new(:project_id => @project[:id], :comentario => '', :otro_gasto => 0,:fecha => fecha.strftime("%Y-%m-%d"))
      @fact.save
      @project_facturations = Facturation.where(:project_id => @project[:id],:fecha => fecha.strftime("%Y-%m-%d"))
    end



    @all_project_members.each_with_index do |emp, index|
    #if !emp.end_date
    #    if emp.start_date <= fecha
    #      @project_active_members.push(emp)
    #    end
    #  else
    #    if (emp.start_date <= fecha) && emp.end_date > fecha
    #      @project_active_members.push(emp)
    #    end
    #  end
    # end

    if emp.end_date #if date_end is not null
      if (emp.start_date.strftime("%Y%m") <= fecha.strftime("%Y%m")) && emp.end_date.strftime("%Y%m") >= fecha.strftime("%Y%m")
        @project_active_members.push(emp)
      end
    else #if date_end is null
      if emp.start_date.strftime("%Y%m") <= fecha.strftime("%Y%m")
        @project_active_members.push(emp)
      end
    end
    end

  end


   #TODO: 
    def update_project_assigned_user_total_bill
      flag = false
      message = ''

      #month_to_show = DateTime.new(DateTime.now.year, DateTime.now.month, 1)
      #@time_entries = TimeEntry.where(:tmonth => month_to_show.month, :tyear => month_to_show.year, :project_id => @project[:id])
      #@months = TimeEntry.select('tyear, tmonth').where(:project_id => @project[:id]).group('tyear, tmonth')
      
      project_id = nil
      input_concepts = nil
      input_concepts_monto = nil
      month_val = nil
      checkbox_bloqueado = nil
      user_name_modification = User.current.lastname + ' ' + User.current.firstname
      params['rows'].each do |index, row|        
        project_id = row[:projectId]
        user_id = row[:employeeId]
        total_bill = row[:input_total_bill]
        log_comment = row[:log_comment]
        
        #last_date_modification = Date.current
        input_concepts = row[:input_concepts]
        input_concepts_monto = row[:input_concepts_monto]
        facturation_comments = row[:facturation_comments]
        checkbox_editar = row[:checkbox_editar]
        checkbox_bloqueado = row[:checkbox_bloqueado]
        month_val = row[:month_val]

        employee_to_update = ProjectAssignedUser.where(:project_id => project_id, :user_id => user_id).first
        
        
        if checkbox_editar
          employee_to_update.total = total_bill
          employee_to_update.log = log_comment
          employee_to_update.user_name_modification = user_name_modification
          employee_to_update.last_date_modification = Date.current
        end

        employee_to_update.general_comments = facturation_comments
        


        if employee_to_update.save
          flag = true
        else
          flag = false
          break
        end
      end
      
      #fecha = params[:month] ? DateTime.parse(params[:month]) : DateTime.new(DateTime.now.year, DateTime.now.month, 1)
      date_parse = Date.parse(month_val)
      @project_facturations_to_update = Facturation.where(:project_id => project_id,:fecha => date_parse.strftime("%Y-%m-%d"))
      puts 'UPDATE INVOICE'
      puts date_parse
      @project_facturations_to_update.each do |fact|

        #if not equal -> checkbox state it was change for the user
        # so I save this change in state and date of this change.
        if checkbox_bloqueado != fact.bloqueado
          fact.bloqueado = checkbox_bloqueado
          fact.last_modification_date_bloqueado = Date.current
          fact.user_name_last_mod = user_name_modification
        end

        fact.comentario = input_concepts
        fact.otro_gasto = input_concepts_monto
        fact.save
      end

     



      if flag
        message = "Se guardaron los cambios"
      else
        message = "Se produjo un error al intentar guardar los cambios"      
      end
      render json: {message: message}
    end


end