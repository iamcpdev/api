# frozen_string_literal: true

class NewClubApplicationPolicy < ApplicationPolicy
  def show?
    user.admin? || user_added?
  end

  def update?
    if user.admin?
      true
    else
      user_added?
    end
  end

  def add_user?
    user_added?
  end

  def remove_user?
    user_added? && record.point_of_contact == user
  end

  def submit?
    user_added?
  end

  def unsubmit?
    user.admin?
  end

  def accept?
    user.admin?
  end

  private

  def user_added?
    record.users.exists? user.id
  end
end
