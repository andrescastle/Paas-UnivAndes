class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities

    user ||= User.new # guest user
    if user.role? :nivel_0
      can :manage, [Rol, TipoRecurso, TipoArtefacto, Organizacion, TipoPlantilla, Plantilla, TipoOrganizacion]
    end
    if user.role? :nivel_3
      can :manage, [Tarea, TareaParticipante]
    end
    if user.role? :nivel_2
      can :manage, [Proyecto, Recurso, Usuario, Artefacto]
    end
    if user.role? :nivel_1
      can :manage, [Proyecto, Recurso, Usuario, Artefacto, Rol, TipoRecurso, TipoArtefacto, Organizacion, TipoPlantilla, Plantilla, TipoOrganizacion]
    end
  end
end
