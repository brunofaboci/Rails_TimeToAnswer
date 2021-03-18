class UserStatistic < ApplicationRecord
  belongs_to :user

  def total_questions
    self.right_question + self.wrong_question
  end

  def self.set_statistic(answer, current_user)
    if !!current_user # ! é negação | uma ! nega a resposta, que seria true, transformando em um New, e a segunda ! nega novamente, voltando a ser true
      user_statistic = UserStatistic.find_or_create_by(user: current_user)
      answer.correct? ? user_statistic.right_question += 1 : user_statistic.wrong_question += 1
      user_statistic.save
    end
  end
end
