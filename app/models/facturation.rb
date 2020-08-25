class Facturation < ActiveRecord::Base

    # Si no coloco belongs_to ActiveRecord me dejara crear un 
    #facturation sin project_id ni user_id
    # Obliga a que para que se cree un facturarion
    #, se necesita si o si de un Project_id y un project_assigned_users_id
    # Tampoco reconocera .project() como un metodo
    belongs_to :project
    belongs_to :project_assigned_users

    @facturation_assigned = Facturation.all


end
