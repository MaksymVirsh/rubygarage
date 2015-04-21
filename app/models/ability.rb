# Ability
class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    @user = user

    if user
      user_abilities
    else
      guest_abilities
    end
  end

  def guest_abilities
    cannot :manage, :all
  end

  def user_abilities
    guest_abilities

    can :create, [Project, Task, Comment]

    can :read, Project, user: user
    can :update, Project, user: user
    can :destroy, Project, user: user

    can :read, Task, project: { user: user }
    can :update, Task, project: { user: user }
    can :destroy, Task, project: { user: user }
    can :done, Task, project: { user: user }
    can :sort, Task, project: { user: user }
    can :deadline, Task, project: { user: user }

    can :destroy, Comment, task: { project: { user: user } }
  end
end
