# frozen_string_literal: true

class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    @user = user
    if user
      user.admin? ? admin_abilities : user_abilities
    else
      guest_abilities
    end
  end

  def guest_abilities
    can :read, :all
  end

  def user_abilities
    guest_abilities
    can :update_best, Answer do |answer|
      @user.author_of?(answer.question)
    end 
    can [:me, :other_profiles], User
    can :destroy, [Question, Answer], { author_id: @user.id }
    can :destroy, Link, linkable: { author_id: @user.id }
    can :destroy, Comment, { user_id: @user.id }
    can :create, [Question, Answer, Link]
    can :create_comment, [Question, Answer]
    can :update, [Answer, Question], author_id: @user.id
    can :update, Comment, user_id: @user.id
    can [:vote_up, :vote_down, :vote_cancel], Question do |question|
      !@user.author_of?(question)
    end 
    can [:vote_up, :vote_down, :vote_cancel], Answer do |answer|
      !@user.author_of?(answer)
    end
  end

  def admin_abilities
    can :manage, :all
  end
end
