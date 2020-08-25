class ProjectAssignedUser < ActiveRecord::Base
    belongs_to :project
    belongs_to :user

    # Tengo que decirle a ProjectAssignedUser como usar la tabla facturations
    has_many :facturations
end