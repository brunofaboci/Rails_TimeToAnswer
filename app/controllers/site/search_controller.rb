class Site::SearchController < SiteController
  def questions
    @questions = Question.finder(params[:page], params[:term])
  end

  def subject
    @questions = Question.finder_subject(params[:page], params[:subject_id])
  end
  
end