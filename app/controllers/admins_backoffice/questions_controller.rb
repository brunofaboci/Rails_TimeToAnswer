class AdminsBackoffice::QuestionsController < AdminsBackofficeController
  before_action :set_question, only: [:edit, :update, :destroy] 
  before_action :get_subjects, only: [:new, :edit]
  
  def index
    @questions = Question.includes(:subject).page(params[:page])
  end

  def edit
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(params_question)
    if @question.save
      redirect_to admins_backoffice_questions_path, notice: "Create Successful!"
    else
      render :new
    end
  end

  def update
    if @question.update(params_question)
      redirect_to admins_backoffice_questions_path, notice: "Update Successful!"
    else
      render :edit
    end
  end

  def destroy
    if @question.destroy
      redirect_to admins_backoffice_questions_path, notice: "Destroy Successful!"
    else
      render :index
    end
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def params_question
    params.require(:question).permit(:description, :subject_id, 
      answers_attributes: [:id, :description, :correct, :_destroy]) 
  end

  def get_subjects
    @subjects = Subject.all
  end
  
end
