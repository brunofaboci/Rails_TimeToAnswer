module SiteHelper

  def msg_main
    case params[:action]
    when 'index'
      "Last questions..."
    when 'questions'
      "Results for the term #{params[:term]}...}"
    when 'subject'
      "displaying issues by subject #{params[:subject]}..."
    end
  end

end