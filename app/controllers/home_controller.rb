class HomeController < ApplicationController
  def index
    @recently_added = Item.order(created_at: :desc).limit(10)
    @recently_returned = Loan.order('returned_at NOT NULL').order(returned_at: :desc).limit(10)

    if can? :manage, Loan
      @overdue = Loan.where('due_at IS NOT NULL and due_at < ?', Time.now).order(due_at: :desc)
    end
  end
end
